import oids

type
  # Vectors
  Vector*[N: static[int], T] = array[N, T]

  # Matrices
  Matrix*[N, M: static[int], T] = Vector[N, Vector[M, T]]
  Matrix33*[T] = Matrix[3, 3, T]
  Matrix44*[T] = Matrix[4, 4, T]

  # Quaternions
  Quaternion*[T] = Vector[4, T]

  # Paths
  LineSegment*[Vector] = object
    startVertex*: Vector
    endVertex*: Vector

  Polyline*[Vector] = object
    vertices*: seq[Vector]
    segments*: seq[LineSegment[Vector]]

  # Curves
  NurbsCurve*[Vector] = object
    degree*: int
    controlPoints*: seq[Vector]
    weights*: seq[float]
    knots*: seq[float]

  # Polygon
  Polygon*[Vector] = object
    polyline*: Polyline[Vector]

  # Shapes
  Circle*[Vector] = object
    center*: Vector
    radius*: float

  # Mesh
  MeshVertex*[Vector] = ref object
    oid*: Oid
    position*: Vector
    edge*: HalfEdge[Vector]

  MeshFace*[Vector] = ref object
    oid*: Oid
    edge*: HalfEdge[Vector]

  HalfEdge*[Vector] = ref object
    oid*: Oid
    vertex*: MeshVertex[Vector]
    face*: MeshFace[Vector]
    pair*: HalfEdge[Vector]
    next*: HalfEdge[Vector]
    previous*: HalfEdge[Vector]

  HalfEdgeMesh*[Vector] = object
    vertices*: seq[MeshVertex[Vector]]
    faces*: seq[MeshFace[Vector]]
    edges*: seq[HalfEdge[Vector]]