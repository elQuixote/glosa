type
  Vector1* = object
    x*: float
  Vector2* = object
    x*, y*: float
  Vector3 = object
    x*, y*, z*: float
  Vector4 = object
    x*, y*, z*, w*: float

proc addSelf*(v1, v2: var Vector1): var Vector1 =
  v1.x += v2.x
  result = v1

proc addNew*(v1, v2: Vector1): Vector1 =
  result.x = v1.x + v2.x

proc addSelf*(v1, v2: var Vector2): var Vector2 =
  v1.x += v2.x
  v1.y += v2.y
  result = v1

proc addNew*(v1, v2: Vector2): Vector2 =
  result.x = v1.x + v2.x
  result.y = v1.y + v2.y

proc addSelf*(v1, v2: var Vector3): var Vector3 =
  v1.x += v2.x
  v1.y += v2.y
  v1.z += v2.z
  result = v1

proc addNew*(v1, v2: Vector3): Vector3 =
  result.x = v1.x + v2.x
  result.y = v1.y + v2.y
  result.z = v1.z + v2.z

proc addSelf*(v1, v2: var Vector4): var Vector4 =
  v1.x += v2.x
  v1.y += v2.y
  v1.z += v2.z
  v1.w += v2.w
  result = v1

proc addNew*(v1, v2: Vector4): Vector4 =
  result.x = v1.x + v2.x
  result.y = v1.y + v2.y
  result.z = v1.z + v2.z
  result.w = v1.w + v2.w


template `+`*(v1, v2, result: var Vector1) = addSelf(v1, v2)
template `+`*(v1, v2, result: var Vector2) = addSelf(v1, v2)
template `+`*(v1, v2, result: var Vector3) = addSelf(v1, v2)
template `+`*(v1, v2, result: var Vector4) = addSelf(v1, v2)