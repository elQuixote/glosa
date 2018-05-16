from sets import OrderedSet

type
  # Vectors
  Vector1* = object
    x*: float
  Vector2* = object
    x*, y*: float
  Vector3* = object
    x*, y*, z*: float
  Vector4* = object
    x*, y*, z*, w*: float

  # Matrices
  Matrix33* = object
    matrix*: array[3, array[3, float]]
  Matrix44* = object
    matrix*: array[4, array[4, float]]

  # Quaternions
  Quaternion* = object
    x*, y*, z*, w*: float

  # Paths
  LineSegment*[Vector] = object
    startVertex*: Vector
    endVertex*: Vector

  Polyline*[Vector] = object
    vertices*: seq[Vector]
    segments*: seq[LineSegment[Vector]]

  # Polygon
  Polygon*[Vector] = object
    polyline*: Polyline[Vector]

  # Shapes
  Circle*[Vector] = object
    center*: Vector
    radius*: float