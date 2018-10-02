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
  LineSegment*[N: static[int], T] = object
    startVertex*: Vector[N, T]
    endVertex*: Vector[N, T]

  Polyline*[N: static[int], T] = object
    vertices*: seq[Vector[N, T]]
    segments*: seq[LineSegment[N, T]]

  # Curves
  NurbsCurve*[Vector] = object
    degree*: int
    controlPoints*: seq[Vector]
    weights*: seq[float]
    knots*: seq[float]

  # Polygon
  Polygon*[N: static[int], T] = object
    polyline*: Polyline[N, T]

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