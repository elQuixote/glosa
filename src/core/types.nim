type
  Vector1* = object
    x*: float
  Vector2* = object
    x*, y*: float
  Vector3* = object
    x*, y*, z*: float
  Vector4* = object
    x*, y*, z*, w*: float

type
  Matrix33* = object
    matrix*: array[3, array[3, float]]
  Matrix44* = object
    matrix*: array[4, array[4, float]]

type
  Quaternion* = object
    x*, y*, z*, w*: float

type

  Circle*[Vector] = object
    center*: Vector
    radius*: float 
  
  Polygon*[Vector] = object
    vertices*: seq[Vector]
    
  LineSegment*[Vector] = object
    startPoint*: Vector
    endPoint*: Vector