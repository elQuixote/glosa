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
  Vector3

export
  Compare,
  Equals,
  Hash,
  Clear,
  Copy,
  String,
  Quaternion

from ./matrix import
  `[]`

from ./vector import
  normalizeNew

from strformat import `&`
from math import sin, cos, arctan2, arccos, sqrt

import hashes

# Constructor
proc quaternion*(x, y, z, w: float): Quaternion =
  result.x = x
  result.y = y
  result.z = z
  result.w = w

proc quaternion(w: float, v: Vector3): Quaternion =
  result.w = w
  result.x = v.x
  result.y = v.y
  result.z = v.z

# Copy
proc copy*(q: Quaternion): Quaternion =
  result = Quaternion(x: q.x, y: q.y, z: q.z, w: q.w)

# Set
proc set*(q: var Quaternion, n: float): var Quaternion {.noinit.} =
  result.x = n
  result.y = n
  result.z = n
  result.w = n

# Clear
proc clear*(q: var Quaternion): var Quaternion = set(q, 0.0)

# Inverse
proc inverseSelf*(q: var Quaternion): var Quaternion {.noinit.} =
  q.x = -q.x
  q.y = -q.y
  q.z = -q.z
  q.w = -q.w
  result = q

proc inverseNew*(q: Quaternion): Quaternion =
  var p = q.copy()
  result = inverseSelf(p)

proc inverse*(q: Quaternion): Quaternion = inverseNew(q)

# Invert
# NOTE: Added from design doc
proc invertSelf*(q: var Quaternion): var Quaternion {.noinit.} =
  q.x = 1 / q.x
  q.y = 1 / q.y
  q.z = 1 / q.z
  q.w = 1 / q.w
  result = q

proc invertNew*(q: Quaternion): Quaternion =
  var p = q.copy()
  result = invertSelf(p)

proc invert*(q: Quaternion): Quaternion = invertNew(q)

# Equals
proc `==`*(q1, q2: Quaternion): bool =
  result = q1.x == q2.x and q1.y == q2.y and q1.z == q2.z and q1.w == q2.w

# Hash
proc hash*(q: Quaternion): hashes.Hash =
  result = !$(result !& hash(q.x) !& hash(q.y) !& hash(q.z) !& hash(q.w))

# String
proc `$`*(q: Quaternion): string =
  result = &"[{q.x}, {q.y}, {q.z}, {q.w}]"

# Magnitude
proc magnitude*(q: Quaternion): float =
  result = sqrt(q.x * q.x + q.y * q.y + q.z * q.z + q.w * q.w)

# Length
proc length*(q: Quaternion): float = magnitude(q)

# Addition
proc addNew*(q: Quaternion, f: float): Quaternion =
  result.x = q.x + f
  result.y = q.y + f
  result.z = q.z + f
  result.w = q.w + f

proc addNew*(q1, q2: Quaternion): Quaternion =
  result.x = q1.x + q2.x
  result.y = q1.y + q2.y
  result.z = q1.z + q2.z
  result.w = q1.w + q2.w

proc addSelf*(q: var Quaternion, f: float): var Quaternion {.noinit.} =
  q.x += f
  q.y += f
  q.z += f
  q.w += f
  result = q

proc addSelf*(q1: var Quaternion, q2: Quaternion): var Quaternion {.noinit.} =
  q1.x += q2.x
  q1.y += q2.y
  q1.z += q2.z
  q1.w += q2.w
  result = q1

proc `+`*(q1, q2: Quaternion): Quaternion = addNew(q1, q2)
proc `+`*(q: Quaternion, f: float): Quaternion = addNew(q, f)
proc `+`*(f: float, q: Quaternion): Quaternion = addNew(q, f)
proc `+=`*(q1: var Quaternion, q2: Quaternion): var Quaternion = addSelf(q1, q2)
proc `+=`*(q: var Quaternion, f: float): var Quaternion = addSelf(q, f)

# Subtraction
proc subtractNew*(q: Quaternion, f: float): Quaternion =
  result.x = q.x - f
  result.y = q.y - f
  result.z = q.z - f
  result.w = q.w - f

proc subtractNew*(q1, q2: Quaternion): Quaternion =
  result.x = q1.x - q2.x
  result.y = q1.y - q2.y
  result.z = q1.z - q2.z
  result.w = q1.w - q2.w

proc subtractSelf*(q: var Quaternion, f: float): var Quaternion {.noinit.} =
  q.x -= f
  q.y -= f
  q.z -= f
  q.w -= f
  result = q

proc subtractSelf*(q1: var Quaternion, q2: Quaternion): var Quaternion {.noinit.} =
  q1.x -= q2.x
  q1.y -= q2.y
  q1.z -= q2.z
  q1.w -= q2.w
  result = q1

proc `-`*(q1, q2: Quaternion): Quaternion = subtractNew(q1, q2)
proc `-`*(q: Quaternion, f: float): Quaternion = subtractNew(q, f)
proc `-`*(f: float, q: Quaternion): Quaternion = addNew(inverse(q), f)
proc `-=`*(q1: var Quaternion, q2: Quaternion): var Quaternion = subtractSelf(q1, q2)
proc `-=`*(q: var Quaternion, f: float): var Quaternion = subtractSelf(q, f)

# Multiply
proc multiplyNew*(q: Quaternion, f: float): Quaternion =
  result.x = q.x * f
  result.y = q.y * f
  result.z = q.y * f
  result.w = q.w * f

proc multiplyNew*(q1, q2: Quaternion): Quaternion =
  result.x = q1.x * q2.x
  result.y = q1.y * q2.y
  result.z = q1.z * q2.z
  result.w = q1.w * q2.w

proc multiplySelf*(q: var Quaternion, f: float): var Quaternion {.noinit.} =
  q.x *= f
  q.y *= f
  q.z *= f
  q.w *= f
  result = q

proc multiplySelf*(q1: var Quaternion, q2: Quaternion): var Quaternion {.noinit.} =
  q1.x *= q2.x
  q1.y *= q2.y
  q1.z *= q2.z
  q1.w *= q2.w
  result = q1

proc `*`*(q: Quaternion, f: float): Quaternion = multiplyNew(q, f)
proc `*`*(f: float, q: Quaternion): Quaternion = multiplyNew(q, f)
proc `*=`*(q: var Quaternion, f: float): var Quaternion = multiplySelf(q, f)

# Divide
proc divideNew*(q: Quaternion, f: float): Quaternion =
  result.x = q.x / f
  result.y = q.y / f
  result.z = q.z / f
  result.w = q.w / f

proc divideNew*(q1, q2: Quaternion): Quaternion =
  result.x = q1.x / q2.x
  result.y = q1.y / q2.y
  result.z = q1.z / q2.z
  result.w = q1.w / q2.w

proc divideSelf*(q: var Quaternion, f: float): var Quaternion {.noinit.} =
  q.x /= f
  q.y /= f
  q.z /= f
  q.w /= f
  result = q

proc divideSelf*(q1: var Quaternion, q2: Quaternion): var Quaternion {.noinit.} =
  q1.x /= q2.x
  q1.y /= q2.y
  q1.z /= q2.z
  q1.w /= q2.w
  result = q1

proc `/`*(q1,q2: Quaternion): Quaternion = divideNew(q1, q2)
proc `/`*(q: Quaternion, f: float): Quaternion = divideNew(q, f)
proc `/`*(f: float, q: Quaternion): Quaternion = multiplyNew(invert(q), f)
proc `/=`*(q1: var Quaternion, q2: Quaternion): var Quaternion = divideSelf(q1, q2)
proc `/=`*(q: var Quaternion, f: float): var Quaternion = divideSelf(q, f)

# Normalize
proc normalizeSelf*(q: var Quaternion, m: float = 1.0): var Quaternion {.noinit.} =
  let magnitude = magnitude(q)
  if (magnitude > 0):
    result = multiplySelf(q, m / magnitude)
  else:
    result = q

proc normalizeNew*(q: Quaternion, m: float = 1.0): Quaternion =
  var p = q.copy()
  result = normalizeSelf(p)

proc normalize*(q: var Quaternion, m: float = 1.0): var Quaternion = normalizeSelf(q, m)

# Dot
proc dot*(q1, q2: Quaternion): float =
  result = q1.x * q2.x + q1.y * q2.y + q1.z * q2.z + q1.w * q2.w

# Conjugate
proc conjugateSelf(q: var Quaternion): var Quaternion {.noinit.} =
  ## Computes this quaternion's conjugate, defined as the same w around the
  ## inverted axis.
  q.x = -q.x
  q.y = -q.y
  q.z = -q.z
  q.w = q.w
  result = q

proc conjugateNew(q: Quaternion): Quaternion {.noinit.} =
  ## Computes a quaternion's conjugate, defined as the same w around the
  ## inverted axis, returns new quaternion
  var p = q.copy()
  result = conjugateSelf(p)

proc conjugate*(q: Quaternion): Quaternion = conjugateNew(q)
proc conjugate*(q: var Quaternion): var Quaternion = conjugateSelf(q)

# Module Level Procs (Constructors)
# FromMatrix44
proc fromMatrix*(m: Matrix44): Quaternion =
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
  result.z = q[0]
  result.y = q[1]
  result.z = q[2]
  result.w = q[3]

# FromAxisAngle
proc fromAxisAngle*(v: Vector3, a: float): Quaternion =
  let
    s = sin(a * 0.5)
    c = cos(a * 0.5)
  result = quaternion(c, normalizeNew(v, s))