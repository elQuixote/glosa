from ./concepts import
  # Vector,
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
  Vector,
  Matrix,
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
  Vector,
  InvalidCrossProductError

# from ./matrix import
#   matrix44,
#   invert,
#   `[]`

import macros
from math import sin, cos, arctan2, arccos, sqrt
from random import rand
from strformat import `&`
import hashes
import json

template x*[N: static[int], T](v: Vector[N, T]): T = v[0]
template y*[N: static[int], T](v: Vector[N, T]): T = v[1]
template z*[N: static[int], T](v: Vector[N, T]): T = v[2]
template w*[N: static[int], T](v: Vector[N, T]): T = v[3]

# Constructors
# From parameters
proc vector1*[T](x: T): Vector[1, T] =
  result[0] = x

proc vector2*[T](x, y: T): Vector[2, T] =
  result[0] = x
  result[1] = y

proc vector3*[T](x, y, z: T): Vector[3, T] =
  result[0] = x
  result[1] = y
  result[2] = z

proc vector4*[T](x, y, z, w: T): Vector[4, T] =
  result[0] = x
  result[1] = y
  result[2] = z
  result[3] = w

# From single value
proc vector*[T](n: static[int], v: T): Vector[n, T] =
  for i in 0..<n:
    result[i] = v

# From array
proc vector*[N: static[int], T](a: array[N, T]): Vector[N, T] =
  for i, v in pairs(a):
    result[i] = v

# From sequence
proc vector*[N: static[int], T](s: seq[T]): Vector[N, T] =
  for i, v in pairs(s):
    result[i] = v

# From Polar/N-Spherical Coordinates
proc fromRadial*[T](r: T): Vector[1, T] =
  result = vector1(r)

proc fromPolar*[T](r, theta: T): Vector[2, T] =
  result = vector2(
    r * cos(theta),
    r * sin(theta)
  )

proc fromSpherical*[T](r, theta, phi: T): Vector[3, T] =
  result = vector3(
    r * sin(theta) * cos(phi),
    r * sin(theta) * sin(phi),
    r * cos(theta)
  )

proc from0Spherical*[T](r: T): Vector[1, T] = fromRadial(r)
proc from1Spherical*[T](r, theta: T): Vector[2, T] = fromPolar(r, theta)
proc from2Spherical*[T](r, theta, phi: T): Vector[3, T] = fromSpherical(r, theta, phi)
proc from3Spherical*[T](r, theta, phi, psi: T): Vector[4, T] =
  result = vector4(
    r * sin(theta) * sin(phi) * cos(psi),
    r * sin(theta) * sin(phi) * sin(psi),
    r * sin(theta) * cos(phi),
    r * cos(theta)
  )

# Set
proc set*[N: static[int], T](v: var Vector[N, T], n: T): var Vector[N, T] {.noinit.} =
  for i in 0..<len(v):
    v[i] = n
  result = v

proc set*[N: static[int], T](v: var Vector[N, T], x, y: T): var Vector[N, T] {.noinit.} =
  v[0] = x
  v[1] = y
  result = v

proc set*[N: static[int], T](v: var Vector[N, T], x, y, z: T): var Vector[N, T] {.noinit.} =
  v[0] = x
  v[1] = y
  v[2] = z
  result = v

proc set*[N: static[int], T](v: var Vector[N, T], x, y, z, w: T): var Vector[N, T] {.noinit.} =
  v[0] = x
  v[1] = y
  v[2] = z
  v[3] = w
  result = v

# Randomize
proc randomize*[N: static[int], T](v: var Vector[N, T], maxX: float = 1.0): var Vector[N, T] {.noinit.} =
  v[0] = rand(maxX)
  result = v

proc randomize*[N: static[int], T](v: var Vector[N, T], maxX, maxY: float = 1.0): var Vector[N, T] {.noinit.} =
  v[0] = rand(maxX)
  v[1] = rand(maxX)
  result = v

proc randomize*[N: static[int], T](v: var Vector[N, T], maxX, maxY, maxZ: float = 1.0): var Vector[N, T] {.noinit.} =
  v[0] = rand(maxX)
  v[1] = rand(maxY)
  v[2] = rand(maxZ)
  result = v

proc randomize*[N: static[int], T](v: var Vector[N, T], maxX, maxY, maxZ, maxW: float = 1.0): var Vector[N, T] {.noinit.} =
  v[0] = rand(maxX)
  v[1] = rand(maxY)
  v[2] = rand(maxZ)
  v[3] = rand(maxW)
  result = v

# Clear
proc clear*[N: static[int], T](v: var Vector[N, T]): var Vector[N, T] = set(v, 0.0)

# Inverse
proc inverseSelf*[N: static[int], T](v: var Vector[N, T]): var Vector[N, T] {.noinit.} =
  for i, val in pairs(v):
    v[i] = -val
  result = v

proc inverseNew*[N: static[int], T](v: Vector[N, T]): Vector[N, T] =
  deepCopy(result, v)
  inverseSelf(result)

proc inverse*[N: static[int], T](v: Vector[N, T]): Vector[N, T] = inverseNew(v)
proc reverse*[N: static[int], T](v: Vector[N, T]): Vector[N, T] = inverseNew(v)

# Invert
proc invertSelf*[N: static[int], T](v: var Vector[N, T]): var Vector[N, T] {.noinit.} =
  for i, val in pairs(v):
    v[i] = 1 / val
  result = v

proc invertNew*[N: static[int], T](v: Vector[N, T]): Vector[N, T] =
  deepCopy(result, v)
  invertSelf(result)

proc invert*[N: static[int], T](v: Vector[N, T]): Vector[N, T] = invertNew(v)

# Addition
proc addSelf*[N: static[int], T](v: var Vector[N, T], t: T): var Vector[N, T] {.noinit.} =
  for i in 0..<len(v):
    v[i] += t
  result = v

proc addSelf*[N: static[int], T](v1: var Vector[N, T], v2: Vector[N, T]): var Vector[N, T] {.noinit.} =
  for i in 0..<len(v1):
    v1[i] += v2[i]
  result = v1

proc addNew*[N: static[int], T](v: Vector[N, T], t: T): Vector[N, T] =
  deepCopy(result, v)
  addSelf(result, t)

proc addNew*[N: static[int], T](v1, v2: Vector[N, T]): Vector[N, T] =
  deepCopy(result, v1)
  addSelf(result, v2)

proc `+`*[N: static[int], T](v1, v2: Vector[N, T]): Vector[N, T] = addNew(v1, v2)
proc `+`*[N: static[int], T](v: Vector[N, T], t: T): Vector[N, T] = addNew(v, t)
proc `+`*[N: static[int], T](t: T, v: Vector[N, T]): Vector[N, T] = addNew(v, t)
proc `+=`*[N: static[int], T](v1: var Vector[N, T], v2: Vector[N, T]) = discard addSelf(v1, v2)
proc `+=`*[N: static[int], T](v1: var Vector[N, T], t: T) = discard addSelf(v1, t)

# Subtraction
proc subtractSelf*[N: static[int], T](v: var Vector[N, T], t: T): var Vector[N, T] {.noinit.} =
  for i in 0..<len(v):
    v[i] -= t
  result = v

proc subtractSelf*[N: static[int], T](v1: var Vector[N, T], v2: Vector[N, T]): var Vector[N, T] {.noinit.} =
  for i in 0..<len(v1):
    v1[i] -= v2[i]
  result = v1

proc subtractNew*[N: static[int], T](v: Vector[N, T], t: T): Vector[N, T] =
  deepCopy(result, v)
  subtractSelf(result, t)

proc subtractNew*[N: static[int], T](v1, v2: Vector[N, T]): Vector[N, T] =
  deepCopy(result, v1)
  subtractSelf(result, v2)

proc `-`*[N: static[int], T](v1, v2: Vector[N, T]): Vector[N, T] = subtractNew(v1, v2)
proc `-`*[N: static[int], T](v: Vector[N, T], t: T): Vector[N, T] = subtractNew(v, t)
proc `-`*[N: static[int], T](t: T, v: Vector[N, T]): Vector[N, T] = addNew(inverse(v), t)
proc `-=`*[N: static[int], T](v1: var Vector[N, T], v2: Vector[N, T]) = discard subtractSelf(v1, v2)
proc `-=`*[N: static[int], T](v1: var Vector[N, T], t: T) = discard subtractSelf(v1, t)

# Multiplication
proc multiplySelf*[N: static[int], T](v: var Vector[N, T], t: T): var Vector[N, T] {.noinit.} =
  for i in 0..<len(v):
    v[i] *= t
  result = v

proc multiplyNew*[N: static[int], T](v: Vector[N, T], t: T): Vector[N, T] =
  deepCopy(result, v)
  multiplySelf(result, t)

proc `*`*[N: static[int], T](v: Vector[N, T], t: T): Vector[N, T] = multiplyNew(v, t)
proc `*`*[N: static[int], T](t: float, v: Vector[N, T]): Vector[N, T] = multiplyNew(v, t)
proc `*=`*[N: static[int], T](v: var Vector[N, T], t: T) = discard multiplySelf(v, t)

# Divide
proc divideSelf*[N: static[int], T](v: var Vector[N, T], t: T): var Vector[N, T] {.noinit.} =
  for i in 0..<len(v):
    v[i] /= t
  result = v

proc divideNew*[N: static[int], T](v: Vector[N, T], t: T): Vector[N, T] =
  deepCopy(result, v)
  divideSelf(result, t)

proc `/`*[N: static[int], T](v: Vector[N, T], t: T): Vector[N, T] = divideNew(v, t)
proc `/`*[N: static[int], T](t: T, v: Vector[N, T]): Vector[N, T] = multiplyNew(invert(v), t)
proc `/=`*[N: static[int], T](v: var Vector[N, T], t: T) = discard divideSelf(v, t)

# Dot
proc dot*[N: static[int], T](v1, v2: Vector[N, T]): T =
  for i, val in pairs(v1):
    result += val * v2[i]

# Cross
proc cross*[T](v1, v2: Vector[1, T]): T =
  result = v1[0] * v2[0]

proc cross*[T](v1, v2: Vector[2, T]): T =
  result = v1[0] * v2[1] - v1[1] * v2[0]

proc cross*[T](v1, v2: Vector[3, T]): Vector[3, T] =
  result[0] = v1[1] * v2[2] - v1[2] * v2[1]
  result[1] = v1[2] * v2[0] - v1[0] * v2[2]
  result[2] = v1[0] * v2[1] - v1[1] * v2[0]

proc cross*[T](v1, v2: Vector[4, T]) =
  raise newException(InvalidCrossProductError,
    "Cannot calculate cross product of Vector4s")

# Heading
proc headingXY*[T](v: Vector[2, T]): T = arctan2(v[1], v[0])
proc headingXY*[T](v: Vector[3, T]): T = arctan2(v[1], v[0])
proc headingXZ*[T](v: Vector[3, T]): T = arctan2(v[2], v[0])
proc headingYZ*[T](v: Vector[3, T]): T = arctan2(v[2], v[1])
proc headingXY*[T](v: Vector[4, T]): T = arctan2(v[1], v[0])
proc headingXZ*[T](v: Vector[4, T]): T = arctan2(v[2], v[0])
proc headingXW*[T](v: Vector[4, T]): T = arctan2(v[3], v[0])
proc headingYZ*[T](v: Vector[4, T]): T = arctan2(v[2], v[1])
proc headingYW*[T](v: Vector[4, T]): T = arctan2(v[3], v[1])
proc headingZW*[T](v: Vector[4, T]): T = arctan2(v[3], v[2])

proc heading*[T](v: Vector[1, T]): T = 0.0
proc heading*[T](v: Vector[2, T]): T = headingXY(v)
proc heading*[T](v: Vector[3, T]): T = headingXY(v)
proc heading*[T](v: Vector[4, T]): T = headingXY(v)

# Magnitude
proc magnitudeSquared*[N: static[int], T](v: Vector[N, T]): T {.inline.} = dot(v, v)
proc magnitude*[N: static[int], T](v: Vector[N, T]): T = sqrt(magnitudeSquared(v))

# Length
proc length*[N: static[int], T](v: Vector[N, T]): T = magnitude(v)

# Distance To
proc distanceToSquared*[N: static[int], T](v1, v2: Vector[N, T]): T =
  var differences: Vector[N, T]
  deepCopy(differences, v1)
  for i, val in pairs(v1):
    differences[i] = val - v2[i]
  result = magnitudeSquared(differences)

proc distanceTo*[N: static[int], T](v1, v2: Vector[N, T]): T = length(subtractNew(v1, v2))

# Interpolate To
proc interpolateTo*[N: static[int], T](v1, v2: Vector[N, T], t: T): Vector[N, T] =
  for i, val in pairs(v1):
    result[i] = val + (v2[i] - val) * t

# Normalize
proc normalizeSelf*[N: static[int], T](v: var Vector[N, T], m: T = 1.0): var Vector[N, T] {.noinit.} =
  let magnitude = magnitude(v)
  if (magnitude > 0):
    result = multiplySelf(v, m / magnitude)
  else:
    result = v

proc normalizeNew*[N: static[int], T](v: Vector[N, T], m: T = 1.0): Vector[N, T] =
  deepCopy(result, v)
  normalizeSelf(result, m)

proc normalize*[N: static[int], T](v: var Vector[N,  T], m: T = 1.0): var Vector[N, T] = normalizeSelf(v, m)

# Reflect
# NOTE: Vectors must be normalized
proc reflectSelf*[N: static[int], T](v: var Vector[N, T], n: Vector[N, T]): var Vector[N, T] {.noinit.} =
  v = subtractSelf(v, multiplyNew(n, 2 * dot(v, n)))
  result = v

proc reflectNew*[N: static[int], T](v, n: Vector[N, T]): Vector[N, T] =
  deepCopy(result, v)
  reflectSelf(result, n)

proc reflect*[N: static[int], T](v, n: Vector[N, T]): Vector[N, T] = reflectNew(v, n)

# Refract
# NOTE: Vectors must be normalized
proc refractSelf*[N: static[int], T](v: var Vector[N, T], n: Vector[N, T], eta: T): var Vector[N, T] {.noinit.} =
  let
    d = dot(n, v)
    k = 1.0 - eta * eta * (1.0 - d * d)
  if (k < 0):
    result = set(v, 0.0)
  else:
    result = subtractSelf(multiplySelf(v, eta), multiplyNew(n, eta * d + sqrt(k)))

proc refractNew*[N: static[int], T](v, n: Vector[N, T], eta: T): Vector[N, T] =
  deepCopy(result, v)
  refractSelf(result, n, eta)

proc refract*[N: static[int], T](v, n: Vector[N, T], eta: T): Vector[N, T] = refractNew(v, n, eta)

# Angle Between
proc angleBetween*[N: static[int], T](v1, v2: Vector[N, T]): T =
  result = arccos(dot(v1, v2) / (magnitude(v1) * magnitude(v2)))

# Compare (compares magnitudes)
proc `>`*[N: static[int], T](v1, v2: Vector[N, T]): bool =
  result = magnitudeSquared(v1) > magnitudeSquared(v2)

proc `<`*[N: static[int], T](v1, v2: Vector[N, T]): bool =
  result = magnitudeSquared(v1) < magnitudeSquared(v2)

proc `>=`*[N: static[int], T](v1, v2: Vector[N, T]): bool =
  result = magnitudeSquared(v1) >= magnitudeSquared(v2)

proc `<=`*[N: static[int], T](v1, v2: Vector[N, T]): bool =
  result = magnitudeSquared(v1) <= magnitudeSquared(v2)

# Equals (compares coordinates)
proc `==`*[N: static[int], T](v1, v2: Vector[N, T]): bool =
  result = true
  for i, val in pairs(v1):
    if val != v2[i]:
      return false

# Non Equals
proc `!=`*[N: static[int], T](v1, v2: Vector[N, T]): bool =
  result = not (v1 == v2)

# Hash
proc hash*[N: static[int], T](v: Vector[N, T]): hashes.Hash =
  for val in v:
    result = !$(result !& hash(val))

# Dimension
proc dimension*[N: static[int], T](v: Vector[N, T]): int = N

# Transformations
# Transform
proc transformSelf*[N: static[int], T](v: var Vector[N, T], m: Matrix): var Vector[N, T] {.noinit.} =
  for i in 0..<len(v):
    v[i] = 0
    for j in 0..<len(m):
      v[i] = v[i] + m[i, j] * v[j]
  result = v

proc transformNew*[N: static[int], T](v: Vector[N, T], m: Matrix): Vector[N, T] =
  deepCopy(result, v)
  transformSelf(result, m)

proc transform*[N: static[int], T](v: var Vector[N, T], m: Matrix): var Vector[N, T] {.noinit.} = transformSelf(v, m)

# Rotate
# Private calculate new rotation coordinates
proc calculateRotate[T](a, b, theta: T): tuple[a, b: T] =
  let
    s = sin(theta)
    c = cos(theta)
  result = (a: a * c - b * s, b: b * c + a * s)

proc rotateSelf*[T](v: var Vector[1, T], theta: T): var Vector[1, T] {.noinit.} =
  result = v

proc rotateNew*[T](v: Vector[1, T], theta: T): Vector[1, T] =
  deepCopy(result, v)

proc rotateSelf*[T](v: var Vector[2, T], theta: T): var Vector[2, T] {.noinit.} =
  let r = calculateRotate(v[0], v[1], theta)
  result = set(v, r.a, r.b)

proc rotateNew*[T](v: Vector[2, T], theta: T): Vector[2, T] =
  let r = calculateRotate(v[0], v[1], theta)
  result = vector2(r.a, r.b)

proc rotateXSelf*[T](v: var Vector[3, T], theta: T): var Vector[3, T] {.noinit.} =
  let r = calculateRotate(v[1], v[2], theta)
  result = set(v, v.x, r.a, r.b)

proc rotateXNew*[T](v: Vector[3, T], theta: T): Vector[3, T] =
  let r = calculateRotate(v[1], v[2], theta)
  result = vector3(v.x, r.a, r.b)

proc rotateYSelf*[T](v: var Vector[3, T], theta: T): var Vector[3, T] {.noinit.} =
  let r = calculateRotate(v[0], v[2], theta)
  result = set(v, r.a, v.y, r.b)

proc rotateYNew*[T](v: Vector[3, T], theta: T): Vector[3, T] =
  let r = calculateRotate(v[0], v[1], theta)
  result = vector3(r.a, v.y, r.b)

proc rotateZSelf*[T](v: var Vector[3, T], theta: T): var Vector[3, T] {.noinit.} =
  let r = calculateRotate(v[0], v[1], theta)
  result = set(v, r.a, r.b, v.z)

proc rotateZNew*[T](v: Vector[3, T], theta: T): Vector[3, T] =
  let r = calculateRotate(v[0], v[1], theta)
  result = vector3(r.a, r.b, v.z)

proc rotateXYSelf*[T](v: var Vector[4, T], theta: T): var Vector[4, T] {.noinit.} =
  let r = calculateRotate(v[2], v[3], theta)
  result = set(v, v.x, v.y, r.a, r.b)

proc rotateXYNew*[T](v: Vector[4, T], theta: T): Vector[4, T] =
  let r = calculateRotate(v[2], v[3], theta)
  result = vector4(v.x, v.y, r.a, r.b)

proc rotateXZSelf*[T](v: var Vector[4, T], theta: T): var Vector[4, T] {.noinit.} =
  let r = calculateRotate(v[1], v[3], theta)
  result = set(v, v.x, r.a, v.z, r.b)

proc rotateXZNew*[T](v: Vector[4, T], theta: T): Vector[4, T] =
  let r = calculateRotate(v[1], v[3], theta)
  result = vector4(v.x, r.a, v.z, r.b)

proc rotateXWSelf*[T](v: var Vector[4, T], theta: T): var Vector[4, T] {.noinit.} =
  let r = calculateRotate(v[1], v[2], theta)
  result = set(v, v.x, r.a, r.b, v.w)

proc rotateXWNew*[T](v: Vector[4, T], theta: T): Vector[4, T] =
  let r = calculateRotate(v[1], v[2], theta)
  result = vector4(v.x, r.a, r.b, v.w)

proc rotateYZSelf*[T](v: var Vector[4, T], theta: T): var Vector[4, T] {.noinit.} =
  let r = calculateRotate(v[0], v[3], theta)
  result = set(v, r.a, v.y, v.z, r.b)

proc rotateYZNew*[T](v: Vector[4, T], theta: T): Vector[4, T] =
  let r = calculateRotate(v[0], v[3], theta)
  result = vector4(r.a, v.y, v.z, r.b)

proc rotateYWSelf*[T](v: var Vector[4, T], theta: T): var Vector[4, T] {.noinit.} =
  let r = calculateRotate(v[0], v[2], theta)
  result = set(v, r.a, v.y, r.b, v.w)

proc rotateYWNew*[T](v: Vector[4, T], theta: T): Vector[4, T] =
  let r = calculateRotate(v[0], v[1], theta)
  result = vector4(r.a, v.y, r.b, v.w)

proc rotateZWSelf*[T](v: var Vector[4, T], theta: T): var Vector[4, T] {.noinit.} =
  let r = calculateRotate(v[0], v[1], theta)
  result = set(v, r.a, r.b, v.z, v.w)

proc rotateZWNew*[T](v: Vector[4, T], theta: T): Vector[4, T] =
  let r = calculateRotate(v[0], v[1], theta)
  result = vector4(r.a, r.b, v.z, v.w)

proc rotate*[T](v: var Vector[1, T], theta: T): var Vector[1, T] {.noinit.} = rotateSelf(v, theta)
proc rotate*[T](v: var Vector[2, T], theta: T): var Vector[2, T] {.noinit.} = rotateSelf(v, theta)
# NOTE: Axis must be normalized
proc rotate*[T](v: var Vector[3, T], axis: Vector[3, T], theta: T): var Vector[3, T] {.noinit.} =
  let
    s = sin(theta)
    c = cos(theta)
    oc = 1.0 - c
    t = (axis.x * v.x + axis.y * v.y + axis.z * v.z) * oc
  v = set(v, axis.x * t + v.x * c + (axis.y * v.z - axis.z * v.y) * s,
             axis.y * t + v.y * c + (axis.z * v.x - axis.x * v.z) * s,
             axis.z * t + v.z * c + (axis.x * v.y - axis.y * v.x) * s)
  result = v
# # NOTE: The planes defined by (b1, b2) and (b3, b4) must be orthagonal
# proc rotate*[T](v: var Vector[4, T], b1, b2: Vector[4, T], theta: T, b3, b4: Vector[4, T], phi: T): var Vector[4, T] {.noinit.} =
#   var m = matrix44(b1, b2, b3, b4)
#   v = transform(v, invert(m))
#   v = rotateXYSelf(v, theta)
#   v = rotateZWSelf(v, phi)
#   v = transform(v, m)
#   result = v

# Scale
proc scaleSelf*[N: static[int], T](v: var Vector[N, T], s: T): var Vector[N, T] {.noinit.} =
  for i in 0..<len(v):
    v[i] *= s
  result = v

proc scaleSelf*[N: static[int], T](v: var Vector[N, T], a: openArray[T]): var Vector[N, T] {.noinit.} =
  for i in 0..<len(v):
    v[i] *= a[i]
  result = v

proc scaleNew*[N: static[int], T](v: Vector[N, T], s: T): Vector[N, T] =
  deepCopy(result, v)
  scaleSelf(result, s)

proc scaleNew*[N: static[int], T](v: Vector[N, T], a: openArray[T]): Vector[N, T] =
  deepCopy(result, v)
  scaleSelf(result, a)

proc scale*[N: static[int], T](v: var Vector[N, T], s: T): var Vector[N, T] = scaleSelf(v, s)
proc scale*[N: static[int], T](v: var Vector[N, T], a: openArray[T]): var Vector[N, T] = scaleSelf(v, a)

# Translate
proc translate*[N: static[int], T](v1: var Vector[N, T], v2: Vector[N, T]): var Vector[N, T] = addSelf(v1, v2)

# String
proc `$`[N: static[int], T](v: Vector[N, T]): string =
  result = "["
  for i, e in v:
    if i > 0:
      result.add(", ")
    result.add($e)
  result.add("]")

# Iterators
# NOTE: Added from design doc
# NOTE: Using Nim paradigm (items, fields, pairs, etc)
# iterator elements*[N: static[int], T](v: Vector[N, T]): T =
#   for item in v:
#     yield item

# NOTE: Added from design doc
# NOTE: Using Nim paradigm (items, fields, pairs, etc)
# iterator pairs*[N: static[int], T](v: Vector[N, T]): tuple[key: int, value: T] =
#   for p in pairs(v):
#     yield p

# Converters
# NOTE: Added from design doc
proc toArray*[N: static[int], T](v: Vector[N, T]): array[N, T] = array(v)

proc toSeq*[N: static[int], T](v: Vector[N, T]): seq[T] = @[v]

# From seq (for nurbs)
proc fillFromSeq*[N: static[int], T](v: var Vector[N, T], s: seq[T]): void  =
  for i, val in pairs(s):
    v[i] = val

# Extend
# NOTE: Added from design doc
proc extend*[N: static[int], T](v: Vector[N, T], y: T): Vector[N + 1, T] =
  for i, val in pairs(v):
    result[i] = val
  result[N + 1] = y

# Shorten
# NOTE: Added from design doc
proc shorten*[N: static[int], T](v: Vector[N, T]): Vector[N - 1, T] =
  for i in 0..<(N - 1):
    result[i] = v[i]

proc toJsonString*[T](v: Vector[1, T]): string =
  result = &"{{\"x\":{v[0]}}}"

proc toJsonString*[T](v: Vector[2, T]): string =
  result = &"{{\"x\":{v[0]},\"y\":{v[1]}}}"

proc toJsonString*[T](v: Vector[3, T]): string =
  result = &"{{\"x\":{v[0]},\"y\":{v[1]},\"z\":{v[2]}}}"

proc toJsonString*[T](v: Vector[4, T]): string =
  result = &"{{\"x\":{v[0]},\"y\":{v[1]},\"z\":{v[2]},\"w\":{v[3]}}}"

# Batch comparisons
proc min*[N: static[int], T](a: openArray[Vector[N, T]]): Vector[N, T] =
  result = nil
  for v in a:
    if result == nil or v < result:
      result = v

proc max*[N: static[int], T](a: openArray[Vector[N, T]]): Vector[N, T] =
  result = nil
  for v in a:
    if result == nil or v > result:
      result = v

# Miscellaneous
# NOTE: This is added from the design doc
# NOTE: All plane operations should be refactored as some point

proc calculatePlane*[T](v1, v2, v3: Vector[3, T]): Vector[4, T] =
  let cp = cross(subtractNew(v3, v1), subtractNew(v2, v1))
  result = vector4(cp[0], cp[1], cp[2], -1.0 * dot(cp, v3))

proc areCollinear*[T](v1, v2, v3: Vector[3, T]): bool =
  result = true
  let ms = magnitudeSquared(cross(subtractNew(v3, v1), subtractNew(v2, v1)))
  # if ms > EPSILON:
  if ms != 0:
    result = false

# NOTE: Write generaly areCollinear for array

proc arePlanar*[T](a: openArray[Vector[1, T]]): bool =
  result = true

proc arePlanar*[T](a: openArray[Vector[2, T]]): bool =
  result = true

# This is probably not the most efficient algorithm for coplanarity
# Finds the first plane, and then each points distance to that plane
proc arePlanar*[T](a: openArray[Vector[3, T]]): bool =
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
      # NOTE: Refactor if needed to use EPSILON because of floating point
      # if d > EPSILON:
      if d != 0.0:
        result = false
        break

# TODO: Write 4D arePlanar (and areCollinear) algorithms
proc arePlanar*[T](a: openArray[Vector[4, T]]): bool =
  discard

# JSON
proc vector1FromJsonNode*[T](jsonNode: JsonNode): Vector[1, T] =
  result = vector1(getFloat(jsonNode["x"]))

proc vector2FromJsonNode*[T](jsonNode: JsonNode): Vector[2, T] =
  result = vector2(getFloat(jsonNode["x"]), getFloat(jsonNode["y"]))

proc vector3FromJsonNode*[T](jsonNode: JsonNode): Vector[3, T] =
  result = vector3(getFloat(jsonNode["x"]), getFloat(jsonNode["y"]), getFloat(jsonNode["z"]))

proc vector4FromJsonNode*[T](jsonNode: JsonNode): Vector[4, T] =
  result = vector4(getFloat(jsonNode["x"]), getFloat(jsonNode["y"]), getFloat(jsonNode["z"]), getFloat(jsonNode["w"]))

proc vector1FromJson*[T](jsonString: string): Vector[1, T] =
  result = vector1FromJsonNode(parseJson(jsonString))

proc vector2FromJson*[T](jsonString: string): Vector[2, T] =
  result = vector2FromJsonNode(parseJson(jsonString))

proc vector3FromJson*[T](jsonString: string): Vector[3, T] =
  result = vector3FromJsonNode(parseJson(jsonString))

proc vector4FromJson*[T](jsonString: string): Vector[4, T] =
  result = vector4FromJsonNode(parseJson(jsonString))

proc toJson*[T](v: Vector[1, T]): string =
  result = toJsonString(v)

proc toJson*[T](v: Vector[2, T]): string =
  result = toJsonString(v)

proc toJson*[T](v: Vector[3, T]): string =
  result = toJsonString(v)

proc toJson*[T](v: Vector[4, T]): string =
  result = toJsonString(v)