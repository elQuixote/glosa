import ../../src/core/mesh
import ../../src/core/vector

var
  a = Vector3(x: 0.0, y: 0.0, z: 0.0)
  b = Vector3(x: 5.0, y: 5.0, z: 5.0)
  c = Vector3(x: 10.0, y: 10.0, z: 10.0)
  d = Vector3(x: -5.0, y: -5.0, z: -5.0)
  e = Vector3(x: 20.0, y: 20.0, z: 20.0)

var
  aVertex = meshVertex[Vector3](a, nil)
  bVertex = meshVertex[Vector3](b, nil)
  cVertex = meshVertex[Vector3](c, nil)
  dVertex = meshVertex[Vector3](d, nil)
  eVertex = meshVertex[Vector3](e, nil)

var
  abcFace = meshFace[Vector3](nil)
  acdFace = meshFace[Vector3](nil)

var
  abEdge = halfEdge[Vector3](aVertex, nil, nil, nil, nil)
  baEdge = halfEdge[Vector3](bVertex, nil, nil, nil, nil)
  bcEdge = halfEdge[Vector3](bVertex, nil, nil, nil, nil)
  cbEdge = halfEdge[Vector3](cVertex, nil, nil, nil, nil)
  caEdge = halfEdge[Vector3](cVertex, nil, nil, nil, nil)
  acEdge = halfEdge[Vector3](aVertex, nil, nil, nil, nil)

  adEdge = halfEdge[Vector3](aVertex, nil, nil, nil, nil)
  daEdge = halfEdge[Vector3](dVertex, nil, nil, nil, nil)
  dcEdge = halfEdge[Vector3](dVertex, nil, nil, nil, nil)
  cdEdge = halfEdge[Vector3](cVertex, nil, nil, nil, nil)

var m = HalfEdgeMesh[Vector3](
  vertices: @[
    aVertex,
    bVertex,
    cVertex,
    dVertex,
    eVertex
  ],
  faces: @[],
  edges: @[])

echo "Adding Face"
discard addFace(m, @[aVertex, bVertex, cVertex])

echo "Adding Face"
discard addFace(m, @[aVertex, cVertex, dVertex])

echo "Adding Face"
discard addFace(m, @[cVertex, bVertex, eVertex])

for e in halfEdgeCirculator(m, bVertex):
  echo $e

echo "Copying Mesh"
let newMesh = copy(m)

echo $m
echo $newMesh