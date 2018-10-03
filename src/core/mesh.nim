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
  Vector,
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
import tables
from sequtils import concat, toSeq, map, filter

import hashes

# Constructors
proc meshVertex*[T](position: T, edge: HalfEdge[T]): MeshVertex[T] =
  result = MeshVertex[T](oid: genOid(), position: position, edge: edge)

proc meshFace*[T](edge: HalfEdge[T]): MeshFace[T] =
  result = MeshFace[T](oid: genOid(), edge: edge)

proc halfEdge*[T](vertex: MeshVertex[T], face: MeshFace[T], pair, next, previous: HalfEdge[T]): HalfEdge[T] =
  result = HalfEdge[T](oid: genOid(), vertex: vertex, face: face, pair: pair, next: next, previous: previous)

# Forward Declarations
proc isBoundary*[T](m: HalfEdgeMesh[T], halfEdge: HalfEdge[T]): bool
proc endVertex*[T](m: HalfEdgeMesh[T], halfEdge: HalfEdge[T]): MeshVertex[T]
proc containsHalfEdge*[T](m: HalfEdgeMesh[T], startVertex, endVertex: MeshVertex[T]): bool
proc findHalfEdge*[T](m: HalfEdgeMesh[T], startVertex, endVertex: MeshVertex[T]): HalfEdge[T]
proc addPair*[T](m: var HalfEdgeMesh[T], startVertex, endVertex: MeshVertex[T], face: MeshFace[T]): HalfEdge[T]

# Implementations
# Accessors
# Traverses clockwise around the starting vertex of a halfedge
iterator vertexCirculator*[T](m: HalfEdgeMesh[T], halfEdge: HalfEdge[T]): HalfEdge[T] =
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

iterator faceCirculator*[T](m: HalfEdgeMesh[T], halfEdge: HalfEdge[T]): HalfEdge[T] =
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

iterator halfEdgeCirculator*[T](m: HalfEdgeMesh[T], vertex: MeshVertex[T]): HalfEdge[T] =
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

iterator halfEdgeCirculator*[T](m: HalfEdgeMesh[T], vertex: MeshVertex[T], halfEdge: HalfEdge[T]): HalfEdge[T] =
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
proc makeConsecutive[T](previous, next: HalfEdge[T]) =
  previous.next = next
  next.previous = previous

# Other
proc halfEdgeMesh*[T](): HalfEdgeMesh[T] =
  result = HalfEdgeMesh[T](
    vertices: newSeq[MeshVertex[T]](0),
    faces: newSeq[MeshFace[T]](0),
    edges: newSeq[HalfEdge[T]](0)
  )

proc length*[T](m: HalfEdgeMesh[T], halfEdge: HalfEdge[T]): float =
  result = distanceTo(halfEdge.vertex, endVertex(m, halfEdge))

proc lengths*[T](m: HalfEdgeMesh[T]): seq[float] =
  result = newSeq[float](len(m.edges))
  for i, e in pairs(m.edges):
    result[i] = length(m, e)

# Vertices
proc addVertex*[T](m: var HalfEdgeMesh[T], vertex: MeshVertex[T]): void =
  add(m.vertices, vertex)

proc addVertex*[T](m: var HalfEdgeMesh[T], vector: T): void =
  add(m.vertices, meshVertex[T](position: vector, edge: nil))

proc addVertices*[T](m: var HalfEdgeMesh[T], vertices: openArray[MeshVertex[T]]): void =
  m.vertices = concat(m.vertices, vertices)

proc outgoingHalfEdges*[T](m: HalfEdgeMesh[T], vertex: MeshVertex[T]): seq[HalfEdge[T]] =
  result = toSeq(vertexCirculator(m, vertex.edge))

proc incomingHalfEdges*[T](m: HalfEdgeMesh[T], vertex: MeshVertex[T]): seq[HalfEdge[T]] =
  result = map(outgoingHalfEdges(m, vertex), proc(halfEdge: HalfEdge[T]): HalfEdge[T] = halfEdge.pair)

proc neighbors*[T](m: HalfEdgeMesh[T], vertex: MeshVertex[T]): seq[MeshVertex[T]] =
  result = map(outgoingHalfEdges(m, vertex), proc(halfEdge: HalfEdge[T]): MeshVertex[T] = halfEdge.pair.vertex)

proc faces*[T](m: HalfEdgeMesh[T], vertex: MeshVertex[T]): seq[MeshFace[T]] =
  result = map(outgoingHalfEdges(m, vertex), proc(halfEdge: HalfEdge[T]): MeshFace[T] = halfEdge.face)

proc valence*[T](m: HalfEdgeMesh[T], vertex: MeshVertex[T]): int =
  result = len(vertexCirculator(m, vertex.edge))

proc isBoundary*[T](m: HalfEdgeMesh[T], vertex: MeshVertex[T]): bool =
  result = isNil(vertex.edge) or isNil(vertex.edge.face)

proc normal*[T](m: HalfEdgeMesh[T], vertex: MeshVertex[T]): T =
  let
    position = vertex.position
    ring = neighbors(m, vertex)
    n = len(ring)
  for i, v in pairs(ring):
    let ii = (i + 1) mod n
    result += cross(v.position - position, ring[ii].position - position)
  result = normalize(result)

proc normals*[T](m: HalfEdgeMesh[T]): seq[T] =
  result = map(m.vertices, proc(vertex: MeshVertex[T]): T = normal(m, vertex))

proc positions*[T](m: HalfEdgeMesh[T]): seq[T] =
  result = map(m.vertices, proc(vertex: MeshVertex[T]): T = vertex.position)

# Faces
proc addFace*[T](m: var HalfEdgeMesh[T], face: MeshFace[T]): void =
  add(m.faces, face)

proc addFace*[T](m: var HalfEdgeMesh[T], vertices: openArray[MeshVertex[T]]): MeshFace[T] =
  let n = len(vertices)
  result = meshFace[T](nil)
  if n < 3:
    raise newException(InvalidFaceError,
      "Face is degenerate")
  for v in vertices:
    if not contains(m.vertices, v):
      raise newException(InvalidVertexError,
        "Mesh does not contain vertex")

  var
    loop = newSeq[HalfEdge[T]](n)
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
      outerNext: HalfEdge[T] = nil
      outerPrevious: HalfEdge[T] = nil
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
            proc(e: HalfEdge[T]): bool = isNil(e.face))[0]
          makeConsecutive(loop[i], loop[ii])
          makeConsecutive(boundary.previous, next)
          makeConsecutive(previous, boundary)
        except:
          raise newException(InvalidOperationError,
           "Failed to relink half-edges around vertex during face creation")
  result.edge = loop[0]
  add(m.faces, result)

proc addFaces*[T](m: var HalfEdgeMesh[T], faces: openArray[MeshFace[T]]): void =
  m.faces  =concat(m.faces, faces)

# Face Operations
# NOTE: Path/Polygon operations need to be expanded, all currently empty (unfilled) face operations
proc closestPoint*[T](m: HalfEdgeMesh[T], face: MeshFace[T]): T =
  let vertices = toSeq(faceCirculator(m, face.edge))
  result = closestPoint(polyline(vertices), true)

proc centroid*[T](m: HalfEdgeMesh[T], face: MeshFace[T]): T =
  let vertices = toSeq(faceCirculator(m, face.edge))
  result = centroid(polygon(vertices))

proc average*[T](m: HalfEdgeMesh[T], face: MeshFace[T]): T =
  let vertices = toSeq(faceCirculator(m, face.edge))
  result = average(polyline(vertices), true)

proc perimeter*[T](m: HalfEdgeMesh[T], face: MeshFace[T]): float =
  let vertices = toSeq(faceCirculator(m, face.edge))
  result = perimeter(polygon(vertices))

proc area*[T](m: HalfEdgeMesh[T], face: MeshFace[T]): float =
  let vertices = toSeq(faceCirculator(m, face.edge))
  result = area(polygon(vertices))

# Edges
proc addEdge*[T](m: var HalfEdgeMesh[T], halfEdge: HalfEdge[T]): void =
  add(m.edges, halfEdge)

proc addEdges*[T](m: var HalfEdgeMesh[T], halfEdges: openArray[HalfEdge[T]]): void =
  m.edges = concat(m.edges, @halfEdges)

proc addPair*[T](m: var HalfEdgeMesh[T], startVertex, endVertex: MeshVertex[T], face: MeshFace[T]): HalfEdge[T] =
  result = halfEdge[T](startVertex, face, nil, nil, nil)
  var halfEdge2 = halfEdge[T](endVertex, nil, result, nil, nil)
  result.pair = halfEdge2
  addEdges(m, @[result, halfEdge2])

proc isBoundary*[T](m: HalfEdgeMesh[T], halfEdge: HalfEdge[T]): bool =
  if not contains(m.edges, halfEdge):
    raise newException(InvalidHalfEdgeError,
      "Mesh does not contain this half-edge")
  result = isNil(halfEdge.face) or isNil(halfEdge.pair.face)

proc endVertex*[T](m: HalfEdgeMesh[T], halfEdge: HalfEdge[T]): MeshVertex[T] =
  if not contains(m.edges, halfEdge):
    raise newException(InvalidHalfEdgeError,
      "Mesh does not contain this half-edge")
  result = halfEdge.pair.vertex

proc containsHalfEdge*[T](m: HalfEdgeMesh[T], startVertex, endVertex: MeshVertex[T]): bool =
  for he in vertexCirculator(m, startVertex.edge):
    if endVertex == he.pair.vertex:
      result = true
      break

proc findHalfEdge*[T](m: HalfEdgeMesh[T], startVertex, endVertex: MeshVertex[T]): HalfEdge[T] =
  for he in vertexCirculator(m, startVertex.edge):
    if endVertex == he.pair.vertex:
      result = he
      break

# Copy
proc lookUpOid[T](obj: T, table: Table[string, int], s: seq[T]): T =
  if isNil(obj):
    return nil
  else:
    return s[table[$obj.oid]]

proc copy*[T](m: HalfEdgeMesh[T]): HalfEdgeMesh[T] =
  var
    vertexTable = initTable[string, int]()
    faceTable = initTable[string, int]()
    edgeTable = initTable[string, int]()
  result = halfEdgeMesh[T]()
  for i, v in pairs(m.vertices):
    vertexTable[$v.oid] = i
    add(result.vertices, meshVertex[T](copy(v.position), nil))
  for i, f in pairs(m.faces):
    faceTable[$f.oid] = i
    add(result.faces, meshFace[T](nil))
  for i, e in pairs(m.edges):
    edgeTable[$e.oid] = i
    add(result.edges, halfEdge[T](nil, nil, nil, nil, nil))
  for i, oldV in pairs(m.vertices):
    result.vertices[i].edge = lookUpOid(oldV.edge, edgeTable, result.edges)
  for i, oldF in pairs(m.faces):
    result.faces[i].edge = lookUpOid(oldF.edge, edgeTable, result.edges)
  for i, oldE in pairs(m.edges):
    result.edges[i].vertex = lookUpOid(oldE.vertex, vertexTable, result.vertices)
    result.edges[i].face = lookUpOid(oldE.face, faceTable, result.faces)
    result.edges[i].pair = lookUpOid(oldE.pair, edgeTable, result.edges)
    result.edges[i].next = lookUpOid(oldE.next, edgeTable, result.edges)
    result.edges[i].previous = lookUpOid(oldE.previous, edgeTable, result.edges)


# Transforms
# Rotate
proc rotate*[T](mesh: var HalfEdgeMesh[T], theta: float): var HalfEdgeMesh[T] {.noinit.} =
  for i in 0..<len(mesh.vertices):
    mesh.vertices[i].position = rotate(mesh.vertices[i].position, theta)
  result = mesh

proc rotate*[T](mesh: var HalfEdgeMesh[T], axis: T, theta: float): var HalfEdgeMesh[T] {.noinit.} =
  for i in 0..<len(mesh.vertices):
    mesh.vertices[i].position = rotate(mesh.vertices[i].position, axis, theta)
  result = mesh

proc rotate*[T](mesh: var HalfEdgeMesh[T], b1, b2: T, theta: float, b3, b4: T, phi: float): var HalfEdgeMesh[T] {.noinit.} =
  for i in 0..<len(mesh.vertices):
    mesh.vertices[i].position = rotate(mesh.vertices[i].position, b1, b2, theta, b3, b4, phi)
  result = mesh

# Scale
proc scale*[T](mesh: var HalfEdgeMesh[T], s: float): var HalfEdgeMesh[T] {.noinit.} =
  for i in 0..<len(mesh.vertices):
    mesh.vertices[i].position = scale(mesh.vertices[i].position, s)
  result = mesh

proc scale*[T](mesh: var HalfEdgeMesh[T], sx, sy: float): var HalfEdgeMesh[T] {.noinit.} =
  for i in 0..<len(mesh.vertices):
    mesh.vertices[i].position = scale(mesh.vertices[i].position, sx, sy)
  result = mesh

proc scale*[T](mesh: var HalfEdgeMesh[T], sx, sy, sz: float): var HalfEdgeMesh[T] {.noinit.} =
  for i in 0..<len(mesh.vertices):
    mesh.vertices[i].position = scale(mesh.vertices[i].position, sx, sy, sz)
  result = mesh

proc scale*[T](mesh: var HalfEdgeMesh[T], sx, sy, sz, sw: float): var HalfEdgeMesh[T] {.noinit.} =
  for i in 0..<len(mesh.vertices):
    mesh.vertices[i].position = scale(mesh.vertices[i].position, sx, sy, sz, sw)
  result = mesh

# Translate
proc translate*[T](mesh: var HalfEdgeMesh[T], v: T): var HalfEdgeMesh[T] {.noinit.} =
  for i in 0..<len(mesh.vertices):
    mesh.vertices[i].position = translate(mesh.vertices[i].position, v)
  result = mesh

# Transform(Matrix)
proc transform*[T, Matrix](mesh: var HalfEdgeMesh[T], m: Matrix): var HalfEdgeMesh[T] {.noinit.} =
  for i in 0..<len(mesh.vertices):
    mesh.vertices[i].position = transform(mesh.vertices[i].position, m)
  result = mesh

# Support
const NIL_STRING = "nil"
proc genOidString[T](vertex: MeshVertex[T]): string =
  result = if isNil(vertex): NIL_STRING else: $vertex.oid

proc genOidString[T](face: MeshFace[T]): string =
  result = if isNil(face): NIL_STRING else: $face.oid

proc genOidString[T](halfEdge: HalfEdge[T]): string =
  result = if isNil(halfEdge): NIL_STRING else: $halfEdge.oid

proc `$`*[T](vertex: MeshVertex[T]): string =
  result = "{ oid: " &
    $vertex.oid & ", position: " &
    $vertex.position & ", edge: " &
    genOidString(vertex.edge) & " }"

proc `$`*[T](face: MeshFace[T]): string =
  result = "{ oid: " &
    $face.oid & ", edge: " &
    genOidString(face.edge) & " }"

proc `$`*[T](edge: HalfEdge[T]): string =
  result = "{ oid: " &
    $edge.oid & ", face: " &
    genOidString(edge.face) & ", pair: " &
    genOidString(edge.pair) & ", next: " &
    genOidString(edge.next) & ", previous: " &
    genOidString(edge.previous) & " }"

proc hash*[T](vertex: MeshVertex[T]): hashes.Hash =
  result = !$(result !& hash(vertex.oid))

proc hash*[T](face: MeshFace[T]): hashes.Hash =
  result = !$(result !& hash(face.oid))

proc hash*[T](edge: HalfEdge[T]): hashes.Hash =
  result = !$(result !& hash(edge.oid))

proc hash*[T](mesh: HalfEdgeMesh[T]): hashes.Hash =
  for vertex in mesh.vertices:
    result = !$(result !& hash(vertex))
  for face in mesh.faces:
    result = !$(result !& hash(face))
  for edge in mesh.edges:
    result = !$(result !& hash(edge))

proc dimension*[T](mesh: HalfEdgeMesh[Vector[1, T]]): int =
  result = 1

proc dimension*[T](mesh: HalfEdgeMesh[Vector[2, T]]): int =
  result = 2

proc dimension*[T](mesh: HalfEdgeMesh[Vector[3, T]]): int =
  result = 3

proc dimension*[T](mesh: HalfEdgeMesh[Vector[4, T]]): int =
  result = 4

# TODO: EULER OPERATIONS