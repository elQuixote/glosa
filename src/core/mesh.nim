from ./concepts import
  Equals,
  Hash,
  Transform,
  Dimension,
  Copy,
  String,
  Centroid,
  Shape2,
  Closest,
  Vertices

from ./types import
  Vector1,
  Vector2,
  Vector3,
  Vector4,
  MeshVertex,
  MeshFace,
  HalfEdge,
  HalfEdgeMesh

from ./errors import
  InvalidVertexError,
  InvalidFaceError,
  InvalidEdgeError,
  InvalidOperationError

export
  Equals,
  Hash,
  Transform,
  Dimension,
  Copy,
  String,
  Centroid,
  Shape2,
  Closest,
  Vertices,
  MeshVertex,
  MeshFace,
  HalfEdge,
  HalfEdgeMesh

from ./Vector import
  `-`,
  `+=`,
  distanceTo,
  clearCopy,
  cross,
  normalize,
  `$`,
  rotate,
  scale,
  translate,
  transform

from ./Path import
  polyline,
  closestPoint,
  average

from ./Polygon import
  polygon,
  centroid,
  perimeter,
  area

import oids
from sequtils import concat, toSeq, map, filter

import hashes

# Constructors
proc meshVertex*[Vector](position: Vector, edge: HalfEdge[Vector]): MeshVertex[Vector] =
  result = MeshVertex[Vector](oid: genOid(), position: position, edge: edge)

proc meshFace*[Vector](edge: HalfEdge[Vector]): MeshFace[Vector] =
  result = MeshFace[Vector](oid: genOid(), edge: edge)

proc halfEdge*[Vector](vertex: MeshVertex[Vector], face: MeshFace[Vector], pair, next, previous: HalfEdge[Vector]): HalfEdge[Vector] =
  result = HalfEdge[Vector](oid: genOid(), vertex: vertex, face: face, pair: pair, next: next, previous: previous)

# Forward Declarations
proc isBoundary*[Vector](m: HalfEdgeMesh[Vector], halfEdge: HalfEdge[Vector]): bool
proc endVertex*[Vector](m: HalfEdgeMesh[Vector], halfEdge: HalfEdge[Vector]): MeshVertex[Vector]
proc containsHalfEdge*[Vector](m: HalfEdgeMesh[Vector], startVertex, endVertex: MeshVertex[Vector]): bool
proc findHalfEdge*[Vector](m: HalfEdgeMesh[Vector], startVertex, endVertex: MeshVertex[Vector]): HalfEdge[Vector]
proc addPair*[Vector](m: var HalfEdgeMesh[Vector], startVertex, endVertex: MeshVertex[Vector], face: MeshFace[Vector]): HalfEdge[Vector]

# Implementations
# Accessors
# Traverses clockwise around the starting vertex of a halfedge
iterator vertexCirculator*[Vector](m: HalfEdgeMesh[Vector], halfEdge: HalfEdge[Vector]): HalfEdge[Vector] =
  block:
    var h = halfEdge
    while true:
      if not contains(m.edges, h):
        # Next edge is not in the mesh
        break
      if isNil(h):
        # Next edge is not set
        break
      yield h
      h = h.pair.next
      if h == halfEdge:
        break

iterator faceCirculator*[Vector](m: HalfEdgeMesh[Vector], halfEdge: HalfEdge[Vector]): HalfEdge[Vector] =
  block:
    var h = halfEdge
    while true:
      if not contains(m.edges, h):
        # Next edge is not in the mesh
        break
      if isNil(h):
        # Next edge is not set
        break
      yield h
      h = h.next
      if h == halfEdge:
        break

iterator halfEdgeCirculator*[Vector](m: HalfEdgeMesh[Vector], vertex: MeshVertex[Vector]): HalfEdge[Vector] =
  block:
    let firstHalfEdge = vertex.edge
    if not contains(m.vertices, vertex):
      # Vertex is not in the mesh
      break
    if (isNil(firstHalfEdge)):
      # Vertex does not have an edge
      break
    var h = firstHalfEdge
    while true:
      if (isNil(h)):
        # Next edge is not set
        break
      yield h
      h = h.pair.next
      if h == firstHalfEdge:
        break

iterator halfEdgeCirculator*[Vector](m: HalfEdgeMesh[Vector], vertex: MeshVertex[Vector], halfEdge: HalfEdge[Vector]): HalfEdge[Vector] =
  block:
    if not contains(m.vertices, vertex):
      # Vertex is not in the mesh
      break
    if not contains(m.edges, halfEdge):
      # Edge is not in the mesh
      break
    if halfEdge.vertex != vertex:
      # Edge does not start at the vertex
      break
    for h in halfEdgeCirculator(m, halfEdge.vertex):
      yield h

# Helpers
proc makeConsecutive[Vector](previous, next: HalfEdge[Vector]) =
  previous.next = next
  next.previous = previous

# Other
proc halfEdgeMesh*[Vector](): HalfEdgeMesh[Vector] =
  result = HalfEdgeMesh[Vector](
    vertices: newSeq[MeshVertex[Vector]](0),
    faces: newSeq[MeshFace[Vector]](0),
    edges: newSeq[HalfEdge[Vector]](0)
  )

proc length*[Vector](m: HalfEdgeMesh[Vector], halfEdge: HalfEdge[Vector]): float =
  result = distanceTo(halfEdge.vertex, endVertex(m, halfEdge))

proc lengths*[Vector](m: HalfEdgeMesh[Vector]): seq[float] =
  result = newSeq[float](len(m.edges))
  for i, e in pairs(m.edges):
    result[i] = length(m, e)

# Vertices
proc addVertex*[Vector](m: var HalfEdgeMesh[Vector], vertex: MeshVertex[Vector]): void =
  add(m.vertices, vertex)

proc addVertex*[Vector](m: var HalfEdgeMesh[Vector], vector: Vector): void =
  add(m.vertices, meshVertex[Vector](position: vector, edge: nil))

proc addVertices*[Vector](m: var HalfEdgeMesh[Vector], vertices: openArray[MeshVertex[Vector]]): void =
  m.vertices = concat(m.vertices, vertices)

proc outgoingHalfEdges*[Vector](m: HalfEdgeMesh[Vector], vertex: MeshVertex[Vector]): seq[HalfEdge[Vector]] =
  result = toSeq(vertexCirculator(m, vertex.edge))

proc incomingHalfEdges*[Vector](m: HalfEdgeMesh[Vector], vertex: MeshVertex[Vector]): seq[HalfEdge[Vector]] =
  result = map(outgoingHalfEdges(m, vertex), proc(halfEdge: HalfEdge[Vector]): HalfEdge[Vector] = halfEdge.pair)

proc neighbors*[Vector](m: HalfEdgeMesh[Vector], vertex: MeshVertex[Vector]): seq[MeshVertex[Vector]] =
  result = map(outgoingHalfEdges(m, vertex), proc(halfEdge: HalfEdge[Vector]): MeshVertex[Vector] = halfEdge.pair.vertex)

proc faces*[Vector](m: HalfEdgeMesh[Vector], vertex: MeshVertex[Vector]): seq[MeshFace[Vector]] =
  result = map(outgoingHalfEdges(m, vertex), proc(halfEdge: HalfEdge[Vector]): MeshFace[Vector] = halfEdge.face)

proc valence*[Vector](m: HalfEdgeMesh[Vector], vertex: MeshVertex[Vector]): int =
  result = len(vertexCirculator(m, vertex.edge))

proc isBoundary*[Vector](m: HalfEdgeMesh[Vector], vertex: MeshVertex[Vector]): bool =
  result = isNil(vertex.edge) or isNil(vertex.edge.face)

proc normal*(m: HalfEdgeMesh[Vector3], vertex: MeshVertex[Vector3]): Vector3 =
  let
    position = vertex.position
    ring = neighbors(m, vertex)
    n = len(ring)
  result = clearCopy(position)
  for i, v in pairs(ring):
    let ii = (i + 1) mod n
    result += cross(v.position - position, ring[ii].position - position)
  result = normalize(result)

proc normals*(m: HalfEdgeMesh[Vector3]): seq[Vector3] =
  result = map(m.vertices, proc(vertex: MeshVertex[Vector3]): Vector3 = normal(m, vertex))

proc positions*[Vector](m: HalfEdgeMesh[Vector]): seq[Vector] =
  result = map(m.vertices, proc(vertex: MeshVertex[Vector]): Vector = vertex.position)

# Faces
proc addFace*[Vector](m: var HalfEdgeMesh[Vector], face: MeshFace[Vector]): void =
  add(m.faces, face)

proc addFace*[Vector](m: var HalfEdgeMesh[Vector], vertices: openArray[MeshVertex[Vector]]): MeshFace[Vector] =
  let n = len(vertices)
  result = meshFace[Vector](nil)
  if n < 3:
    raise newException(InvalidFaceError,
      "Face is degenerate")
  for v in vertices:
    if not contains(m.vertices, v):
      raise newException(InvalidVertexError,
        "Mesh does not contain vertex")

  var
    loop = newSeq[HalfEdge[Vector]](n)
    created = newSeq[bool](n)
  for i in 0..<n:
    let
      v1 = vertices[i]
      v2 = vertices[(i + 1) mod n]

    let h = findHalfEdge(m, v1, v2)
    if isNil(h):
      loop[i] = addPair(m, v1, v2, result)
      created[i] = true
    elif not isNil(h.face):
      raise newException(InvalidOperationError,
        "Half-edge has a face (is non-manifold)")
    else:
      h.face = result
      loop[i] = h

  for i in 0..<n:
    let ii = (i + 1) mod n
    var
      outerNext: HalfEdge[Vector] = nil
      outerPrevious: HalfEdge[Vector] = nil
    if created[i] or created[ii]:
      if created[i] and not created[ii]:
        outerNext = loop[i].pair
        outerPrevious = loop[ii].previous
      elif not created[i] and created[ii]:
        outerNext = loop[i].next
        outerPrevious = loop[ii].pair
      elif created[i] and created[ii]:
        let v = vertices[ii]
        if not isNil(v.edge):
          outerNext = loop[i].pair
          outerPrevious = v.edge.previous
          outerNext.previous = outerPrevious
          outerPrevious.next = outerNext
          outerNext = v.edge
          outerPrevious = loop[ii].pair
        else:
          outerNext = loop[i].pair
          outerPrevious = loop[ii].pair

      if (not isNil(outerNext) and not isNil(outerPrevious)):
        outerNext.previous = outerPrevious
        outerPrevious.next = outerNext

      loop[i].next = loop[ii]
      loop[ii].previous = loop[i]

      if created[i]:
        vertices[ii].edge = loop[ii]
    else:
      if vertices[ii].edge == loop[ii]:
        for e in toSeq(vertexCirculator(m, loop[ii]))[1..^1]:
          if isNil(e.face):
            vertices[ii].edge = e
            break

      if (loop[i].next != loop[ii] or loop[ii].previous != loop[i]):
        let
          next = loop[i].next
          previous = loop[ii].previous

        try:
          let boundary = filter(toSeq(vertexCirculator(m, loop[ii]))[1..^1],
            proc(e: HalfEdge[Vector]): bool = isNil(e.face))[0]
          makeConsecutive(loop[i], loop[ii])
          makeConsecutive(boundary.previous, next)
          makeConsecutive(previous, boundary)
        except:
          raise newException(InvalidOperationError,
           "Failed to relink half-edges around vertex during face creation")
  result.edge = loop[0]

proc addFaces*[Vector](m: var HalfEdgeMesh[Vector], faces: openArray[MeshFace[Vector]]): void =
  m.faces  =concat(m.faces, faces)

# Face Operations
# NOTE: Path/Polygon operations need to be expanded, all currently empty (unfilled) face operations
proc closestPoint*[Vector](m: HalfEdgeMesh[Vector], face: MeshFace[Vector]): Vector =
  let vertices = toSeq(faceCirculator(m, face.edge))
  result = closestPoint(polyline(vertices), true)

proc centroid*[Vector](m: HalfEdgeMesh[Vector], face: MeshFace[Vector]): Vector =
  let vertices = toSeq(faceCirculator(m, face.edge))
  result = centroid(polygon(vertices))

proc average*[Vector](m: HalfEdgeMesh[Vector], face: MeshFace[Vector]): Vector =
  let vertices = toSeq(faceCirculator(m, face.edge))
  result = average(polyline(vertices), true)

proc perimeter*[Vector](m: HalfEdgeMesh[Vector], face: MeshFace[Vector]): float =
  let vertices = toSeq(faceCirculator(m, face.edge))
  result = perimeter(polygon(vertices))

proc area*[Vector](m: HalfEdgeMesh[Vector], face: MeshFace[Vector]): float =
  let vertices = toSeq(faceCirculator(m, face.edge))
  result = area(polygon(vertices))

# Edges
proc addEdge*[Vector](m: var HalfEdgeMesh[Vector], halfEdge: HalfEdge[Vector]): void =
  add(m.edges, halfEdge)

proc addEdges*[Vector](m: var HalfEdgeMesh[Vector], halfEdges: openArray[HalfEdge[Vector]]): void =
  m.edges = concat(m.edges, @halfEdges)

proc addPair*[Vector](m: var HalfEdgeMesh[Vector], startVertex, endVertex: MeshVertex[Vector], face: MeshFace[Vector]): HalfEdge[Vector] =
  result = halfEdge[Vector](startVertex, face, nil, nil, nil)
  var halfEdge2 = halfEdge[Vector](endVertex, nil, result, nil, nil)
  result.pair = halfEdge2
  addEdges(m, @[result, halfEdge2])

proc isBoundary*[Vector](m: HalfEdgeMesh[Vector], halfEdge: HalfEdge[Vector]): bool =
  if not contains(m.edges, halfEdge):
    raise newException(InvalidHalfEdgeError,
      "Mesh does not contain this half-edge")
  result = isNil(halfEdge.face) or isNil(halfEdge.pair.face)

proc endVertex*[Vector](m: HalfEdgeMesh[Vector], halfEdge: HalfEdge[Vector]): MeshVertex[Vector] =
  if not contains(m.edges, halfEdge):
    raise newException(InvalidHalfEdgeError,
      "Mesh does not contain this half-edge")
  result = halfEdge.pair.vertex

proc containsHalfEdge*[Vector](m: HalfEdgeMesh[Vector], startVertex, endVertex: MeshVertex[Vector]): bool =
  for he in vertexCirculator(m, startVertex.edge):
    if endVertex == he.pair.vertex:
      result = true
      break

proc findHalfEdge*[Vector](m: HalfEdgeMesh[Vector], startVertex, endVertex: MeshVertex[Vector]): HalfEdge[Vector] =
  for he in vertexCirculator(m, startVertex.edge):
    if endVertex == he.pair.vertex:
      result = he
      break

# Transforms
# Rotate
proc rotate*(mesh: var HalfEdgeMesh[Vector2], theta: float): var HalfEdgeMesh[Vector2] {.noinit.} =
  for i in 0..<len(mesh.vertices):
    mesh.vertices[i].position = rotate(mesh.vertices[i].position, theta)
  result = mesh

proc rotate*(mesh: var HalfEdgeMesh[Vector3], axis: Vector3, theta: float): var HalfEdgeMesh[Vector3] {.noinit.} =
  for i in 0..<len(mesh.vertices):
    mesh.vertices[i].position = rotate(mesh.vertices[i].position, axis, theta)
  result = mesh

proc rotate*(mesh: var HalfEdgeMesh[Vector4], b1, b2: Vector4, theta: float, b3, b4: Vector4, phi: float): var HalfEdgeMesh[Vector4] {.noinit.} =
  for i in 0..<len(mesh.vertices):
    mesh.vertices[i].position = rotate(mesh.vertices[i].position, b1, b2, theta, b3, b4, phi)
  result = mesh

# Scale
proc scale*[Vector](mesh: var HalfEdgeMesh[Vector], s: float): var HalfEdgeMesh[Vector] {.noinit.} =
  for i in 0..<len(mesh.vertices):
    mesh.vertices[i].position = scale(mesh.vertices[i].position, s)
  result = mesh

proc scale*(mesh: var HalfEdgeMesh[Vector2], sx, sy: float): var HalfEdgeMesh[Vector2] {.noinit.} =
  for i in 0..<len(mesh.vertices):
    mesh.vertices[i].position = scale(mesh.vertices[i].position, sx, sy)
  result = mesh

proc scale*(mesh: var HalfEdgeMesh[Vector3], sx, sy, sz: float): var HalfEdgeMesh[Vector3] {.noinit.} =
  for i in 0..<len(mesh.vertices):
    mesh.vertices[i].position = scale(mesh.vertices[i].position, sx, sy, sz)
  result = mesh

proc scale*(mesh: var HalfEdgeMesh[Vector4], sx, sy, sz, sw: float): var HalfEdgeMesh[Vector4] {.noinit.} =
  for i in 0..<len(mesh.vertices):
    mesh.vertices[i].position = scale(mesh.vertices[i].position, sx, sy, sz, sw)
  result = mesh

# Translate
proc translate*[Vector](mesh: var HalfEdgeMesh[Vector], v: Vector): var HalfEdgeMesh[Vector] {.noinit.} =
  for i in 0..<len(mesh.vertices):
    mesh.vertices[i].position = translate(mesh.vertices[i].position, v)
  result = mesh

# Transform(Matrix)
proc transform*[Vector, Matrix](mesh: var HalfEdgeMesh[Vector], m: Matrix): var HalfEdgeMesh[Vector] {.noinit.} =
  for i in 0..<len(mesh.vertices):
    mesh.vertices[i].position = transform(mesh.vertices[i].position, m)
  result = mesh

# Support
const NIL_STRING = "nil"
proc genOidString[Vector](vertex: MeshVertex[Vector]): string =
  result = if isNil(vertex): NIL_STRING else: $vertex.oid

proc genOidString[Vector](face: MeshFace[Vector]): string =
  result = if isNil(face): NIL_STRING else: $face.oid

proc genOidString[Vector](halfEdge: HalfEdge[Vector]): string =
  result = if isNil(halfEdge): NIL_STRING else: $halfEdge.oid

proc `$`*[Vector](vertex: MeshVertex[Vector]): string =
  result = "{ oid: " &
    $vertex.oid & ", position: " &
    $vertex.position & ", edge: " &
    genOidString(vertex.edge) & " }"

proc `$`*[Vector](face: MeshFace[Vector]): string =
  result = "{ oid: " &
    $face.oid & ", edge: " &
    genOidString(face.edge) & " }"

proc `$`*[Vector](edge: HalfEdge[Vector]): string =
  result = "{ oid: " &
    $edge.oid & ", face: " &
    genOidString(edge.face) & ", pair: " &
    genOidString(edge.pair) & ", next: " &
    genOidString(edge.next) & ", previous: " &
    genOidString(edge.previous) & " }"

proc hash*[Vector](vertex: MeshVertex[Vector]): hashes.Hash =
  result = !$(result !& hash(vertex.oid))

proc hash*[Vector](face: MeshFace[Vector]): hashes.Hash =
  result = !$(result !& hash(face.oid))

proc hash*[Vector](edge: HalfEdge[Vector]): hashes.Hash =
  result = !$(result !& hash(edge.oid))

proc hash*[Vector](mesh: HalfEdgeMesh[Vector]): hashes.Hash =
  for vertex in mesh.vertices:
    result = !$(result !& hash(vertex))
  for face in mesh.faces:
    result = !$(result !& hash(face))
  for edge in mesh.edges:
    result = !$(result !& hash(edge))

proc dimension*(mesh: HalfEdgeMesh[Vector1]): int =
  result = 1

proc dimension*(mesh: HalfEdgeMesh[Vector2]): int =
  result = 2

proc dimension*(mesh: HalfEdgeMesh[Vector3]): int =
  result = 3

proc dimension*(mesh: HalfEdgeMesh[Vector4]): int =
  result = 4

# TODO: EULER OPERATIONS