import ./concepts

from math import arctan2
from strformat import `&`

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
# NOTE: Added Scalar addition to all vectors
proc addSelf*(v: var Vector1, f: float): var Vector1 {.noinit.} =
  v.x += f
  result = v

proc addSelf*(v1: var Vector1, v2: Vector1): var Vector1 {.noinit.} =
  v1.x += v2.x
  result = v1

proc addNew*(v: Vector1, f: float): Vector1 =
  result.x = v.x + f

proc addNew*(v1, v2: Vector1): Vector1 =
  result.x = v1.x + v2.x

proc addSelf*(v: var Vector2, f: float): var Vector2 {.noinit.} =
  v.x += f
  v.y += f
  result = v

proc addSelf*(v1: var Vector2, v2: Vector2): var Vector2 {.noinit.}  =
  v1.x += v2.x
  v1.y += v2.y
  result = v1

proc addNew*(v: Vector2, f: float): Vector2 =
  result.x = v.x + f
  result.y = v.y + f

proc addNew*(v1, v2: Vector2): Vector2 =
  result.x = v1.x + v2.x
  result.y = v1.y + v2.y

proc addSelf*(v: var Vector3, f: float): var Vector3 {.noinit.} =
  v.x += f
  v.y += f
  v.z += f
  result = v

proc addSelf*(v1: var Vector3, v2: Vector3): var Vector3 {.noinit.}  =
  v1.x += v2.x
  v1.y += v2.y
  v1.z += v2.z
  result = v1

proc addNew*(v: Vector3, f: float): Vector3 =
  result.x = v.x + f
  result.y = v.y + f
  result.z = v.z + f

proc addNew*(v1, v2: Vector3): Vector3 =
  result.x = v1.x + v2.x
  result.y = v1.y + v2.y
  result.z = v1.z + v2.z

proc addSelf*(v: var Vector4, f: float): var Vector4 {.noinit.} =
  v.x += f
  v.y += f
  v.z += f
  v.w += f
  result = v

proc addSelf*(v1: var Vector4, v2: Vector4): var Vector4 {.noinit.}  =
  v1.x += v2.x
  v1.y += v2.y
  v1.z += v2.z
  v1.w += v2.w
  result = v1

proc addNew*(v: Vector4, f: float): Vector4 =
  result.x = v.x + f
  result.y = v.y + f
  result.z = v.z + f
  result.w = v.w + f

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
# NOTE: Added scalar subtraction to all vectors

proc subtractSelf*(v: var Vector1, f: float): var Vector1 {.noinit.} =
  v.x -= f
  result = v

proc subtractSelf*(v1: var Vector1, v2: Vector1): var Vector1 {.noinit.} =
  v1.x -= v2.x
  result = v1

proc subtractNew*(v: Vector1, f: float): Vector1 =
  result.x = v.x - f

proc subtractNew*(v1, v2: Vector1): Vector1 =
  result.x = v1.x - v2.x

proc subtractSelf*(v: var Vector2, f: float): var Vector2 {.noinit.} =
  v.x -= f
  v.y -= f
  result = v

proc subtractSelf*(v1: var Vector2, v2: Vector2): var Vector2 {.noinit.}  =
  v1.x -= v2.x
  v1.y -= v2.y
  result = v1

proc subtractNew*(v: Vector2, f: float): Vector2 =
  result.x = v.x - f
  result.y = v.y - f

proc subtractNew*(v1, v2: Vector2): Vector2 =
  result.x = v1.x - v2.x
  result.y = v1.y - v2.y

proc subtractSelf*(v: var Vector3, f: float): var Vector3 {.noinit.} =
  v.x -= f
  v.y -= f
  v.z -= f
  result = v

proc subtractSelf*(v1: var Vector3, v2: Vector3): var Vector3 {.noinit.}  =
  v1.x -= v2.x
  v1.y -= v2.y
  v1.z -= v2.z
  result = v1

proc subtractNew*(v: Vector3, f: float): Vector3 =
  result.x = v.x - f
  result.y = v.y - f
  result.z = v.z - f

proc subtractNew*(v1, v2: Vector3): Vector3 =
  result.x = v1.x - v2.x
  result.y = v1.y - v2.y
  result.z = v1.z - v2.z

proc subtractSelf*(v: var Vector4, f: float): var Vector4 {.noinit.} =
  v.x -= f
  v.y -= f
  v.z -= f
  v.w -= f
  result = v

proc subtractSelf*(v1: var Vector4, v2: Vector4): var Vector4 {.noinit.}  =
  v1.x -= v2.x
  v1.y -= v2.y
  v1.z -= v2.z
  v1.w -= v2.w
  result = v1

proc subtractNew*(v: Vector4, f: float): Vector4 =
  result.x = v.x - f
  result.y = v.y - f
  result.z = v.z - f
  result.w = v.w - f

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

# Multiply
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

# Divide
proc divideSelf*(v: var Vector1, f: float): var Vector1 {.noinit.} =
  v.x /= f
  result = v

proc divideNew*(v: Vector1, f: float): Vector1 =
  result.x = v.x / f

proc divideSelf*(v: var Vector2, f: float): var Vector2 {.noinit.}  =
  v.x /= f
  v.y /= f
  result = v

proc divideNew*(v: Vector2, f: float): Vector2 =
  result.x = v.x / f
  result.y = v.y / f

proc divideSelf*(v: var Vector3, f: float): var Vector3 {.noinit.}  =
  v.x /= f
  v.y /= f
  v.z /= f
  result = v

proc divideNew*(v: Vector3, f: float): Vector3 =
  result.x = v.x / f
  result.y = v.y / f
  result.z = v.z / f

proc divideSelf*(v: var Vector4, f: float): var Vector4 {.noinit.}  =
  v.x /= f
  v.y /= f
  v.z /= f
  v.w /= f
  result = v

proc divideNew*(v: Vector4, f: float): Vector4 =
  result.x = v.x / f
  result.y = v.y / f
  result.z = v.z / f
  result.w = v.w / f

# NOTE: This is changed from design doc
template `/`*(v: Vector1, f: float): Vector1 = divideNew(v, f)
template `/`*(v: Vector2, f: float): Vector2 = divideNew(v, f)
template `/`*(v: Vector3, f: float): Vector3 = divideNew(v, f)
template `/`*(v: Vector4, f: float): Vector4 = divideNew(v, f)

# NOTE: This is added from design doc
template `/=`*(v: var Vector1, f: float): var Vector1 = divideSelf(v, f)
template `/=`*(v: var Vector2, f: float): var Vector2 = divideSelf(v, f)
template `/=`*(v: var Vector3, f: float): var Vector3 = divideSelf(v, f)
template `/=`*(v: var Vector4, f: float): var Vector4 = divideSelf(v, f)

# Dot
proc dot*(v1, v2: Vector1): float =
  result = v1.x * v2.x

proc dot*(v1, v2: Vector2): float =
  result = v1.x * v2.x + v1.y * v2.y

proc dot*(v1, v2: Vector3): float =
  result = v1.x * v2.x + v1.y * v2.y + v1.z * v2.z

proc dot*(v1, v2: Vector4): float =
  result = v1.x * v2.x + v1.y * v2.y + v1.z * v2.z + v1.w * v2.w

# Cross

# NOTE: Discuss output (Vector1 or float)
proc cross*(v1, v2: Vector1): float =
  result = v1.x * v2.x

# NOTE: Discuss output (Vector1 or float)
proc cross*(v1, v2: Vector2): float =
  result = v1.x * v2.x - v1.y * v2.y

proc cross*(v1, v2: Vector3): Vector3 =
  result.x = v1.y * v2.z - v1.z * v2.y
  result.y = v1.z * v2.x - v1.x * v2.z
  result.z = v1.x * v2.y - v1.y * v2.x

# NOTE: No 4D cross product

# Inverse

# NOTE: Changed/Added from design doc
proc inverseSelf*(v: var Vector1): var Vector1 {.noinit.} =
  v.x = -v.x
  result = v

proc inverseNew*(v: Vector1): Vector1 =
  result.x = -v.x

proc inverseSelf*(v: var Vector2): var Vector2 {.noinit.} =
  v.x = -v.x
  v.y = -v.y
  result = v

proc inverseNew*(v: Vector2): Vector2 =
  result.x = -v.x
  result.y = -v.y

proc inverseSelf*(v: var Vector3): var Vector3 {.noinit.} =
  v.x = -v.x
  v.y = -v.y
  v.z = -v.z
  result = v

proc inverseNew*(v: Vector3): Vector3 =
  result.x = -v.x
  result.y = -v.y
  result.z = -v.z

proc inverseSelf*(v: var Vector4): var Vector4 {.noinit.} =
  v.x = -v.x
  v.y = -v.y
  v.z = -v.z
  v.w = -v.w
  result = v

proc inverseNew*(v: Vector4): Vector4 =
  result.x = -v.x
  result.y = -v.y
  result.z = -v.z
  result.w = -v.w

template inverse*(v: Vector1): Vector1 = inverseNew(v)
template inverse*(v: Vector2): Vector2 = inverseNew(v)
template inverse*(v: Vector3): Vector3 = inverseNew(v)
template inverse*(v: Vector4): Vector4 = inverseNew(v)

# Heading
# NOTE: Additional heading procs
proc headingXY*(v: Vector2): float =
  result = arctan2(v.y, v.x)

proc headingXY*(v: Vector3): float =
  result = arctan2(v.y, v.x)

proc headingXZ*(v: Vector3): float =
  result = arctan2(v.z, v.x)

proc headingYZ*(v: Vector3): float =
  result = arctan2(v.z, v.y)

proc headingXY*(v: Vector4): float =
  result = arctan2(v.y, v.x)

proc headingXZ*(v: Vector4): float =
  result = arctan2(v.z, v.x)
  
proc headingXW*(v: Vector4): float =
  result = arctan2(v.w, v.x)

proc headingYZ*(v: Vector4): float =
  result = arctan2(v.z, v.y)

proc headingYW*(v: Vector4): float =
  result = arctan2(v.w, v.y)

proc headingZW*(v: Vector4): float =
  result = arctan2(v.w, v.z)

template heading*(v: Vector1): float = 0.0
template heading*(v: Vector2): float = headingXY(v)
template heading*(v: Vector3): float = headingXY(v)
template heading*(v: Vector4): float = headingXY(v)

# Reflect
# NOTE: Changed from design doc
proc reflectSelf*(v: var Vector1, n: Vector1): var Vector1 {.noinit.} =
  v = subtractSelf(v, multiplyNew(n, 2 * dot(v, n)))
  result = v

proc reflectNew*(v, n: Vector1): Vector1 =
  result = subtractNew(v, multiplyNew(n, 2 * dot(v, n)))

proc reflectSelf*(v: var Vector2, n: Vector2): var Vector2 {.noinit.} =
  v = subtractSelf(v, multiplyNew(n, 2 * dot(v, n)))
  result = v

proc reflectNew*(v, n: Vector2): Vector2 =
  result = subtractNew(v, multiplyNew(n, 2 * dot(v, n)))

proc reflectSelf*(v: var Vector3, n: Vector3): var Vector3 {.noinit.} =
  v = subtractSelf(v, multiplyNew(n, 2 * dot(v, n)))
  result = v

proc reflectNew*(v, n: Vector3): Vector3 =
  result = subtractNew(v, multiplyNew(n, 2 * dot(v, n)))

proc reflectSelf*(v: var Vector4, n: Vector4): var Vector4 {.noinit.} =
  v = subtractSelf(v, multiplyNew(n, 2 * dot(v, n)))
  result = v

proc reflectNew*(v, n: Vector4): Vector4 =
  result = subtractNew(v, multiplyNew(n, 2 * dot(v, n)))

# NOTE: Discuss self or new
template reflect*(v, n: Vector1) = reflectNew(v, n)
template reflect*(v, n: Vector2) = reflectNew(v, n)
template reflect*(v, n: Vector3) = reflectNew(v, n)
template reflect*(v, n: Vector4) = reflectNew(v, n)

# String
# NOTE: Changed from design doc
proc `$`*(v: Vector1): string =
  result = &"[{v.x}]"

proc `$`*(v: Vector2): string =
  result = &"[{v.x}, {v.y}]"

proc `$`*(v: Vector3): string =
  result = &"[{v.x}, {v.y}, {v.z}]"

proc `$`*(v: Vector4): string =
  result = &"[{v.x}, {v.y}, {v.z}, {v.w}]"
