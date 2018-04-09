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

# This is changed from design doc
template `+`*(v1, v2: Vector1): Vector1 = addNew(v1, v2)
template `+`*(v1, v2: Vector2): Vector2 = addNew(v1, v2)
template `+`*(v1, v2: Vector3): Vector3 = addNew(v1, v2)
template `+`*(v1, v2: Vector4): Vector4 = addNew(v1, v2)

# This is added from design doc
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

# This is changed from design doc
template `-`*(v1, v2: Vector1): Vector1 = subtractNew(v1, v2)
template `-`*(v1, v2: Vector2): Vector2 = subtractNew(v1, v2)
template `-`*(v1, v2: Vector3): Vector3 = subtractNew(v1, v2)
template `-`*(v1, v2: Vector4): Vector4 = subtractNew(v1, v2)

# This is added from design doc
template `-=`*(v1: var Vector1, v2: Vector1): var Vector1 = subtractSelf(v1, v2)
template `-=`*(v1: var Vector2, v2: Vector2): var Vector2 = subtractSelf(v1, v2)
template `-=`*(v1: var Vector3, v2: Vector3): var Vector3 = subtractSelf(v1, v2)
template `-=`*(v1: var Vector4, v2: Vector4): var Vector4 = subtractSelf(v1, v2)

# String
proc `$`*(v: Vector1): string =
  result = &"[{v.x}]"

proc `$`*(v: Vector2): string =
  result = &"[{v.x}, {v.y}]"

proc `$`*(v: Vector3): string =
  result = &"[{v.x}, {v.y}, {v.z}]"

proc `$`*(v: Vector4): string =
  result = &"[{v.x}, {v.y}, {v.z}, {v.w}]"
