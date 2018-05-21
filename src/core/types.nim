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