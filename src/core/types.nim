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
  Circle*[N: static[int], T] = object
    center*: Vector[N, T]
    radius*: float

  # Mesh
  MeshVertex*[T] = ref object
    oid*: Oid
    position*: T
    edge*: HalfEdge[T]

  MeshFace*[T] = ref object
    oid*: Oid
    edge*: HalfEdge[T]

  HalfEdge*[T] = ref object
    oid*: Oid
    vertex*: MeshVertex[T]
    face*: MeshFace[T]
    pair*: HalfEdge[T]
    next*: HalfEdge[T]
    previous*: HalfEdge[T]

  HalfEdgeMesh*[T] = object
    vertices*: seq[MeshVertex[T]]
    faces*: seq[MeshFace[T]]
    edges*: seq[HalfEdge[T]]