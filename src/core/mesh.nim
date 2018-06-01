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
  MeshVertex,
  MeshFace,
  HalfEdge,
  HalfEdgeMesh

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

from ./vector import
  `==`,
  hash,
  dimension

import hashes

# Equals
# NOTE: Circular
# Forward declarations
proc `==`*[Vector](v1, v2: MeshVertex[Vector]): bool
proc `==`*[Vector](f1, f2: MeshFace[Vector]): bool

# Implementations
proc `==`*[Vector](e1, e2: HalfEdge[Vector]): bool =
  result = e1.vertex == e2.vertex and e1.face == e2.face and
    e1.twin == e2.twin and e1.next == e2.next and e1.previous == e2.previous

proc `==`*[Vector](f1, f2: MeshFace[Vector]): bool =
  result = f1.edge == f2.edge

proc `==`*[Vector](v1, v2: MeshVertex[Vector]): bool =
  result = v1.position == v2.position and v1.edge == v2.edge

proc `==`*[Vector](m1, m2: HalfEdgeMesh[Vector]): bool =
  result = m1.edges == m2.edges and m1.faces == m2.faces and m1.vertices == m2.vertices

# Hash
# NOTE: Circular
# Forward declarations
proc hash*[Vector](v: MeshVertex[Vector]): hashes.Hash
proc hash*[Vector](f: MeshFace[Vector]): hashes.Hash

# Implemenations
proc hash*[Vector](e: HalfEdge[Vector]): hashes.Hash =
  result = !$(result !& hash(e.vertex) !& hash(e.face) !& hash(e.twin) !& hash(e.next) !& hash(e.previous))

proc hash*[Vector](f: MeshFace[Vector]): hashes.Hash =
  result = !$(result !& hash(f.edge))

proc hash*[Vector](v: MeshVertex[Vector]): hashes.Hash =
  result = !$(result !& hash(v.position) !& hash(v.edge))

proc hash*[Vector](m: HalfEdgeMesh[Vector]): hashes.Hash =
  for e in m.edges:
    result = !$(result !& hash(e))
  for f in m.faces:
    result = !$(result !& hash(f))
  for v in m.vertices:
    result = !$(result !& hash(v))

# Dimension
proc dimension*[Vector](v: MeshVertex[Vector]): int =
  result = dimension(v.position)

proc dimension*[Vector](m: HalfEdgeMesh[Vector]): int =
  if len(m.vertices) > 0:
    result = dimension(m.vertices[0])