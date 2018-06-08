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
  Vector3,
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
  normalize

from sequtils import concat, toSeq, map, filter

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
  var h = halfEdge
  while true:
    if not contains(m.edges, h):
      raise newException(InvalidEdgeError,
        "Mesh does not contain this half-edge")
    if isNil(h):
      raise newException(InvalidOperationError,
        "Next half-edge is unset")
    yield h
    h = h.pair.next
    if h == halfEdge:
      break

iterator faceCirculator*[Vector](m: HalfEdgeMesh[Vector], halfEdge: HalfEdge[Vector]): HalfEdge[Vector] =
  var h = halfEdge
  while true:
    if not contains(m.edges, h):
      raise newException(InvalidHalfEdgeError,
        "Mesh does not contain this half-edge")
    if isNil(h):
      raise newException(InvalidOperationError,
        "Next half-edge is unset")
    yield h
    h = h.next
    if h == halfEdge:
      break

iterator halfEdgeCirculator*[Vector](m: HalfEdgeMesh[Vector], vertex: MeshVertex[Vector]): HalfEdge[Vector] =
  let firstHalfEdge = vertex.edge
  if not contains(m.vertices, vertex):
    raise newException(InvalidVertexOperation,
      "Mesh does not contain this vertex")
  if (isNil(firstHalfEdge)):
    raise newException(InvalidOperationError,
      "Vertex has not connectivity")
  var h = firstHalfEdge
  while true:
    if (isNil(h)):
      raise newException(InvalidOperationError,
        "Next half-edge is unset")
    yield h
    h = h.pair.next
    if h == firstHalfEdge:
      break

iterator halfEdgeCirculator*[Vector](m: HalfEdgeMesh[Vector], vertex: MeshVertex[Vector], halfEdge: HalfEdge[Vector]): HalfEdge[Vector] =
  if not contains(m.vertices, vertex):
    raise newException(InvalidVertexOperation,
      "Mesh does not contain this vertex")
  if not contains(m.edges, halfEdge):
    raise newException(InvalidHalfEdgeError,
      "Mesh does not contain this half-edge")
  if halfEdge.vertex != vertex:
    raise newException(InvalidOperationError,
      "Half-edge does not start at vertex")
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
  add(m.vertices, MeshVertex[Vector](position: vector, edge: nil))

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
  result = MeshFace[Vector](edge: nil)
  if n < 3:
    raise newException(InvalidFaceError,
      "Face is degenerate")
  for v in vertices:
    if not contains(m.vertices, v):
      raise newException(InvalidVertexError,
        "Mesh does not contain vertex")
    if v.edge != nil and v.edge.face != nil:
      raise newException(InvalidVertexError,
        "Vertex is not on boundary")

  var
    loop = newSeq[HalfEdge[Vector]](n)
    created = newSeq[bool](n)
  for i in 0..<n:
    let
      v1 = vertices[i]
      v2 = vertices[(i + 1) mod n]

    if containsHalfEdge(m, v1, v2):
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
        if isNil(v.edge):
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
        for e in toSeq(vertexCirculator(loop[ii]))[1..^1]:
          if isNil(e.face):
            vertices[ii].edge = e
            break

      if (loop[i].next != loop[ii] or loop[ii].previous != loop[i]):
        let
          next = loop[i].next
          previous = loop[ii].previous

        try:
          let boundary = filter(toSeq(vertexCirculator(loop[ii]))[1..^1],
            proc(e: HalfEdge[Vector]): bool = isNil(e.face))[0]
          makeConsecutive(loop[i], loop[ii])
          makeConsecutive(boundary.previous, next)
          makeConsecutive(previous, boundary)
        except:
          raise newException(InvalidOperationException,
           "Failed to relink half-edges around vertex during face creation")
  result.edge = loop[0]

proc addFaces*[Vector](m: var HalfEdgeMesh[Vector], faces: openArray[MeshFace[Vector]]): void =
  m.faces  =concat(m.faces, faces)

# Edges
proc addEdge*[Vector](m: var HalfEdgeMesh[Vector], halfEdge: HalfEdge[Vector]): void =
  add(m.edges, halfEdge)

proc addEdges*[Vector](m: var HalfEdgeMesh[Vector], halfEdges: openArray[HalfEdge[Vector]]): void =
  m.edges = concat(m.edges, halfEdges)

proc addPair*[Vector](m: var HalfEdgeMesh[Vector], startVertex, endVertex: MeshVertex[Vector], face: MeshFace[Vector]): HalfEdge[Vector] =
  result = HalfEdge[Vector](vertex: startVertex, face: face, pair: nil, next: nil, previous: nil)
  var halfEdge2 = HalfEdge[Vector](vertex: endVertex, face: nil, pair: result, next: nil, previous: nil)
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

# TODO: EULER OPERATIONS