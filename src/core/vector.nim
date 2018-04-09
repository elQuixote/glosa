import ./concepts

import strformat

type
  Vector1* = object
    x*: float
  Vector2* = object
    x*, y*: float
  Vector3* = object
    x*, y*, z*: float
  Vector4* = object
    x*, y*, z*, w*: float

# Addition
proc addSelf*(v1: var Vector1, v2: Vector1): var Vector1 {.noinit.} =
  v1.x += v2.x
  result = v1

proc addNew*(v1, v2: Vector1): Vector1 =
  result.x = v1.x + v2.x

proc addSelf*(v1: var Vector2, v2: Vector2): var Vector2 {.noinit.}  =
  v1.x += v2.x
  v1.y += v2.y
  result = v1

proc addNew*(v1, v2: Vector2): Vector2 =
  result.x = v1.x + v2.x
  result.y = v1.y + v2.y

proc addSelf*(v1: var Vector3, v2: Vector3): var Vector3 {.noinit.}  =
  v1.x += v2.x
  v1.y += v2.y
  v1.z += v2.z
  result = v1

proc addNew*(v1, v2: Vector3): Vector3 =
  result.x = v1.x + v2.x
  result.y = v1.y + v2.y
  result.z = v1.z + v2.z

proc addSelf*(v1: var Vector4, v2: Vector4): var Vector4 {.noinit.}  =
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

# NOTE: This is changed from design doc
template `+`*(v1, v2: Vector1): Vector1 = addNew(v1, v2)
template `+`*(v1, v2: Vector2): Vector2 = addNew(v1, v2)
template `+`*(v1, v2: Vector3): Vector3 = addNew(v1, v2)
template `+`*(v1, v2: Vector4): Vector4 = addNew(v1, v2)

# NOTE: This is added from design doc
template `+=`*(v1: var Vector1, v2: Vector1): var Vector1 = addSelf(v1, v2)
template `+=`*(v1: var Vector2, v2: Vector2): var Vector2 = addSelf(v1, v2)
template `+=`*(v1: var Vector3, v2: Vector3): var Vector3 = addSelf(v1, v2)
template `+=`*(v1: var Vector4, v2: Vector4): var Vector4 = addSelf(v1, v2)

# Subtraction
proc subtractSelf*(v1: var Vector1, v2: Vector1): var Vector1 {.noinit.} =
  v1.x -= v2.x
  result = v1

proc subtractNew*(v1, v2: Vector1): Vector1 =
  result.x = v1.x - v2.x

proc subtractSelf*(v1: var Vector2, v2: Vector2): var Vector2 {.noinit.}  =
  v1.x -= v2.x
  v1.y -= v2.y
  result = v1

proc subtractNew*(v1, v2: Vector2): Vector2 =
  result.x = v1.x - v2.x
  result.y = v1.y - v2.y

proc subtractSelf*(v1: var Vector3, v2: Vector3): var Vector3 {.noinit.}  =
  v1.x -= v2.x
  v1.y -= v2.y
  v1.z -= v2.z
  result = v1

proc subtractNew*(v1, v2: Vector3): Vector3 =
  result.x = v1.x - v2.x
  result.y = v1.y - v2.y
  result.z = v1.z - v2.z

proc subtractSelf*(v1: var Vector4, v2: Vector4): var Vector4 {.noinit.}  =
  v1.x -= v2.x
  v1.y -= v2.y
  v1.z -= v2.z
  v1.w -= v2.w
  result = v1

proc subtractNew*(v1, v2: Vector4): Vector4 =
  result.x = v1.x - v2.x
  result.y = v1.y - v2.y
  result.z = v1.z - v2.z
  result.w = v1.w - v2.w

# NOTE: This is changed from design doc
template `-`*(v1, v2: Vector1): Vector1 = subtractNew(v1, v2)
template `-`*(v1, v2: Vector2): Vector2 = subtractNew(v1, v2)
template `-`*(v1, v2: Vector3): Vector3 = subtractNew(v1, v2)
template `-`*(v1, v2: Vector4): Vector4 = subtractNew(v1, v2)

# NOTE: This is added from design doc
template `-=`*(v1: var Vector1, v2: Vector1): var Vector1 = subtractSelf(v1, v2)
template `-=`*(v1: var Vector2, v2: Vector2): var Vector2 = subtractSelf(v1, v2)
template `-=`*(v1: var Vector3, v2: Vector3): var Vector3 = subtractSelf(v1, v2)
template `-=`*(v1: var Vector4, v2: Vector4): var Vector4 = subtractSelf(v1, v2)

# Addition
proc multiplySelf*(v: var Vector1, f: float): var Vector1 {.noinit.} =
  v.x *= f
  result = v

proc multiplyNew*(v: Vector1, f: float): Vector1 =
  result.x = v.x * f

proc multiplySelf*(v: var Vector2, f: float): var Vector2 {.noinit.}  =
  v.x *= f
  v.y *= f
  result = v

proc multiplyNew*(v: Vector2, f: float): Vector2 =
  result.x = v.x * f
  result.y = v.y * f

proc multiplySelf*(v: var Vector3, f: float): var Vector3 {.noinit.}  =
  v.x *= f
  v.y *= f
  v.z *= f
  result = v

proc multiplyNew*(v: Vector3, f: float): Vector3 =
  result.x = v.x * f
  result.y = v.y * f
  result.z = v.z * f

proc multiplySelf*(v: var Vector4, f: float): var Vector4 {.noinit.}  =
  v.x *= f
  v.y *= f
  v.z *= f
  v.w *= f
  result = v

proc multiplyNew*(v: Vector4, f: float): Vector4 =
  result.x = v.x * f
  result.y = v.y * f
  result.z = v.z * f
  result.w = v.w * f

# NOTE: This is changed from design doc
template `*`*(v: Vector1, f: float): Vector1 = multiplyNew(v, f)
template `*`*(v: Vector2, f: float): Vector2 = multiplyNew(v, f)
template `*`*(v: Vector3, f: float): Vector3 = multiplyNew(v, f)
template `*`*(v: Vector4, f: float): Vector4 = multiplyNew(v, f)

# NOTE: This is added from design doc
template `*=`*(v: var Vector1, f: float): var Vector1 = multiplySelf(v, f)
template `*=`*(v: var Vector2, f: float): var Vector2 = multiplySelf(v, f)
template `*=`*(v: var Vector3, f: float): var Vector3 = multiplySelf(v, f)
template `*=`*(v: var Vector4, f: float): var Vector4 = multiplySelf(v, f)

# String
proc `$`*(v: Vector1): string =
  result = &"[{v.x}]"

proc `$`*(v: Vector2): string =
  result = &"[{v.x}, {v.y}]"

proc `$`*(v: Vector3): string =
  result = &"[{v.x}, {v.y}, {v.z}]"

proc `$`*(v: Vector4): string =
  result = &"[{v.x}, {v.y}, {v.z}, {v.w}]"
