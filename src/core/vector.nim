import ./concepts

from math import arctan2, sqrt
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

# Set
proc setSelf*(v: var Vector1, n: float): var Vector1 {.noinit.} =
  v.x = n
  result = v

proc setNew*(v: Vector1, n: float): Vector1 =
  result.x = n

proc setSelf*(v: var Vector2, n: float): var Vector2 {.noinit.} =
  v.x = n
  v.y = n
  result = v

proc setNew*(v: Vector2, n: float): Vector2 =
  result.x = n
  result.y = n

proc setSelf*(v: var Vector3, n: float): var Vector3 {.noinit.} =
  v.x = n
  v.y = n
  v.z = n
  result = v

proc setNew*(v: Vector3, n: float): Vector3 =
  result.x = n
  result.y = n
  result.z = n

proc setSelf*(v: var Vector4, n: float): var Vector4 {.noinit.} =
  v.x = n
  v.y = n
  v.z = n
  v.w = n
  result = v

proc setNew*(v: Vector4, n: float): Vector4 =
  result.x = n
  result.y = n
  result.z = n
  result.w = n

# Copy
proc copy*(v: Vector1): Vector1 =
  result = Vector1(x: v.x)

proc copy*(v: Vector2): Vector2 =
  result = Vector2(x: v.x, y: v.y)

proc copy*(v: Vector3): Vector3 =
  result = Vector3(x: v.x, y: v.y, z: v.z)

proc copy*(v: Vector4): Vector4 =
  result = Vector4(x: v.x, y: v.y, z: v.z, w: v.w)

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

# Refract
# NOTE: Changed from design doc
proc refractSelf*(v: var Vector1, n: Vector1, eta: float): var Vector1 {.noinit.} =
  let 
    d = dot(n, v)
    k = 1.0 - eta * eta * (1.0 - d * d)
  if (k < 0):
    # TODO: Refactor
    v.x = 0.0
  else:
    v = subtractSelf(multiplySelf(v, eta), multiplyNew(n, eta * d * sqrt(k)))
  result = v

proc refractNew*(v, n: Vector1, eta: float): Vector1 =
  let
    d = dot(n, v)
    k = 1.0 - eta * eta * (1.0 - d * d)
  if (k < 0):
    # TODO: Refactor
    result.x = 0.0
  else:
    result = subtractNew(multiplyNew(v, eta), multiplyNew(n, eta * d * sqrt(k)))

proc refractSelf*(v: var Vector2, n: Vector2, eta: float): var Vector2 {.noinit.} =
  let 
    d = dot(n, v)
    k = 1.0 - eta * eta * (1.0 - d * d)
  if (k < 0):
    # TODO: Refactor
    v.x = 0.0
  else:
    v = subtractSelf(multiplySelf(v, eta), multiplyNew(n, eta * d * sqrt(k)))
  result = v

proc refractNew*(v, n: Vector2, eta: float): Vector2 =
  let
    d = dot(n, v)
    k = 1.0 - eta * eta * (1.0 - d * d)
  if (k < 0):
    # TODO: Refactor
    result.x = 0.0
  else:
    result = subtractNew(multiplyNew(v, eta), multiplyNew(n, eta * d * sqrt(k)))

proc refractSelf*(v: var Vector3, n: Vector3, eta: float): var Vector3 {.noinit.} =
  let 
    d = dot(n, v)
    k = 1.0 - eta * eta * (1.0 - d * d)
  if (k < 0):
    # TODO: Refactor
    v.x = 0.0
  else:
    v = subtractSelf(multiplySelf(v, eta), multiplyNew(n, eta * d * sqrt(k)))
  result = v

proc refractNew*(v, n: Vector3, eta: float): Vector3 =
  let
    d = dot(n, v)
    k = 1.0 - eta * eta * (1.0 - d * d)
  if (k < 0):
    # TODO: Refactor
    result.x = 0.0
  else:
    result = subtractNew(multiplyNew(v, eta), multiplyNew(n, eta * d * sqrt(k)))

proc refractSelf*(v: var Vector4, n: Vector4, eta: float): var Vector4 {.noinit.} =
  let 
    d = dot(n, v)
    k = 1.0 - eta * eta * (1.0 - d * d)
  if (k < 0):
    # TODO: Refactor
    v.x = 0.0
  else:
    v = subtractSelf(multiplySelf(v, eta), multiplyNew(n, eta * d * sqrt(k)))
  result = v

proc refractNew*(v, n: Vector4, eta: float): Vector4 =
  let
    d = dot(n, v)
    k = 1.0 - eta * eta * (1.0 - d * d)
  if (k < 0):
    # TODO: Refactor
    result.x = 0.0
  else:
    result = subtractNew(multiplyNew(v, eta), multiplyNew(n, eta * d * sqrt(k)))

template refract*(v, n: Vector1, eta): Vector1 = refractNew(v, n, eta)
template refract*(v, n: Vector2, eta): Vector2 = refractNew(v, n, eta)
template refract*(v, n: Vector3, eta): Vector3 = refractNew(v, n, eta)
template refract*(v, n: Vector4, eta): Vector4 = refractNew(v, n, eta)

# Magnitude
proc magnitude*(v: Vector1): float =
  result = v.x

proc magnitude*(v: Vector2): float =
  result = sqrt(v.x * v.x + v.y * v.y)

proc magnitude*(v: Vector3): float =
  result = sqrt(v.x * v.x + v.y * v.y + v.z * v.z)

proc magnitude*(v: Vector4): float =
  result = sqrt(v.x * v.x + v.y * v.y + v.z * v.z + v.w * v.w)

# Normalize
proc normalizeSelf*(v: var Vector1, m: float = 1.0): var Vector1 {.noinit.} =
  let magnitude = magnitude(v)
  if (magnitude > 0):
    result = multiplySelf(v, m / magnitude)
  else:
    result = v

proc normalizeNew*(v: Vector1, m: float = 1.0): Vector1 =
  let magnitude = magnitude(v)
  if (magnitude > 0):
    result = multiplyNew(v, m / magnitude)
  else:
    result = copy(v)

proc normalizeSelf*(v: var Vector2, m: float = 1.0): var Vector2 {.noinit.} =
  let magnitude = magnitude(v)
  if (magnitude > 0):
    result = multiplySelf(v, m / magnitude)
  else:
    result = v

proc normalizeNew*(v: Vector2, m: float = 1.0): Vector2 =
  let magnitude = magnitude(v)
  if (magnitude > 0):
    result = multiplyNew(v, m / magnitude)
  else:
    result = copy(v)

proc normalizeSelf*(v: var Vector3, m: float = 1.0): var Vector3 {.noinit.} =
  let magnitude = magnitude(v)
  if (magnitude > 0):
    result = multiplySelf(v, m / magnitude)
  else:
    result = v

proc normalizeNew*(v: Vector3, m: float = 1.0): Vector3 =
  let magnitude = magnitude(v)
  if (magnitude > 0):
    result = multiplyNew(v, m / magnitude)
  else:
    result = copy(v)

proc normalizeSelf*(v: var Vector4, m: float = 1.0): var Vector4 {.noinit.} =
  let magnitude = magnitude(v)
  if (magnitude > 0):
    result = multiplySelf(v, m / magnitude)
  else:
    result = v

proc normalizeNew*(v: Vector4, m: float = 1.0): Vector4 =
  let magnitude = magnitude(v)
  if (magnitude > 0):
    result = multiplyNew(v, m / magnitude)
  else:
    result = copy(v)

template normalize*(v: var Vector1, m: float = 1.0): var Vector1 = normalizeSelf(v, m)
template normalize*(v: var Vector2, m: float = 1.0): var Vector2 = normalizeSelf(v, m)
template normalize*(v: var Vector3, m: float = 1.0): var Vector3 = normalizeSelf(v, m)
template normalize*(v: var Vector4, m: float = 1.0): var Vector4 = normalizeSelf(v, m)

# Angle Between

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
