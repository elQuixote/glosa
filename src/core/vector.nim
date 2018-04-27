from ./concepts import 
  Vector, 
  Compare, 
  Equals,
  Hash,
  Transform,
  Length,
  Dimension,
  Set,
  Clear,
  Copy,
  String

export 
  Vector, 
  Compare, 
  Equals,
  Hash,
  Transform,
  Length,
  Dimension,
  Set,
  Clear,
  Copy,
  String

from math import arctan2, arccos, sqrt
from strformat import `&`
import hashes

type
  Vector1* = object
    x*: float
  Vector2* = object
    x*, y*: float
  Vector3* = object
    x*, y*, z*: float
  Vector4* = object
    x*, y*, z*, w*: float

# Constructors
# From parameters
proc vector1*(x: float): Vector1 =
  result.x = x

proc vector2*(x, y: float): Vector2 =
  result.x = x
  result.y = y

proc vector3*(x, y, z: float): Vector3 =
  result.x = x
  result.y = y
  result.z = z

proc vector4*(x, y, z, w: float): Vector4 =
  result.x = x
  result.y = y
  result.z = z
  result.w = w

# From single value
proc vector2*(v: float): Vector2 =
  result.x = v
  result.y = v

proc vector3*(v: float): Vector3 =
  result.x = v
  result.y = v
  result.z = v

proc vector4*(v: float): Vector4 =
  result.x = v
  result.y = v
  result.z = v
  result.w = v

# From vector(s)
# From array
# From sequence
 
# Copy
proc copy*(v: Vector1): Vector1 =
  result = Vector1(x: v.x)

proc copy*(v: Vector2): Vector2 =
  result = Vector2(x: v.x, y: v.y)

proc copy*(v: Vector3): Vector3 =
  result = Vector3(x: v.x, y: v.y, z: v.z)

proc copy*(v: Vector4): Vector4 =
  result = Vector4(x: v.x, y: v.y, z: v.z, w: v.w)

# Set
proc set*(v: var Vector1, n: float): var Vector1 {.noinit.} =
  v.x = n
  result = v

proc set*(v: var Vector2, n: float): var Vector2 {.noinit.} =
  v.x = n
  v.y = n
  result = v

proc set*(v: var Vector3, n: float): var Vector3 {.noinit.} =
  v.x = n
  v.y = n
  v.z = n
  result = v

proc set*(v: var Vector4, n: float): var Vector4 {.noinit.} =
  v.x = n
  v.y = n
  v.z = n
  v.w = n
  result = v

# Clear
proc clear*(v: var Vector1): var Vector1 = set(v, 0.0)
proc clear*(v: var Vector2): var Vector2 = set(v, 0.0)
proc clear*(v: var Vector3): var Vector3 = set(v, 0.0)
proc clear*(v: var Vector4): var Vector4 = set(v, 0.0)

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

proc inverse*(v: Vector1): Vector1 = inverseNew(v)
proc inverse*(v: Vector2): Vector2 = inverseNew(v)
proc inverse*(v: Vector3): Vector3 = inverseNew(v)
proc inverse*(v: Vector4): Vector4 = inverseNew(v)

proc reverse*(v: Vector1): Vector1 = inverseNew(v)
proc reverse*(v: Vector2): Vector2 = inverseNew(v)
proc reverse*(v: Vector3): Vector3 = inverseNew(v)
proc reverse*(v: Vector4): Vector4 = inverseNew(v)

# Invert
# NOTE: Added from design doc
proc invertSelf*(v: var Vector1): var Vector1 {.noinit.} =
  v.x = 1 / v.x
  result = v

proc invertNew*(v: Vector1): Vector1 =
  result.x = 1 / v.x

proc invertSelf*(v: var Vector2): var Vector2 {.noinit.} =
  v.x = 1 / v.x
  v.y = 1 / v.y
  result = v

proc invertNew*(v: Vector2): Vector2 =
  result.x = 1 / v.x
  result.y = 1 / v.y

proc invertSelf*(v: var Vector3): var Vector3 {.noinit.} =
  v.x = 1 / v.x
  v.y = 1 / v.y
  v.z = 1 / v.z
  result = v

proc invertNew*(v: Vector3): Vector3 =
  result.x = 1 / v.x
  result.y = 1 / v.y
  result.z = 1 / v.z

proc invertSelf*(v: var Vector4): var Vector4 {.noinit.} =
  v.x = 1 / v.x
  v.y = 1 / v.y
  v.z = 1 / v.z
  v.w = 1 / v.w
  result = v

proc invertNew*(v: Vector4): Vector4 =
  result.x = 1 / v.x
  result.y = 1 / v.y
  result.z = 1 / v.z
  result.w = 1 / v.w

proc invert*(v: Vector1): Vector1 = invertNew(v)
proc invert*(v: Vector2): Vector2 = invertNew(v)
proc invert*(v: Vector3): Vector3 = invertNew(v)
proc invert*(v: Vector4): Vector4 = invertNew(v)

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
proc `+`*(v1, v2: Vector1): Vector1 = addNew(v1, v2)
proc `+`*(v1, v2: Vector2): Vector2 = addNew(v1, v2)
proc `+`*(v1, v2: Vector3): Vector3 = addNew(v1, v2)
proc `+`*(v1, v2: Vector4): Vector4 = addNew(v1, v2)

proc `+`*(v1: Vector1, f: float): Vector1 = addNew(v1, f)
proc `+`*(v1: Vector2, f: float): Vector2 = addNew(v1, f)
proc `+`*(v1: Vector3, f: float): Vector3 = addNew(v1, f)
proc `+`*(v1: Vector4, f: float): Vector4 = addNew(v1, f)

proc `+`*(f: float, v1: Vector1): Vector1 = addNew(v1, f)
proc `+`*(f: float, v1: Vector2): Vector2 = addNew(v1, f)
proc `+`*(f: float, v1: Vector3): Vector3 = addNew(v1, f)
proc `+`*(f: float, v1: Vector4): Vector4 = addNew(v1, f)

# NOTE: This is added from design doc
proc `+=`*(v1: var Vector1, v2: Vector1) = discard addSelf(v1, v2)
proc `+=`*(v1: var Vector2, v2: Vector2) = discard addSelf(v1, v2)
proc `+=`*(v1: var Vector3, v2: Vector3) = discard addSelf(v1, v2)
proc `+=`*(v1: var Vector4, v2: Vector4) = discard addSelf(v1, v2)

proc `+=`*(v1: var Vector1, f: float) = discard addSelf(v1, f)
proc `+=`*(v1: var Vector2, f: float) = discard addSelf(v1, f)
proc `+=`*(v1: var Vector3, f: float) = discard addSelf(v1, f)
proc `+=`*(v1: var Vector4, f: float) = discard addSelf(v1, f)

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
proc `-`*(v1, v2: Vector1): Vector1 = subtractNew(v1, v2)
proc `-`*(v1, v2: Vector2): Vector2 = subtractNew(v1, v2)
proc `-`*(v1, v2: Vector3): Vector3 = subtractNew(v1, v2)
proc `-`*(v1, v2: Vector4): Vector4 = subtractNew(v1, v2)

proc `-`*(v1: Vector1, f: float): Vector1 = subtractNew(v1, f)
proc `-`*(v1: Vector2, f: float): Vector2 = subtractNew(v1, f)
proc `-`*(v1: Vector3, f: float): Vector3 = subtractNew(v1, f)
proc `-`*(v1: Vector4, f: float): Vector4 = subtractNew(v1, f)

proc `-`*(f: float, v1: Vector1): Vector1 = addNew(inverse(v1), f)
proc `-`*(f: float, v1: Vector2): Vector2 = addNew(inverse(v1), f)
proc `-`*(f: float, v1: Vector3): Vector3 = addNew(inverse(v1), f)
proc `-`*(f: float, v1: Vector4): Vector4 = addNew(inverse(v1), f)

# NOTE: This is added from design doc
proc `-=`*(v1: var Vector1, v2: Vector1) = discard subtractSelf(v1, v2)
proc `-=`*(v1: var Vector2, v2: Vector2) = discard subtractSelf(v1, v2)
proc `-=`*(v1: var Vector3, v2: Vector3) = discard subtractSelf(v1, v2)
proc `-=`*(v1: var Vector4, v2: Vector4) = discard subtractSelf(v1, v2)

proc `-=`*(v1: var Vector1, f: float) = discard subtractSelf(v1, f)
proc `-=`*(v1: var Vector2, f: float) = discard subtractSelf(v1, f)
proc `-=`*(v1: var Vector3, f: float) = discard subtractSelf(v1, f)
proc `-=`*(v1: var Vector4, f: float) = discard subtractSelf(v1, f)

# Multiplication
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
proc `*`*(v: Vector1, f: float): Vector1 = multiplyNew(v, f)
proc `*`*(v: Vector2, f: float): Vector2 = multiplyNew(v, f)
proc `*`*(v: Vector3, f: float): Vector3 = multiplyNew(v, f)
proc `*`*(v: Vector4, f: float): Vector4 = multiplyNew(v, f)

proc `*`*(f: float, v: Vector1): Vector1 = multiplyNew(v, f)
proc `*`*(f: float, v: Vector2): Vector2 = multiplyNew(v, f)
proc `*`*(f: float, v: Vector3): Vector3 = multiplyNew(v, f)
proc `*`*(f: float, v: Vector4): Vector4 = multiplyNew(v, f)

# NOTE: This is added from design doc
proc `*=`*(v: var Vector1, f: float) = discard multiplySelf(v, f)
proc `*=`*(v: var Vector2, f: float) = discard multiplySelf(v, f)
proc `*=`*(v: var Vector3, f: float) = discard multiplySelf(v, f)
proc `*=`*(v: var Vector4, f: float) = discard multiplySelf(v, f)

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
proc `/`*(v: Vector1, f: float): Vector1 = divideNew(v, f)
proc `/`*(v: Vector2, f: float): Vector2 = divideNew(v, f)
proc `/`*(v: Vector3, f: float): Vector3 = divideNew(v, f)
proc `/`*(v: Vector4, f: float): Vector4 = divideNew(v, f)

proc `/`*(f: float, v: Vector1): Vector1 = multiplyNew(invert(v), f)
proc `/`*(f: float, v: Vector2): Vector2 = multiplyNew(invert(v), f)
proc `/`*(f: float, v: Vector3): Vector3 = multiplyNew(invert(v), f)
proc `/`*(f: float, v: Vector4): Vector4 = multiplyNew(invert(v), f)

# NOTE: This is added from design doc
proc `/=`*(v: var Vector1, f: float) = discard divideSelf(v, f)
proc `/=`*(v: var Vector2, f: float) = discard divideSelf(v, f)
proc `/=`*(v: var Vector3, f: float) = discard divideSelf(v, f)
proc `/=`*(v: var Vector4, f: float) = discard divideSelf(v, f)

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

proc heading*(v: Vector1): float = 0.0
proc heading*(v: Vector2): float = headingXY(v)
proc heading*(v: Vector3): float = headingXY(v)
proc heading*(v: Vector4): float = headingXY(v)

# Magnitude
proc magnitude*(v: Vector1): float =
  result = abs(v.x)

proc magnitude*(v: Vector2): float =
  result = sqrt(v.x * v.x + v.y * v.y)

proc magnitude*(v: Vector3): float =
  result = sqrt(v.x * v.x + v.y * v.y + v.z * v.z)

proc magnitude*(v: Vector4): float =
  result = sqrt(v.x * v.x + v.y * v.y + v.z * v.z + v.w * v.w)

# Length
proc length*(v: Vector1): float = magnitude(v)
proc length*(v: Vector2): float = magnitude(v)
proc length*(v: Vector3): float = magnitude(v)
proc length*(v: Vector4): float = magnitude(v)

# Normalize
# Private generic in place normalize
proc gNormalizeSelf[T](v: var T, m: float = 1.0): var T {.noinit.} =
  let magnitude = magnitude(v)
  if (magnitude > 0):
    result = multiplySelf(v, m / magnitude)
  else:
    result = v

# Private generic new normalize
proc gNormalizeNew[T](v: T, m: float = 1.0): T =
  let magnitude = magnitude(v)
  if (magnitude > 0):
    result = multiplyNew(v, m / magnitude)
  else:
    result = copy(v)

proc normalizeSelf*(v: var Vector1, m: float = 1.0): var Vector1 {.noinit.} =
  result = gNormalizeSelf(v, m)

proc normalizeNew*(v: Vector1, m: float = 1.0): Vector1 =
  result = gNormalizeNew(v, m)

proc normalizeSelf*(v: var Vector2, m: float = 1.0): var Vector2 {.noinit.} =
  result = gNormalizeSelf(v, m)

proc normalizeNew*(v: Vector2, m: float = 1.0): Vector2 =
  result = gNormalizeNew(v, m)

proc normalizeSelf*(v: var Vector3, m: float = 1.0): var Vector3 {.noinit.} =
  result = gNormalizeSelf(v, m)

proc normalizeNew*(v: Vector3, m: float = 1.0): Vector3 =
  result = gNormalizeNew(v, m)

proc normalizeSelf*(v: var Vector4, m: float = 1.0): var Vector4 {.noinit.} =
  result = gNormalizeSelf(v, m)

proc normalizeNew*(v: Vector4, m: float = 1.0): Vector4 =
  result = gNormalizeNew(v, m)

proc normalize*(v: var Vector1, m: float = 1.0): var Vector1 = normalizeSelf(v, m)
proc normalize*(v: var Vector2, m: float = 1.0): var Vector2 = normalizeSelf(v, m)
proc normalize*(v: var Vector3, m: float = 1.0): var Vector3 = normalizeSelf(v, m)
proc normalize*(v: var Vector4, m: float = 1.0): var Vector4 = normalizeSelf(v, m)

# Reflect
# NOTE: Changed from design doc
# NOTE: Vectors must be normalized
# Private generic in place reflect
proc gReflectSelf[T](v: var T, n: T): var T {.noinit.} =
  v = subtractSelf(v, multiplyNew(n, 2 * dot(v, n)))
  result = v

# Private generic new reflect
proc gReflectNew[T](v, n: T): T =
  result = subtractNew(v, multiplyNew(n, 2 * dot(v, n)))

proc reflectSelf*(v: var Vector1, n: Vector1): var Vector1 {.noinit.} =
  result = gReflectSelf(v, n)

proc reflectNew*(v, n: Vector1): Vector1 =
  result = gReflectNew(v, n)

proc reflectSelf*(v: var Vector2, n: Vector2): var Vector2 {.noinit.} =
  result = gReflectSelf(v, n)

proc reflectNew*(v, n: Vector2): Vector2 =
  result = gReflectNew(v, n)

proc reflectSelf*(v: var Vector3, n: Vector3): var Vector3 {.noinit.} =
  result = gReflectSelf(v, n)

proc reflectNew*(v, n: Vector3): Vector3 =
  result = gReflectNew(v, n)

proc reflectSelf*(v: var Vector4, n: Vector4): var Vector4 {.noinit.} =
  result = gReflectSelf(v, n)

proc reflectNew*(v, n: Vector4): Vector4 =
  result = gReflectNew(v, n)

# NOTE: Discuss self or new
proc reflect*(v, n: Vector1): Vector1 = reflectNew(v, n)
proc reflect*(v, n: Vector2): Vector2 = reflectNew(v, n)
proc reflect*(v, n: Vector3): Vector3 = reflectNew(v, n)
proc reflect*(v, n: Vector4): Vector4 = reflectNew(v, n)

# Refract
# NOTE: Changed from design doc
# NOTE: Vectors must be normalized
# Private generic in place refract
proc gRefractSelf[T](v: var T, n: T, eta: float): var T {.noinit.} =
  let 
    d = dot(n, v)
    k = 1.0 - eta * eta * (1.0 - d * d)
  if (k < 0):
    result = set(v, 0.0)
  else:
    result = subtractSelf(multiplySelf(v, eta), multiplyNew(n, eta * d + sqrt(k)))

# Private generic new refract
proc gRefractNew[T](v, n: T, eta: float): T =
  let
    d = dot(n, v)
    k = 1.0 - eta * eta * (1.0 - d * d)
  if (k < 0):
    result = set(result, 0.0)
  else:
    # NOTE: Should this be refactored?
    result = subtractNew(multiplyNew(v, eta), multiplyNew(n, eta * d + sqrt(k)))

proc refractSelf*(v: var Vector1, n: Vector1, eta: float): var Vector1 {.noinit.} =
  result = gRefractSelf(v, n, eta)

proc refractNew*(v, n: Vector1, eta: float): Vector1 =
  result = gRefractNew(v, n, eta)

proc refractSelf*(v: var Vector2, n: Vector2, eta: float): var Vector2 {.noinit.} =
  result = gRefractSelf(v, n, eta)

proc refractNew*(v, n: Vector2, eta: float): Vector2 =
 result = gRefractNew(v, n, eta)

proc refractSelf*(v: var Vector3, n: Vector3, eta: float): var Vector3 {.noinit.} =
  result = gRefractSelf(v, n, eta)

proc refractNew*(v, n: Vector3, eta: float): Vector3 =
 result = gRefractNew(v, n, eta)

proc refractSelf*(v: var Vector4, n: Vector4, eta: float): var Vector4 {.noinit.} =
  result = gRefractSelf(v, n, eta)

proc refractNew*(v, n: Vector4, eta: float): Vector4 =
 result = gRefractNew(v, n, eta)

proc refract*(v, n: Vector1, eta: float): Vector1 = refractNew(v, n, eta)
proc refract*(v, n: Vector2, eta: float): Vector2 = refractNew(v, n, eta)
proc refract*(v, n: Vector3, eta: float): Vector3 = refractNew(v, n, eta)
proc refract*(v, n: Vector4, eta: float): Vector4 = refractNew(v, n, eta)

# Angle Between
proc angleBetween*(v1, v2: Vector1): float =
  result = 0.0

proc angleBetween*(v1, v2: Vector2): float =
  result = arccos(dot(v1, v2) / (magnitude(v1) * magnitude(v2)))

proc angleBetween*(v1, v2: Vector3): float =
  result = arccos(dot(v1, v2) / (magnitude(v1) * magnitude(v2)))

proc angleBetween*(v1, v2: Vector4): float =
  result = arccos(dot(v1, v2) / (magnitude(v1) * magnitude(v2)))

# Compare (compares magnitudes)
proc `>`*(v1, v2: Vector1): bool =
  result = magnitude(v1) > magnitude(v2)

proc `<`*(v1, v2: Vector1): bool =
  result = magnitude(v1) < magnitude(v2)

proc `>=`*(v1, v2: Vector1): bool =
  result = magnitude(v1) >= magnitude(v2)

proc `<=`*(v1, v2: Vector1): bool =
  result = magnitude(v1) <= magnitude(v2)

proc `>`*(v1, v2: Vector2): bool =
  result = magnitude(v1) > magnitude(v2)

proc `<`*(v1, v2: Vector2): bool =
  result = magnitude(v1) < magnitude(v2)

proc `>=`*(v1, v2: Vector2): bool =
  result = magnitude(v1) >= magnitude(v2)

proc `<=`*(v1, v2: Vector2): bool =
  result = magnitude(v1) <= magnitude(v2)

proc `>`*(v1, v2: Vector3): bool =
  result = magnitude(v1) > magnitude(v2)

proc `<`*(v1, v2: Vector3): bool =
  result = magnitude(v1) < magnitude(v2)

proc `>=`*(v1, v2: Vector3): bool =
  result = magnitude(v1) >= magnitude(v2)

proc `<=`*(v1, v2: Vector3): bool =
  result = magnitude(v1) <= magnitude(v2)

proc `>`*(v1, v2: Vector4): bool =
  result = magnitude(v1) > magnitude(v2)

proc `<`*(v1, v2: Vector4): bool =
  result = magnitude(v1) < magnitude(v2)

proc `>=`*(v1, v2: Vector4): bool =
  result = magnitude(v1) >= magnitude(v2)

proc `<=`*(v1, v2: Vector4): bool =
  result = magnitude(v1) <= magnitude(v2)

# Equals (compares coordinates)
proc `==`*(v1, v2: Vector1): bool =
  result = v1.x == v2.x

proc `==`*(v1, v2: Vector2): bool =
  result = v1.x == v2.x and v1.y == v2.y

proc `==`*(v1, v2: Vector3): bool =
  result = v1.x == v2.x and v1.y == v2.y and v1.z == v2.z

proc `==`*(v1, v2: Vector4): bool =
  result = v1.x == v2.x and v1.y == v2.y and v1.z == v2.z and v1.w == v2.w

# Non Equals
proc `!=`*(v1, v2: Vector1): bool =
  result = not (v1 == v2)

proc `!=`*(v1, v2: Vector2): bool =
  result = not (v1 == v2)

proc `!=`*(v1, v2: Vector3): bool =
  result = not (v1 == v2)

proc `!=`*(v1, v2: Vector4): bool =
  result = not (v1 == v2)

# Hash
proc hash*(v: Vector1): hashes.Hash =
  result = !$(result !& hash(v.x))

proc hash*(v: Vector2): hashes.Hash =
  result = !$(result !& hash(v.x) !& hash(v.y))

proc hash*(v: Vector3): hashes.Hash =
  result = !$(result !& hash(v.x) !& hash(v.y) !& hash(v.z))

proc hash*(v: Vector4): hashes.Hash =
  result = !$(result !& hash(v.x) !& hash(v.y) !& hash(v.z) !& hash(v.w))

# Dimension
proc dimension*(v: Vector1): int =
  result = 1

proc dimension*(v: Vector2): int =
  result = 2

proc dimension*(v: Vector3): int =
  result = 3

proc dimension*(v: Vector4): int =
  result = 4

# Iterators
# NOTE: Added from design doc
# NOTE: Using Nim paradigm (items, fields, pairs, etc)
iterator elements*(v: Vector1): float =
  yield v.x

iterator elements*(v: Vector2): float =
  yield v.x
  yield v.y

iterator elements*(v: Vector3): float =
  yield v.x
  yield v.y
  yield v.z

iterator elements*(v: Vector4): float =
  yield v.x
  yield v.y
  yield v.z
  yield v.w

# NOTE: Added from design doc
# NOTE: Using Nim paradigm (items, fields, pairs, etc)
iterator pairs*(v: Vector1): tuple[key: int, value: float] =
  yield (0, v.x)

iterator pairs*(v: Vector2): tuple[key: int, value: float] =
  yield (0, v.x)
  yield (1, v.y)

iterator pairs*(v: Vector3): tuple[key: int, value: float] =
  yield (0, v.x)
  yield (1, v.y)
  yield (2, v.z)

iterator pairs*(v: Vector4): tuple[key: int, value: float] =
  yield (0, v.x)
  yield (1, v.y)
  yield (2, v.z)
  yield (3, v.w)

# Converters
# NOTE: Added from design doc
proc toArray*(v: Vector1): array[1, float] =
  result = [v.x]

proc toArray*(v: Vector2): array[2, float] =
  result = [v.x, v.y]

proc toArray*(v: Vector3): array[3, float] =
  result = [v.x, v.y, v.z]

proc toArray*(v: Vector4): array[4, float] =
  result = [v.x, v.y, v.z, v.w]

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