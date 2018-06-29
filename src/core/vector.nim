{.experimental: "dotOperators".}

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

template x*[N: static[int], T](v: Vector[N, T]): T = v[0]
template y*[N: static[int], T](v: Vector[N, T]): T = v[1]
template z*[N: static[int], T](v: Vector[N, T]): T = v[2]
template w*[N: static[int], T](v: Vector[N, T]): T = v[3]

macro `.`[N: static[int], T](v: Vector[N, T], field: string): expr =
  result = newNimNode nnkBracket
  for c in field.strVal:
    result.add newDotExpr(v, newIdentNode($c))

proc `$`[N: static[int], T](v: Vector[N, T]): string =
  result = "["
  for i, e in v:
    if i > 0: result.add ", "
    result.add($e)
  result.add "]"

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
proc vector*[T](n: int, v: T): Vector[n, T] =
  for i in n:
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

# Copy
proc copy*[N: static[int], T](v: Vector): Vector[N, T] =
  for i, val in pairs(v):
    result[i] = var val

# Set
proc set*[N: static[int], T](v: var Vector[N, T], x: T): var Vector[N, T] {.noinit.} =
  v[0] = x
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

proc set*[N: static[int], T](v: var Vector[N, T], n: T): var Vector[N, T] {.noinit.} =
  for i in 0..<len(v):
    v[i] = n
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

# Clear Copy (create Vector of the same length with empty values)
proc clearCopy*[N: static[int], T](v: Vector[N, T]): Vector[N, T] = vector(0.0)

# Inverse
proc inverseSelf*[N: static[int], T](v: var Vector[N, T]): var Vector[N, T] {.noinit.} =
  for i, val in pairs(v):
    v[i] = -val
  result = v

proc inverseNew*[N: static[int], T](v: Vector[N, T]): Vector[N, T] = inverseSelf(copy(v))
proc inverse*[N: static[int], T](v: Vector[N, T]): Vector[N, T] = inverseNew(v)
proc reverse*[N: static[int], T](v: Vector[N, T]): Vector[N, T] = inverseNew(v)

# Invert
proc invertSelf*[N: static[int], T](v: var Vector[N, T]): var Vector[N, T] {.noinit.} =
  for i, val in pairs(v):
    v[i] = 1 / val
  result = v

proc invertNew*[N: static[int], T](v: Vector[N, T]): Vector[N, T] = invertSelf(copy(v))
proc invert*[N: static[int], T](v: Vector[N, T]): Vector[N, T] = invertNew(v)

# Addition
proc addSelf*[N: static[int], T](v: var Vector[N, T], t: T): var Vector[N, T] {.noinit.} =
  for i, val in pairs(v):
    v[i] += t
  result = v

proc addSelf*[N: static[int], T](v1: var Vector[N, T], v2: Vector[N, T]): var Vector[N, T] {.noinit.} =
  for i, val in pairs(v1):
    v1[i] += v2[i]
  result = v1

proc addNew*[N: static[int], T](v: Vector[N, T], t: T): Vector[N, T] = addSelf(copy(v), t)
proc addNew*[N: static[int], T](v1, v2: Vector[N, T]): Vector[N, T] = addSelf(copy(v1), v2)

proc `+`*[N: static[int], T](v1, v2: Vector[N, T]): Vector[N, T] = addNew(v1, v2)
proc `+`*[N: static[int], T](v: Vector[N, T], t: T): Vector[N, T] = addNew(v, t)
proc `+`*[N: static[int], T](t: T, v: Vector[N, T]): Vector[N, T] = addNew(v, t)
proc `+=`*[N: static[int], T](v1: var Vector[N, T], v2: Vector[N, T]) = discard addSelf(v1, v2)
proc `+=`*[N: static[int], T](v1: var Vector[N, T], t: T) = discard addSelf(v1, t)

# Subtraction
proc subtractSelf*[N: static[int], T](v: var Vector[N, T], t: T): var Vector[N, T] {.noinit.} =
  for i, val in pairs(v):
    v[i] -= t
  result = v

proc subtractSelf*[N: static[int], T](v1: var Vector[N, T], v2: Vector[N, T]): var Vector[N, T] {.noinit.} =
  for i, val in pairs(v1):
    v1[i] += v2[i]
  result = v1

proc subtractNew*[N: static[int], T](v: Vector[N, T], t: T): Vector[N, T] = subtractSelf(copy(v), t)
proc subtractNew*[N: static[int], T](v1, v2: Vector[N, T]): Vector[N, T] = subtractSelf(copy(v1), v2)

proc `-`*[N: static[int], T](v1, v2: Vector[N, T]): Vector[N, T] = subtractNew(v1, v2)
proc `-`*[N: static[int], T](v: Vector[N, T], t: T): Vector[N, T] = subtractNew(v, t)
proc `-`*[N: static[int], T](t: T, v: Vector[N, T]): Vector[N, T] = addNew(inverse(v), t)
proc `-=`*[N: static[int], T](v1: var Vector[N, T], v2: Vector[N, T]) = discard subtractSelf(v1, v2)
proc `-=`*[N: static[int], T](v1: var Vector[N, T], t: T) = discard subtractSelf(v1, t)

# Multiplication
proc multiplySelf*[N: static[int], T](v: var Vector[N, T], t: T): var Vector[N, T] {.noinit.} =
  for i, val in pairs(v):
    v[i] *= t
  result = v

proc multiplyNew*[N: static[int], T](v: Vector[N, T], t: T): Vector[N, T] = multiplySelf(copy(v), t)

proc `*`*[N: static[int], T](v: Vector[N, T], t: T): Vector[N, T] = multiplyNew(v, t)
proc `*`*[N: static[int], T](t: float, v: Vector[N, T]): Vector[N, T] = multiplyNew(v, t)
proc `*=`*[N: static[int], T](v: var Vector[N, T], t: T) = discard multiplySelf(v, t)

# Divide
proc divideSelf*[N: static[int], T](v: var Vector[N, T], t: T): var Vector[N, T] {.noinit.} =
  for i, val in pairs(v):
    v[i] /= t
  result = v

proc divideNew*[N: static[int], T](v: Vector[N, T], t: T): Vector[N, T] = divideSelf(copy(v), t)

proc `/`*[N: static[int], T](v: Vector[N, T], t: T): Vector[N, T] = divideNew(v, t)
proc `/`*[N: static[int], T](t: T, v: Vector[N, T]): Vector[N, T] = multiplyNew(invert(v), t)
proc `/=`*[N: static[int], T](v: var Vector[N, T], t: T) = discard divideSelf(v, t)

# Dot
proc dot*[N: static[int], T](v1, v2: Vector[N, T]): T =
  for i, val in pairs(v1):
    result += v1[i] * v2[i]

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
proc headingXY*[T](v: Vector[2, T]): T =
  result = arctan2(v[1], v[0])

proc headingXY*[T](v: Vector[3, T]): T =
  result = arctan2(v[1], v[0])

proc headingXZ*[T](v: Vector[3, T]): T =
  result = arctan2(v[2], v[0])

proc headingYZ*[T](v: Vector[3, T]): T =
  result = arctan2(v[2], v[1])

proc headingXY*[T](v: Vector[4, T]): T =
  result = arctan2(v[1], v[0])

proc headingXZ*[T](v: Vector[4, T]): T =
  result = arctan2(v[2], v[0])

proc headingXW*[T](v: Vector[4, T]): T =
  result = arctan2(v[3], v[0])

proc headingYZ*[T](v: Vector[4, T]): T =
  result = arctan2(v[2], v[1])

proc headingYW*[T](v: Vector[4, T]): T =
  result = arctan2(v[3], v[1])

proc headingZW*[T](v: Vector[4, T]): T =
  result = arctan2(v[3], v[2])

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
  var differences = copy(v1)
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

proc normalizeNew*[N: static[int], T](v: Vector[N, T], m: T = 1.0): Vector[N, T] = normalizeSelf(copy(v), m)

proc normalize*[N: static[int], T](v: var Vector[N,  T], m: T = 1.0): var Vector[N, T] = normalizeSelf(v, m)

# Reflect
# NOTE: Vectors must be normalized
proc reflectSelf*[N: static[int], T](v: var Vector[N, T], n: Vector[N, T]): var Vector[N, T] {.noinit.} =
  v = subtractSelf(v, multiplyNew(n, 2 * dot(v, n)))
  result = v

proc reflectNew*[N: static[int], T](v, n: Vector[N, T]): Vector[N, T] = reflectSelf(copy(v), n)

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

proc refractNew*[N: static[int], T](v, n: Vector[N, T], eta: T): Vector[N, T] = refractSelf(copy(v), n, eta)

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

proc calculateFill[Vector](v: var Vector, s: seq[float]): void =
  for i, val in pairs(s):
    v[i] = val

# From seq (for nurbs)
proc fillFromSeq*(v: var Vector1, s: seq[float]): void  =
  calculateFill(v, s)

proc fillFromSeq*(v: var Vector2, s: seq[float]): void =
  calculateFill(v, s)

proc fillFromSeq*(v: var Vector3, s: seq[float]): void =
  calculateFill(v, s)

proc fillFromSeq*(v: var Vector4, s: seq[float]): void =
  calculateFill(v, s)

# Extend
# NOTE: Added from design doc
proc extend*(v: Vector1, y: float): Vector2 =
  result = vector2(v, y)

proc extend*(v: Vector2, z: float): Vector3 =
  result = vector3(v, z)

proc extend*(v: Vector3, w: float): Vector4 =
  result = vector4(v, w)

# Shorten
# NOTE: Added from design doc
proc shorten*(v: Vector2): Vector1 =
  result = vector1(v)

proc shorten*(v: Vector3): Vector2 =
  result = vector2(v)

proc shorten*(v: Vector4): Vector3 =
  result = vector3(v)

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
  result = &"{{\"x\":{v.x}}}"

proc toJsonString*(v: Vector2): string =
  result = &"{{\"x\":{v.x},\"y\":{v.y}}}"

proc toJsonString*(v: Vector3): string =
  result = &"{{\"x\":{v.x},\"y\":{v.y},\"z\":{v.z}}}"

proc toJsonString*(v: Vector4): string =
  result = &"{{\"x\":{v.x},\"y\":{v.y},\"z\":{v.z},\"w\":{v.w}}}"

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
  # if ms > EPSILON:
  if ms != 0:
    result = false

# NOTE: Write generaly areCollinear for array

proc arePlanar*(a: openArray[Vector1]): bool =
  result = true

proc arePlanar*(a: openArray[Vector2]): bool =
  result = true

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
      # NOTE: Refactor if needed to use EPSILON because of floating point
      # if d > EPSILON:
      if d != 0.0:
        result = false
        break

# TODO: Write 4D arePlanar (and areCollinear) algorithms
proc arePlanar*(a: openArray[Vector4]): bool =
  discard

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