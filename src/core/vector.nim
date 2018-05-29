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

from ./types import
  Vector1,
  Vector2,
  Vector3,
  Vector4,
  Matrix33,
  Matrix44,
  Quaternion

from ./errors import
  InvalidCrossProductError

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
  String,
  Vector1,
  Vector2,
  Vector3,
  Vector4,
  InvalidCrossProductError

# from ./constants import
#   ETA

from ./matrix import
  matrix44,
  invert,
  `[]`

import macros
from math import sin, cos, arctan2, arccos, sqrt
from random import rand
from strformat import `&`
import hashes
import json

proc `[]`*(v: Vector1, i: int): float =
  case i:
  of 0: result = v.x
  else: assert(false)
proc `[]`*(v: Vector2, i: int): float =
  case i:
  of 0: result = v.x
  of 1: result = v.y
  else: assert(false)
proc `[]`*(v: Vector3, i: int): float =
  case i:
  of 0: result = v.x
  of 1: result = v.y
  of 2: result = v.z
  else: assert(false)
proc `[]`*(v: Vector4, i: int): float =
  case i:
  of 0: result = v.x
  of 1: result = v.y
  of 2: result = v.z
  of 3: result = v.w
  else: assert(false)

proc `[]=`*(v: var Vector1, i: int, value: float): float =
  case i:
  of 0: v.x = value
  else: assert(false)
proc `[]=`*(v: var Vector2, i: int, value: float): float =
  case i:
  of 0: v.x = value
  of 1: v.y = value
  else: assert(false)
proc `[]=`*(v: var Vector3, i: int, value: float): float =
  case i:
  of 0: v.x = value
  of 1: v.y = value
  of 2: v.z = value
  else: assert(false)
proc `[]=`*(v: var Vector4, i: int, value: float): float =
  case i:
  of 0: v.x = value
  of 1: v.y = value
  of 2: v.z = value
  of 3: v.w = value
  else: assert(false)

macro generateSwizzleProcs(t: typed, chars: static[string]): untyped =
  result = newStmtList()
  for i in chars:
    for j in chars:
      let
        iIdent = ident("" & i)
        jIdent = ident("" & j)
        ijString = i & j
        ijIdent = ident(ijString)
      result.add quote do:
        proc `ijIdent`*(v: `t`): Vector2 =
          Vector2(x: v.`iIdent`, y: v.`jIdent`)
      for k in chars:
        let
          kIdent = ident("" & k)
          ijkString = ijString & k
          ijkIdent = ident(ijkString)
        result.add quote do:
          proc `ijkIdent`*(v: `t`): Vector3 =
            Vector3(x: v.`iIdent`, y: v.`jIdent`, z: v.`kIdent`)
        for m in chars:
          let
            mIdent = ident("" & m)
            ijkmIdent = ident(ijkString & m)
          result.add quote do:
            proc `ijkmIdent`*(v: `t`): Vector4 =
              Vector4(x: v.`iIdent`, y: v.`jIdent`, z: v.`kIdent`, w: v.`mIdent`)

generateSwizzleProcs(Vector1, "x")
generateSwizzleProcs(Vector2, "xy")
generateSwizzleProcs(Vector3, "xyz")
generateSwizzleProcs(Vector4, "xyzw")

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
proc vector1*(v: Vector2): Vector1 =
  result.x = v.x
proc vector1*(v: Vector3): Vector1 =
  result.x = v.x
proc vector1*(v: Vector4): Vector1 =
  result.x = v.x

proc vector2*(v: Vector1, y: float = 0.0): Vector2 =
  result.x = v.x
  result.y = y
proc vector2*(v: Vector3): Vector2 =
  result.x = v.x
  result.y = v.y
proc vector2*(v: Vector4): Vector2 =
  result.x = v.x
  result.y = v.y

proc vector3*(v: Vector1, y, z: float = 0.0): Vector3 =
  result.x = v.x
  result.y = y
  result.z = z
proc vector3*(v: Vector2, z: float = 0.0): Vector3 =
  result.x = v.x
  result.y = v.y
  result.z = z
proc vector3*(v: Vector4): Vector3 =
  result.x = v.x
  result.y = v.y
  result.z = v.z

proc vector4*(v: Vector1, y, z, w: float = 0.0): Vector4 =
  result.x = v.x
  result.y = y
  result.z = z
  result.w = w
proc vector4*(v: Vector2, z, w: float = 0.0): Vector4 =
  result.x = v.x
  result.y = v.y
  result.z = z
  result.w = w
proc vector4*(v: Vector3, w: float = 0.0): Vector4 =
  result.x = v.x
  result.y = v.y
  result.z = v.z
  result.w = w

# From array
proc vector1*(a: array[1, float]): Vector1 =
  result.x = a[0]

proc vector2*(a: array[2, float]): Vector2 =
  result.x = a[0]
  result.y = a[1]

proc vector3*(a: array[3, float]): Vector3 =
  result.x = a[0]
  result.y = a[1]
  result.z = a[2]

proc vector4*(a: array[4, float]): Vector4 =
  result.x = a[0]
  result.y = a[1]
  result.z = a[2]
  result.w = a[3]

# From sequence
proc vector1*(s: seq[float]): Vector1 =
  result.x = s[0]

proc vector2*(s: seq[float]): Vector2 =
  result.x = s[0]
  result.y = s[1]

proc vector3*(s: seq[float]): Vector3 =
  result.x = s[0]
  result.y = s[1]
  result.z = s[2]

proc vector4*(s: seq[float]): Vector4 =
  result.x = s[0]
  result.y = s[1]
  result.z = s[2]
  result.w = s[3]

# From Polar/N-Spherical Coordinates
# NOTE: Why do n-sphere coordinates to cartesian (x, y, etc.) map like this?
proc fromRadial*(r: float): Vector1 =
  result = vector1(r)

proc fromPolar*(r, theta: float): Vector2 =
  result = vector2(
    r * cos(theta),
    r * sin(theta)
  )

proc fromSpherical*(r, theta, phi: float): Vector3 =
  result = vector3(
    r * sin(theta) * cos(phi),
    r * sin(theta) * sin(phi),
    r * cos(theta)
  )

proc from0Spherical*(r: float): Vector1 = fromRadial(r)
proc from1Spherical*(r, theta: float): Vector2 = fromPolar(r, theta)
proc from2Spherical*(r, theta, phi: float): Vector3 = fromSpherical(r, theta, phi)
proc from3Spherical*(r, theta, phi, psi: float): Vector4 =
  result = vector4(
    r * sin(theta) * sin(phi) * cos(psi),
    r * sin(theta) * sin(phi) * sin(psi),
    r * sin(theta) * cos(phi),
    r * cos(theta)
  )

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
proc set*(v: var Vector1, x: float): var Vector1 {.noinit.} =
  v.x = x
  result = v

proc set*(v: var Vector2, x, y: float): var Vector2 {.noinit.} =
  v.x = x
  v.y = y
  result = v

proc set*(v: var Vector2, n: float): var Vector2 {.noinit.} =
  v.x = n
  v.y = n
  result = v

proc set*(v: var Vector3, x, y, z: float): var Vector3 {.noinit.} =
  v.x = x
  v.y = y
  v.z = z
  result = v

proc set*(v: var Vector3, n: float): var Vector3 {.noinit.} =
  v.x = n
  v.y = n
  v.z = n
  result = v

proc set*(v: var Vector4, x, y, z, w: float): var Vector4 {.noinit.} =
  v.x = x
  v.y = y
  v.z = z
  v.w = w
  result = v

proc set*(v: var Vector4, n: float): var Vector4 {.noinit.} =
  v.x = n
  v.y = n
  v.z = n
  v.w = n
  result = v

# Randomize
# NOTE: Replaces random() constructor from design doc
proc randomize*(v: var Vector1, maxX: float = 1.0): var Vector1 {.noinit.} =
  v.x = rand(maxX)
  result = v

proc randomize*(v: var Vector2, maxX, maxY: float = 1.0): var Vector2 {.noinit.} =
  v.x = rand(maxX)
  v.y = rand(maxX)
  result = v

proc randomize*(v: var Vector3, maxX, maxY, maxZ: float = 1.0): var Vector3 {.noinit.} =
  v.x = rand(maxX)
  v.y = rand(maxY)
  v.z = rand(maxZ)
  result = v

proc randomize*(v: var Vector4, maxX, maxY, maxZ, maxW: float = 1.0): var Vector4 {.noinit.} =
  v.x = rand(maxX)
  v.y = rand(maxY)
  v.z = rand(maxZ)
  v.w = rand(maxW)
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
  result = v1.x * v2.y - v1.y * v2.x

proc cross*(v1, v2: Vector3): Vector3 =
  result.x = v1.y * v2.z - v1.z * v2.y
  result.y = v1.z * v2.x - v1.x * v2.z
  result.z = v1.x * v2.y - v1.y * v2.x

proc cross*(v1, v2: Vector4) =
  raise newException(InvalidCrossProductError,
    "Cannot calculate cross product of Vector4s")

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
proc magnitudeSquared*(v: Vector1): float {.inline.} =
  result = v.x * v.x

proc magnitudeSquared*(v: Vector2): float {.inline.} =
  result = v.x * v.x + v.y * v.y

proc magnitudeSquared*(v: Vector3): float {.inline.} =
  result = v.x * v.x + v.y * v.y + v.z * v.z

proc magnitudeSquared*(v: Vector4): float {.inline.} =
  result = v.x * v.x + v.y * v.y + v.z * v.z + v.w * v.w

proc magnitude*(v: Vector1): float =
  result = abs(v.x)

proc magnitude*(v: Vector2): float =
  result = sqrt(magnitudeSquared(v))

proc magnitude*(v: Vector3): float =
  result = sqrt(magnitudeSquared(v))

proc magnitude*(v: Vector4): float =
  result = sqrt(magnitudeSquared(v))

# Length
proc length*(v: Vector1): float = magnitude(v)
proc length*(v: Vector2): float = magnitude(v)
proc length*(v: Vector3): float = magnitude(v)
proc length*(v: Vector4): float = magnitude(v)

# Distance To
# NOTE: This is added from design doc
proc distanceToSquared*(v1, v2: Vector2): float =
  var a = v1.x - v2.x
  var b = v1.y - v2.y
  result = a * a + b * b

proc distanceToSquared*(v1, v2: Vector3): float =
  var a = v1.x - v2.x
  var b = v1.y - v2.y
  var c = v1.z - v2.z
  result = a * a + b * b + c * c

proc distanceToSquared*(v1, v2: Vector4): float =
  var a = v1.x - v2.x
  var b = v1.y - v2.y
  var c = v1.z - v2.z
  var d = v1.w - v2.w
  result = a * a + b * b + c * c + d * d

proc distanceTo*(v1, v2: Vector1): float =
  result = v1.subtractNew(v2).length()

proc distanceTo*(v1, v2: Vector2): float =
  result = v1.subtractNew(v2).length()

proc distanceTo*(v1, v2: Vector3): float =
  result = v1.subtractNew(v2).length()

proc distanceTo*(v1, v2: Vector4): float =
  result = v1.subtractNew(v2).length()

# Interpolate To
# NOTE: This is added from design doc
proc interpolateTo*(v1, v2: Vector1, f: float): Vector1 =
  result.x = v1.x + (v2.x - v1.x) * f

proc interpolateTo*(v1, v2: Vector2, f: float): Vector2 =
  result.x = v1.x + (v2.x - v1.x) * f
  result.y = v1.y + (v2.y - v1.y) * f

proc interpolateTo*(v1, v2: Vector3, f: float): Vector3 =
  result.x = v1.x + (v2.x - v1.x) * f
  result.y = v1.y + (v2.y - v1.y) * f
  result.z = v1.z + (v2.z - v1.z) * f

proc interpolateTo*(v1, v2: Vector4, f: float): Vector4 =
  result.x = v1.x + (v2.x - v1.x) * f
  result.y = v1.y + (v2.y - v1.y) * f
  result.z = v1.z + (v2.z - v1.z) * f
  result.z = v1.w + (v2.w - v1.w) * f

# Normalize
# Private generic in place normalize
proc calculateNormalize[T](v: var T, m: float = 1.0): var T {.noinit.} =
  let magnitude = magnitude(v)
  if (magnitude > 0):
    result = multiplySelf(v, m / magnitude)
  else:
    result = v

proc normalizeSelf*(v: var Vector1, m: float = 1.0): var Vector1 {.noinit.} =
  result = calculateNormalize(v, m)

proc normalizeNew*(v: Vector1, m: float = 1.0): Vector1 =
  var w = copy(v)
  result = calculateNormalize(w, m)

proc normalizeSelf*(v: var Vector2, m: float = 1.0): var Vector2 {.noinit.} =
  result = calculateNormalize(v, m)

proc normalizeNew*(v: Vector2, m: float = 1.0): Vector2 =
  var w = copy(v)
  result = calculateNormalize(w, m)

proc normalizeSelf*(v: var Vector3, m: float = 1.0): var Vector3 {.noinit.} =
  result = calculateNormalize(v, m)

proc normalizeNew*(v: Vector3, m: float = 1.0): Vector3 =
  var w = copy(v)
  result = calculateNormalize(w, m)

proc normalizeSelf*(v: var Vector4, m: float = 1.0): var Vector4 {.noinit.} =
  result = calculateNormalize(v, m)

proc normalizeNew*(v: Vector4, m: float = 1.0): Vector4 =
  var w = copy(v)
  result = calculateNormalize(w, m)

proc normalize*(v: var Vector1, m: float = 1.0): var Vector1 = normalizeSelf(v, m)
proc normalize*(v: var Vector2, m: float = 1.0): var Vector2 = normalizeSelf(v, m)
proc normalize*(v: var Vector3, m: float = 1.0): var Vector3 = normalizeSelf(v, m)
proc normalize*(v: var Vector4, m: float = 1.0): var Vector4 = normalizeSelf(v, m)

# Reflect
# NOTE: Changed from design doc
# NOTE: Vectors must be normalized
# Private generic in place reflect
proc calculateReflect[T](v: var T, n: T): var T {.noinit.} =
  v = subtractSelf(v, multiplyNew(n, 2 * dot(v, n)))
  result = v

proc reflectSelf*(v: var Vector1, n: Vector1): var Vector1 {.noinit.} =
  result = calculateReflect(v, n)

proc reflectNew*(v, n: Vector1): Vector1 =
  var w = copy(v)
  result = calculateReflect(w, n)

proc reflectSelf*(v: var Vector2, n: Vector2): var Vector2 {.noinit.} =
  result = calculateReflect(v, n)

proc reflectNew*(v, n: Vector2): Vector2 =
  var w = copy(v)
  result = calculateReflect(w, n)

proc reflectSelf*(v: var Vector3, n: Vector3): var Vector3 {.noinit.} =
  result = calculateReflect(v, n)

proc reflectNew*(v, n: Vector3): Vector3 =
  var w = copy(v)
  result = calculateReflect(w, n)

proc reflectSelf*(v: var Vector4, n: Vector4): var Vector4 {.noinit.} =
  result = calculateReflect(v, n)

proc reflectNew*(v, n: Vector4): Vector4 =
  var w = copy(v)
  result = calculateReflect(w, n)

# NOTE: Discuss self or new
proc reflect*(v, n: Vector1): Vector1 = reflectNew(v, n)
proc reflect*(v, n: Vector2): Vector2 = reflectNew(v, n)
proc reflect*(v, n: Vector3): Vector3 = reflectNew(v, n)
proc reflect*(v, n: Vector4): Vector4 = reflectNew(v, n)

# Refract
# NOTE: Changed from design doc
# NOTE: Vectors must be normalized
# Private generic in place refract
proc calculateRefract[T](v: var T, n: T, eta: float): var T {.noinit.} =
  let
    d = dot(n, v)
    k = 1.0 - eta * eta * (1.0 - d * d)
  if (k < 0):
    result = set(v, 0.0)
  else:
    result = subtractSelf(multiplySelf(v, eta), multiplyNew(n, eta * d + sqrt(k)))

proc refractSelf*(v: var Vector1, n: Vector1, eta: float): var Vector1 {.noinit.} =
  result = calculateRefract(v, n, eta)

proc refractNew*(v, n: Vector1, eta: float): Vector1 =
  var w = copy(v)
  result = calculateRefract(w, n, eta)

proc refractSelf*(v: var Vector2, n: Vector2, eta: float): var Vector2 {.noinit.} =
  result = calculateRefract(v, n, eta)

proc refractNew*(v, n: Vector2, eta: float): Vector2 =
  var w = copy(v)
  result = calculateRefract(w, n, eta)

proc refractSelf*(v: var Vector3, n: Vector3, eta: float): var Vector3 {.noinit.} =
  result = calculateRefract(v, n, eta)

proc refractNew*(v, n: Vector3, eta: float): Vector3 =
  var w = copy(v)
  result = calculateRefract(w, n, eta)

proc refractSelf*(v: var Vector4, n: Vector4, eta: float): var Vector4 {.noinit.} =
  result = calculateRefract(v, n, eta)

proc refractNew*(v, n: Vector4, eta: float): Vector4 =
  var w = copy(v)
  result = calculateRefract(w, n, eta)

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
  result = magnitudeSquared(v1) > magnitudeSquared(v2)

proc `<`*(v1, v2: Vector1): bool =
  result = magnitudeSquared(v1) < magnitudeSquared(v2)

proc `>=`*(v1, v2: Vector1): bool =
  result = magnitudeSquared(v1) >= magnitudeSquared(v2)

proc `<=`*(v1, v2: Vector1): bool =
  result = magnitudeSquared(v1) <= magnitudeSquared(v2)

proc `>`*(v1, v2: Vector2): bool =
  result = magnitudeSquared(v1) > magnitudeSquared(v2)

proc `<`*(v1, v2: Vector2): bool =
  result = magnitudeSquared(v1) < magnitudeSquared(v2)

proc `>=`*(v1, v2: Vector2): bool =
  result = magnitudeSquared(v1) >= magnitudeSquared(v2)

proc `<=`*(v1, v2: Vector2): bool =
  result = magnitudeSquared(v1) <= magnitudeSquared(v2)

proc `>`*(v1, v2: Vector3): bool =
  result = magnitudeSquared(v1) > magnitudeSquared(v2)

proc `<`*(v1, v2: Vector3): bool =
  result = magnitudeSquared(v1) < magnitudeSquared(v2)

proc `>=`*(v1, v2: Vector3): bool =
  result = magnitudeSquared(v1) >= magnitudeSquared(v2)

proc `<=`*(v1, v2: Vector3): bool =
  result = magnitudeSquared(v1) <= magnitudeSquared(v2)

proc `>`*(v1, v2: Vector4): bool =
  result = magnitudeSquared(v1) > magnitudeSquared(v2)

proc `<`*(v1, v2: Vector4): bool =
  result = magnitudeSquared(v1) < magnitudeSquared(v2)

proc `>=`*(v1, v2: Vector4): bool =
  result = magnitudeSquared(v1) >= magnitudeSquared(v2)

proc `<=`*(v1, v2: Vector4): bool =
  result = magnitudeSquared(v1) <= magnitudeSquared(v2)

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

# Transformations
# Transform
proc transformSelf*(v: var Vector1, m: Matrix33): var Vector1 {.noinit.} =
  v.x *= m[0, 0]
  result = v

proc transformNew*(v: Vector1, m: Matrix33): Vector1 =
  result.x = m[0, 0] * v.x

proc transformSelf*(v: var Vector2, m: Matrix33): var Vector2 {.noinit.} =
  v.x = m[0, 0] * v.x + m[0, 1] * v.y
  v.y = m[1, 0] * v.x + m[1, 1] * v.y
  result = v

proc transformNew*(v: Vector2, m: Matrix33): Vector2 =
  result.x = m[0, 0] * v.x + m[0, 1] * v.y
  result.y = m[1, 0] * v.x + m[1, 1] * v.y

proc transformSelf*(v: var Vector3, m: Matrix44): var Vector3 {.noinit.} =
  v.x = m[0, 0] * v.x + m[0, 1] * v.y + m[0, 2] * v.z
  v.y = m[1, 0] * v.x + m[1, 1] * v.y + m[1, 2] * v.z
  v.z = m[2, 0] * v.z + m[2, 1] * v.y + m[2, 2] * v.z
  result = v

proc transformNew*(v: Vector3, m: Matrix44): Vector3 =
  result.x = m[0, 0] * v.x + m[0, 1] * v.y + m[0, 2] * v.z
  result.y = m[1, 0] * v.x + m[1, 1] * v.y + m[1, 2] * v.z
  result.z = m[2, 0] * v.z + m[2, 1] * v.y + m[2, 2] * v.z

proc transformSelf*(v: var Vector4, m: Matrix44): var Vector4 {.noinit.} =
  v.x = m[0, 0] * v.x + m[0, 1] * v.y + m[0, 2] * v.z + m[0, 3] * v.w
  v.y = m[1, 0] * v.x + m[1, 1] * v.y + m[1, 2] * v.z + m[1, 3] * v.w
  v.z = m[2, 0] * v.x + m[2, 1] * v.y + m[2, 2] * v.z + m[2, 3] * v.w
  v.w = m[3, 0] * v.x + m[3, 1] * v.y + m[3, 2] * v.z + m[3, 3] * v.w
  result = v

proc transformNew*(v: Vector4, m: Matrix44): Vector4 =
  result.x = m[0, 0] * v.x + m[0, 1] * v.y + m[0, 2] * v.z + m[0, 3] * v.w
  result.y = m[1, 0] * v.x + m[1, 1] * v.y + m[1, 2] * v.z + m[1, 3] * v.w
  result.z = m[2, 0] * v.x + m[2, 1] * v.y + m[2, 2] * v.z + m[2, 3] * v.w
  result.w = m[3, 0] * v.x + m[3, 1] * v.y + m[3, 2] * v.z + m[3, 3] * v.w

proc transform*(v: var Vector1, m: Matrix33): var Vector1 {.noinit.} = transformSelf(v, m)
proc transform*(v: var Vector2, m: Matrix33): var Vector2 {.noinit.} = transformSelf(v, m)
proc transform*(v: var Vector3, m: Matrix44): var Vector3 {.noinit.} = transformSelf(v, m)
proc transform*(v: var Vector4, m: Matrix44): var Vector4 {.noinit.} = transformSelf(v, m)

# Rotate
# Private calculate new rotation coordinates
proc calculateRotate(a, b, theta: float): tuple[a, b: float] =
  let
    s = sin(theta)
    c = cos(theta)
  result = (a: a * c - b * s, b: b * c + a * s)

proc rotateSelf*(v: var Vector1, theta: float): var Vector1 {.noinit.} =
  result = v

proc rotateNew*(v: Vector1, theta: float): Vector1 =
  result = copy(v)

proc rotateSelf*(v: var Vector2, theta: float): var Vector2 {.noinit.} =
  let r = calculateRotate(v.x, v.y, theta)
  result = set(v, r.a, r.b)

proc rotateNew*(v: Vector2, theta: float): Vector2 =
  let r = calculateRotate(v.x, v.y, theta)
  result = vector2(r.a, r.b)

proc rotateXSelf*(v: var Vector3, theta: float): var Vector3 {.noinit.} =
  let r = calculateRotate(v.y, v.z, theta)
  result = set(v, v.x, r.a, r.b)

proc rotateXNew*(v: Vector3, theta: float): Vector3 =
  let r = calculateRotate(v.y, v.z, theta)
  result = vector3(v.x, r.a, r.b)

proc rotateYSelf*(v: var Vector3, theta: float): var Vector3 {.noinit.} =
  let r = calculateRotate(v.x, v.z, theta)
  result = set(v, r.a, v.y, r.b)

proc rotateYNew*(v: Vector3, theta: float): Vector3 =
  let r = calculateRotate(v.x, v.z, theta)
  result = vector3(r.a, v.y, r.b)

proc rotateZSelf*(v: var Vector3, theta: float): var Vector3 {.noinit.} =
  let r = calculateRotate(v.x, v.y, theta)
  result = set(v, r.a, r.b, v.z)

proc rotateZNew*(v: Vector3, theta: float): Vector3 =
  let r = calculateRotate(v.x, v.y, theta)
  result = vector3(r.a, r.b, v.z)

proc rotateXYSelf*(v: var Vector4, theta: float): var Vector4 {.noinit.} =
  let r = calculateRotate(v.z, v.w, theta)
  result = set(v, v.x, v.y, r.a, r.b)

proc rotateXYNew*(v: Vector4, theta: float): Vector4 =
  let r = calculateRotate(v.z, v.w, theta)
  result = vector4(v.x, v.y, r.a, r.b)

proc rotateXZSelf*(v: var Vector4, theta: float): var Vector4 {.noinit.} =
  let r = calculateRotate(v.y, v.w, theta)
  result = set(v, v.x, r.a, v.z, r.b)

proc rotateXZNew*(v: Vector4, theta: float): Vector4 =
  let r = calculateRotate(v.y, v.w, theta)
  result = vector4(v.x, r.a, v.z, r.b)

proc rotateXWSelf*(v: var Vector4, theta: float): var Vector4 {.noinit.} =
  let r = calculateRotate(v.y, v.z, theta)
  result = set(v, v.x, r.a, r.b, v.w)

proc rotateXWNew*(v: Vector4, theta: float): Vector4 =
  let r = calculateRotate(v.y, v.z, theta)
  result = vector4(v.x, r.a, r.b, v.w)

proc rotateYZSelf*(v: var Vector4, theta: float): var Vector4 {.noinit.} =
  let r = calculateRotate(v.x, v.w, theta)
  result = set(v, r.a, v.y, v.z, r.b)

proc rotateYZNew*(v: Vector4, theta: float): Vector4 =
  let r = calculateRotate(v.x, v.w, theta)
  result = vector4(r.a, v.y, v.z, r.b)

proc rotateYWSelf*(v: var Vector4, theta: float): var Vector4 {.noinit.} =
  let r = calculateRotate(v.x, v.z, theta)
  result = set(v, r.a, v.y, r.b, v.w)

proc rotateYWNew*(v: Vector4, theta: float): Vector4 =
  let r = calculateRotate(v.x, v.y, theta)
  result = vector4(r.a, v.y, r.b, v.w)

proc rotateZWSelf*(v: var Vector4, theta: float): var Vector4 {.noinit.} =
  let r = calculateRotate(v.x, v.y, theta)
  result = set(v, r.a, r.b, v.z, v.w)

proc rotateZWNew*(v: Vector4, theta: float): Vector4 =
  let r = calculateRotate(v.x, v.y, theta)
  result = vector4(r.a, r.b, v.z, v.w)

proc rotate*(v: var Vector1, theta:float): var Vector1 {.noinit.} = rotateSelf(v, theta)
proc rotate*(v: var Vector2, theta:float): var Vector2 {.noinit.} = rotateSelf(v, theta)
# NOTE: Axis must be normalized
proc rotate*(v: var Vector3, axis: Vector3, theta: float): var Vector3 {.noinit.} =
  let
    s = sin(theta)
    c = cos(theta)
    oc = 1.0 - c
    t = (axis.x * v.x + axis.y * v.y + axis.z * v.z) * oc
  v = set(v, axis.x * t + v.x * c + (axis.y * v.z - axis.z * v.y) * s,
             axis.y * t + v.y * c + (axis.z * v.x - axis.x * v.z) * s,
             axis.z * t + v.z * c + (axis.x * v.y - axis.y * v.x) * s)
  result = v
# NOTE: The planes defined by (b1, b2) and (b3, b4) must be orthagonal
proc rotate*(v: var Vector4, b1, b2: Vector4, theta: float, b3, b4: Vector4, phi: float): var Vector4 {.noinit.} =
  var m = matrix44(b1, b2, b3, b4)
  v = transform(v, invert(m))
  v = rotateXYSelf(v, theta)
  v = rotateZWSelf(v, phi)
  v = transform(v, m)
  result = v

# Scale
proc scaleSelf*(v: var Vector1, s: float): var Vector1 {.noinit.} =
  v.x *= s
  result = v

proc scaleNew*(v: Vector1, s: float): Vector1 =
  result.x = v.x * s

proc scaleSelf*(v: var Vector2, s: float): var Vector2 {.noinit.} =
  v.x *= s
  v.y *= s
  result = v

proc scaleNew*(v: Vector2, s: float): Vector2 =
  result.x = v.x * s
  result.y = v.y * s

proc scaleSelf*(v: var Vector2, sx, sy: float): var Vector2 {.noinit.} =
  v.x *= sx
  v.y *= sy
  result = v

proc scaleNew*(v: Vector2, sx, sy: float): Vector2 =
  result.x = v.x * sx
  result.y = v.y * sy

proc scaleSelf*(v: var Vector3, s: float): var Vector3 {.noinit.} =
  v.x *= s
  v.y *= s
  v.z *= s
  result = v

proc scaleNew*(v: Vector3, s: float): Vector3 =
  result.x = v.x * s
  result.y = v.y * s
  result.z = v.z * s

proc scaleSelf*(v: var Vector3, sx, sy, sz: float): var Vector3 {.noinit.} =
  v.x *= sx
  v.y *= sy
  v.z *= sz
  result = v

proc scaleNew*(v: Vector3, sx, sy, sz: float): Vector3 =
  result.x = v.x * sx
  result.y = v.y * sy
  result.z = v.z * sz

proc scaleSelf*(v: var Vector4, s: float): var Vector4 {.noinit.} =
  v.x *= s
  v.y *= s
  v.z *= s
  v.w *= s
  result = v

proc scaleNew*(v: Vector4, s: float): Vector4 =
  result.x = v.x * s
  result.y = v.y * s
  result.z = v.z * s
  result.w = v.w * s

proc scaleSelf*(v: var Vector4, sx, sy, sz, sw: float): var Vector4 {.noinit.} =
  v.x *= sx
  v.y *= sy
  v.z *= sz
  v.w *= sw
  result = v

proc scaleNew*(v: Vector4, sx, sy, sz, sw: float): Vector4 =
  result.x = v.x * sx
  result.y = v.y * sy
  result.z = v.z * sz
  result.w = v.w * sw

proc scale*(v: var Vector1, s: float): var Vector1 = scaleSelf(v, s)
proc scale*(v: var Vector2, s: float): var Vector2 = scaleSelf(v, s)
proc scale*(v: var Vector3, s: float): var Vector3 = scaleSelf(v, s)
proc scale*(v: var Vector4, s: float): var Vector4 = scaleSelf(v, s)

proc scale*(v: var Vector2, sx, sy: float): var Vector2 = scaleSelf(v, sx, sy)
proc scale*(v: var Vector3, sx, sy, sz: float): var Vector3 = scaleSelf(v, sx, sy, sz)
proc scale*(v: var Vector4, sx, sy, sz, sw: float): var Vector4 = scaleSelf(v, sx, sy, sz, sw)

# Translate
proc translate*(v1: var Vector1, v2: Vector1): var Vector1 = addSelf(v1, v2)
proc translate*(v1: var Vector2, v2: Vector2): var Vector2 = addSelf(v1, v2)
proc translate*(v1: var Vector3, v2: Vector3): var Vector3 = addSelf(v1, v2)
proc translate*(v1: var Vector4, v2: Vector4): var Vector4 = addSelf(v1, v2)

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

proc toSeq*(v: Vector1): seq[float] =
  result = @[v.x]

proc toSeq*(v: Vector2): seq[float] =
  result = @[v.x, v.y]

proc toSeq*(v: Vector3): seq[float] =
  result = @[v.x, v.y, v.z]

proc toSeq*(v: Vector4): seq[float] =
  result = @[v.x, v.y, v.z, v.w]

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

proc toJsonString*(v: Vector1): string =
  result = &"{{x: {v.x}}}"

proc toJsonString*(v: Vector2): string =
  result = &"{{x: {v.x}, y: {v.y}}}"

proc toJsonString*(v: Vector3): string =
  result = &"{{x: {v.x}, y: {v.y}, z: {v.z}}}"

proc toJsonString*(v: Vector4): string =
  result = &"{{x: {v.x}, y: {v.y}, z: {v.z}, w: {v.w}}}"

# Batch comparisons
proc min*(a: openArray[Vector]): Vector =
  result = nil
  for v in a:
    if result == nil or v < result:
      result = v

proc max*(a: openArray[Vector]): Vector =
  result = nil
  for v in a:
    if result == nil or v > result:
      result = v

# Miscellaneous
# NOTE: This is added from the design doc
# NOTE: All plane operations should be refactored as some point

proc calculatePlane*(v1, v2, v3: Vector3): Vector4 =
  let cp = cross(subtractNew(v3, v1), subtractNew(v2, v1))
  result = vector4(cp, -1.0 * dot(cp, v3))

proc areCollinear*(v1, v2, v3: Vector3): bool =
  result = true
  let ms = magnitudeSquared(cross(subtractNew(v3, v1), subtractNew(v2, v1)))
  # if ms > ETA:
  if ms != 0:
    result = false

# NOTE: Write generaly areCollinear for array

# This is probably not the most efficient algorithm for coplanarity
# Finds the first plane, and then each points distance to that plane
proc arePlanar*(a: openArray[Vector3]): bool =
  result = true
  let l = len(a)
  if l > 3:
    var
      collinear = true
      p = vector4(0.0, 0.0, 0.0, 0.0)
    for i in 0..<(l - 2):
      if not areCollinear(a[0], a[1], a[2]):
        collinear = false
        p = calculatePlane(a[0], a[1], a[2])
        break
    if collinear:
      return true
    for i in 3..<l:
      let d = p.x * a[i].x + p.y * a[i].y + p.z * a[i].z + p.w
      # NOTE: Refactor if needed to use ETA because of floating point
      # if d > ETA:
      if d != 0.0:
        result = false
        break

# JSON
proc vector1FromJsonNode*(jsonNode: JsonNode): Vector1 =
  result = vector1(getFloat(jsonNode["x"]))

proc vector2FromJsonNode*(jsonNode: JsonNode): Vector2 =
  result = vector2(getFloat(jsonNode["x"]), getFloat(jsonNode["y"]))

proc vector3FromJsonNode*(jsonNode: JsonNode): Vector3 =
  result = vector3(getFloat(jsonNode["x"]), getFloat(jsonNode["y"]), getFloat(jsonNode["z"]))

proc vector4FromJsonNode*(jsonNode: JsonNode): Vector4 =
  result = vector4(getFloat(jsonNode["x"]), getFloat(jsonNode["y"]), getFloat(jsonNode["z"]), getFloat(jsonNode["w"]))

proc vector1FromJson*(jsonString: string): Vector1 =
  result = vector1FromJsonNode(parseJson(jsonString))

proc vector2FromJson*(jsonString: string): Vector2 =
  result = vector2FromJsonNode(parseJson(jsonString))

proc vector3FromJson*(jsonString: string): Vector3 =
  result = vector3FromJsonNode(parseJson(jsonString))

proc vector4FromJson*(jsonString: string): Vector4 =
  result = vector4FromJsonNode(parseJson(jsonString))

proc toJson*(v: Vector1): string =
  result = toJsonString(v)

proc toJson*(v: Vector2): string =
  result = toJsonString(v)

proc toJson*(v: Vector3): string =
  result = toJsonString(v)

proc toJson*(v: Vector4): string =
  result = toJsonString(v)