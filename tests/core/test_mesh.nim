import ../../src/core/mesh
import ../../src/core/vector

var
  a = Vector3(x: 0.0, y: 0.0, z: 0.0)
  b = Vector3(x: 5.0, y: 5.0, z: 5.0)
  c = Vector3(x: 10.0, y: 10.0, z: 10.0)
  d = Vector3(x: -5.0, y: -5.0, z: -5.0)

var
  aVertex = MeshVertex[Vector3](position: a, edge: nil)
  bVertex = MeshVertex[Vector3](position: b, edge: nil)
  cVertex = MeshVertex[Vector3](position: c, edge: nil)
  dVertex = MeshVertex[Vector3](position: d, edge: nil)

var
  abcFace = MeshFace[Vector3](edge: nil)
  acdFace = MeshFace[Vector3](edge: nil)

var
  abEdge = HalfEdge[Vector3](vertex: aVertex, face: nil, twin: nil, next: nil, previous: nil)
  baEdge = HalfEdge[Vector3](vertex: bVertex, face: nil, twin: nil, next: nil, previous: nil)
  bcEdge = HalfEdge[Vector3](vertex: bVertex, face: nil, twin: nil, next: nil, previous: nil)
  cbEdge = HalfEdge[Vector3](vertex: cVertex, face: nil, twin: nil, next: nil, previous: nil)
  caEdge = HalfEdge[Vector3](vertex: cVertex, face: nil, twin: nil, next: nil, previous: nil)
  acEdge = HalfEdge[Vector3](vertex: aVertex, face: nil, twin: nil, next: nil, previous: nil)

  adEdge = HalfEdge[Vector3](vertex: aVertex, face: nil, twin: nil, next: nil, previous: nil)
  daEdge = HalfEdge[Vector3](vertex: dVertex, face: nil, twin: nil, next: nil, previous: nil)
  dcEdge = HalfEdge[Vector3](vertex: dVertex, face: nil, twin: nil, next: nil, previous: nil)
  cdEdge = HalfEdge[Vector3](vertex: cVertex, face: nil, twin: nil, next: nil, previous: nil)

# Twinning
abEdge.twin = baEdge
baEdge.twin = abEdge
bcEdge.twin = cbEdge
cbEdge.twin = bcEdge
acEdge.twin = caEdge
caEdge.twin = acEdge

adEdge.twin = daEdge
daEdge.twin = adEdge
dcEdge.twin = cdEdge
cdEdge.twin = dcEdge

# Nexting / Previousing
abEdge.next = bcEdge
abEdge.previous = caEdge

baEdge.next = acEdge
baEdge.previous = cbEdge

bcEdge.next = caEdge
bcEdge.previous = abEdge

cbEdge.next = baEdge
cbEdge.previous = acEdge

acEdge.next = cbEdge
acEdge.previous = baEdge

caEdge.next = abEdge
caEdge.previous = bcEdge

adEdge.next = dcEdge
adEdge.previous = caEdge

daEdge.next = acEdge
daEdge.previous = cdEdge

dcEdge.next = caEdge
dcEdge.previous = adEdge

cdEdge.next = daEdge
cdEdge.previous = acEdge

abEdge.face = abcFace
bcEdge.face = abcFace
caEdge.face = abcFace

acEdge.face = acdFace
cdEdge.face = acdFace
daEdge.face = acdFace