from ./concepts import
  Compare,
  Equals,
  Hash,
  Clear,
  Copy,
  String

from ./types import
  Quaternion,
  Matrix44,
  Vector

export
  Compare,
  Equals,
  Hash,
  Clear,
  Copy,
  String,
  Quaternion

# from ./matrix import
#   `[]`

from ./vector import
  normalizeNew

from strformat import `&`
from math import sin, cos, arctan2, arccos, sqrt

import hashes

# Constructor
proc quaternion*[T](x, y, z, w: float): Quaternion[T] =
  result[0] = x
  result[1] = y
  result[2] = z
  result[3] = w

proc quaternion*[T](w: float, v: Vector[3, T]): Quaternion[T] =
  result[0] = w
  result[1] = v.x
  result[2] = v.y
  result[3] = v.z

# Copy
proc copy*[T](q: Quaternion[T]): Quaternion[T] =
  deepCopy(result, q)

# Set
proc set*[T](q: var Quaternion[T], n: float): var Quaternion[T] {.noinit.} =
  for i in 0..<len(q):
    q[i] = n
  result = q

# Clear
proc clear*[T](q: var Quaternion[T]): var Quaternion[T] = set(q, 0.0)

# Inverse
proc inverseSelf*[T](q: var Quaternion[T]): var Quaternion[T] {.noinit.} =
  for i, val in pairs(q):
    q[i] = -val
  result = q

proc inverseNew*[T](q: Quaternion[T]): Quaternion[T] =
  var p = q.copy()
  result = inverseSelf(p)

proc inverse*[T](q: Quaternion[T]): Quaternion[T] = inverseNew(q)

# Invert
# NOTE: Added from design doc
proc invertSelf*[T](q: var Quaternion[T]): var Quaternion[T] {.noinit.} =
  for i, val in pairs(q):
    q[i] = 1 / val
  result = q

proc invertNew*[T](q: Quaternion[T]): Quaternion[T] =
  var p = q.copy()
  result = invertSelf(p)

proc invert*[T](q: Quaternion[T]): Quaternion[T] = invertNew(q)

# Equals
proc `==`*[T](q1, q2: Quaternion[T]): bool =
  result = true
  for i, val in pairs(q1):
    if val != q2[i]:
      return false

# Hash
proc hash*[T](q: Quaternion[T]): hashes.Hash =
  for val in q:
    result = !$(result !& hash(val))

# String
proc `$`*[T](q: Quaternion[T]): string =
  result = "["
  for i, e in q:
    if i > 0:
      result.add(", ")
    result.add($e)
  result.add("]")

# Magnitude
proc magnitude*[T](q: Quaternion[T]): float =
  result = sqrt(q[0] * q[0] + q[1] * q[1] + q[2] * q[2] + q[3] * q[3])

# Magnitude Squared
proc magnitudeSquared*[T](q: Quaternion[T]): float =
  result = q[0] * q[0] + q[1] * q[1] + q[2] * q[2] + q[3] * q[3]

# Length
proc length*[T](q: Quaternion[T]): float = magnitude(q)

# Addition
proc addSelf*[T](q: var Quaternion[T], f: float): var Quaternion[T] {.noinit.} =
  for i in 0..<len(q):
    q[i] += f
  result = q

proc addSelf*[T](q1: var Quaternion[T], q2: Quaternion[T]): var Quaternion[T] {.noinit.} =
  for i in 0..<len(q1):
    q1[i] += q2[i]
  result = q1

proc addNew*[T](q: Quaternion[T], f: float): Quaternion[T] =
  deepCopy(result, q)
  addSelf(result, f)

proc addNew*[T](q1, q2: Quaternion[T]): Quaternion[T] =
  deepCopy(result, q1)
  addSelf(result, q2)

proc `+`*[T](q1, q2: Quaternion[T]): Quaternion[T] = addNew(q1, q2)
proc `+`*[T](q: Quaternion[T], f: float): Quaternion[T] = addNew(q, f)
proc `+`*[T](f: float, q: Quaternion[T]): Quaternion[T] = addNew(q, f)
proc `+=`*[T](q1: var Quaternion[T], q2: Quaternion[T]): var Quaternion[T] = addSelf(q1, q2)
proc `+=`*[T](q: var Quaternion[T], f: float): var Quaternion[T] = addSelf(q, f)

# Subtraction
proc subtractSelf*[T](q: var Quaternion[T], f: float): var Quaternion[T] {.noinit.} =
  for i in 0..<len(q):
    q[i] -= f
  result = q

proc subtractSelf*[T](q1: var Quaternion[T], q2: Quaternion[T]): var Quaternion[T] {.noinit.} =
  for i in 0..<len(q1):
    q1[i] -= q2[i]
  result = q1

proc subtractNew*[T](q: Quaternion[T], f: float): Quaternion[T] =
  deepCopy(result, q)
  subtractSelf(result, f)

proc subtractNew*[T](q1, q2: Quaternion[T]): Quaternion[T] =
  deepCopy(result, q1)
  subtractSelf(result, q2)

proc `-`*[T](q1, q2: Quaternion): Quaternion[T] = subtractNew(q1, q2)
proc `-`*[T](q: Quaternion[T], f: float): Quaternion[T] = subtractNew(q, f)
proc `-`*[T](f: float, q: Quaternion[T]): Quaternion[T] = addNew(inverse(q), f)
proc `-=`*[T](q1: var Quaternion[T], q2: Quaternion[T]): var Quaternion[T] = subtractSelf(q1, q2)
proc `-=`*[T](q: var Quaternion[T], f: float): var Quaternion[T] = subtractSelf(q, f)

# Multiply
proc multiplySelf*[T](q: var Quaternion[T], f: float): var Quaternion[T] {.noinit.} =
  for i in 0..<len(q):
    q[i] *= f
  result = q

proc multiplySelf*[T](q1: var Quaternion[T], q2: Quaternion[T]): var Quaternion[T] {.noinit.} =
  for i in 0..<len(q1):
    q1[i] *= q2[i]
  result = q1

proc multiplyNew*[T](q: Quaternion[T], f: float): Quaternion[T] =
  deepCopy(result, q)
  multiplySelf(result, f)

proc multiplyNew*[T](q1, q2: Quaternion[T]): Quaternion[T] =
  deepCopy(result, q1)
  multiplySelf(result, q2)

proc `*`*[T](q: Quaternion[T], f: float): Quaternion[T] = multiplyNew(q, f)
proc `*`*[T](f: float, q: Quaternion[T]): Quaternion[T] = multiplyNew(q, f)
proc `*=`*[T](q: var Quaternion[T], f: float): var Quaternion[T] = multiplySelf(q, f)

# Divide
proc divideSelf*[T](q: var Quaternion[T], f: float): var Quaternion[T] {.noinit.} =
  for i in 0..<len(q):
    q[i] /= f
  result = q

proc divideSelf*[T](q1: var Quaternion[T], q2: Quaternion[T]): var Quaternion[T] {.noinit.} =
  for i in 0..<len(q1):
    q1[i] /= q2[i]
  result = q1
  
proc divideNew*[T](q: Quaternion[T], f: float): Quaternion[T] =
  deepCopy(result, q)
  divideSelf(result, f)

proc divideNew*[T](q1, q2: Quaternion[T]): Quaternion[T] =
  deepCopy(result, q1)
  divideSelf(result, q2)

proc `/`*[T](q1,q2: Quaternion[T]): Quaternion[T] = divideNew(q1, q2)
proc `/`*[T](q: Quaternion[T], f: float): Quaternion[T] = divideNew(q, f)
proc `/`*[T](f: float, q: Quaternion[T]): Quaternion[T] = multiplyNew(invert(q), f)
proc `/=`*[T](q1: var Quaternion[T], q2: Quaternion[T]): var Quaternion[T] = divideSelf(q1, q2)
proc `/=`*[T](q: var Quaternion[T], f: float): var Quaternion[T] = divideSelf(q, f)

# Normalize
proc normalizeSelf*[T](q: var Quaternion[T], m: float = 1.0): var Quaternion[T] {.noinit.} =
  let magnitude = magnitude(q)
  if (magnitude > 0):
    result = multiplySelf(q, m / magnitude)
  else:
    result = q

proc normalizeNew*[T](q: Quaternion[T], m: float = 1.0): Quaternion[T] =
  var p = q.copy()
  result = normalizeSelf(p)

proc normalize*[T](q: var Quaternion[T], m: float = 1.0): var Quaternion[T] = normalizeSelf(q, m)

# Dot
proc dot*[T](q1, q2: Quaternion[T]): float =
  # result = q1.x * q2.x + q1.y * q2.y + q1.z * q2.z + q1.w * q2.w
  for i, val in pairs(q1):
    result += val * q2[i]

# Conjugate
proc conjugateSelf[T](q: var Quaternion[T]): var Quaternion[T] {.noinit.} =
  ## Computes this quaternion's conjugate, defined as the same w around the
  ## inverted axis.
  # q[0] = -q[0]
  # q[1] = -q[1]
  # q[2] = -q[2]
  # q[3] = q[3]
  # result = q
  for i, val in pairs(q):
    if(i != high(q)):
      q[i] = -val
  result = q 

proc conjugateNew[T](q: Quaternion[T]): Quaternion[T] {.noinit.} =
  ## Computes a quaternion's conjugate, defined as the same w around the
  ## inverted axis, returns new quaternion
  var p = q.copy()
  result = conjugateSelf(p)

proc conjugate*[T](q: Quaternion[T]): Quaternion[T] = conjugateNew(q)
proc conjugate*[T](q: var Quaternion[T]): var Quaternion[T] = conjugateSelf(q)

# Module Level Procs (Constructors)
# FromMatrix44
proc fromMatrix*[T](m: Matrix44[T]): Quaternion[T] =
  ## Creates a quaternion from a rotation matrix. The algorithm used is from
  ## Allan and Mark Watt's "Advanced Animation and Rendering Techniques" (ACM
  ## Press 1992).
  var
    s = 0.0
    q: array[4, float]
    t = m[0, 0] + m[1, 1] + m[2, 2]
  if t > 0:
    s = 0.5 / sqrt(t + 1.0)
    q = [(m[2, 1] - m[1, 2]) * s,(m[0, 2] - m[2, 0]) * s,
      (m[1, 0] - m[0, 1]) * s, 0.25 / s]
  else:
    var
      n = [1, 2, 0]
      i, j, k = 0
    if m[1, 1] > m[0, 0]:
      i = 1
    if m[2, 2] > m[i, i]:
      i = 2
    j = n[i]
    k = n[j]
    s = 2 * sqrt((m[i, i] - m[j, j] - m[k, k]) + 1.0)
    let ss = 1.0 / s
    q[i] = s * 0.25
    q[j] = (m[j, i] + m[i, j]) * ss
    q[k] = (m[k, i] + m[i, k]) * ss
    q[3] = (m[k, j] + m[j, k]) * ss
  result[0] = q[0]
  result[1] = q[1]
  result[2] = q[2]
  result[3] = q[3]

# FromAxisAngle
proc fromAxisAngle*[T](v: Vector[3, T], a: float): Quaternion[T] =
  let
    s = sin(a * 0.5)
    c = cos(a * 0.5)
  result = quaternion(c, normalizeNew(v, s))