from ./concepts import
  Matrix,
  Compare,
  Equals,
  Hash,
  Clear,
  Copy,
  String

export
  Matrix,
  Compare,
  Equals,
  Hash,
  Clear,
  Copy,
  String

from strformat import `&`
from math import sin, cos

import hashes

type
  Matrix32* = object
    ## Implements a 2D matrix
    ## [ ax(0,0) ay(0,1) az(0,2) ]
    ## [ bx(1,0) by(1,1) bz(1,2) ]
    matrix*: array[2, array[3, float]]

  Matrix44* = object
    ## Implements a 3D matrix
    ## [ ax(0,0) ay(0,1) az(0,2) aw(0,3) ]
    ## [ bx(1,0) by(1,1) bz(1,2) bw(1,3) ]
    ## [ cx(2,0) cy(2,1) cz(2,2) cw(2,3) ]
    ## [ tx(3,0) ty(3,1) tz(3,2) tw(3,3) ]
    matrix*: array[4, array[4, float]]

# Accessors
# NOTE: This is Added, not in design doc
proc `[]`*(m: Matrix32, i, j: int): float = m.matrix[i][j]
proc `[]`*(m: Matrix44, i, j: int): float = m.matrix[i][j]
proc `[]=`*(m: var Matrix32, i, j: int, v: float): float = m.matrix[i][j] = v
proc `[]=`*(m: var Matrix44, i, j: int, v: float): float = m.matrix[i][j] = v

proc ax*(m: Matrix32): float = m.matrix[0][0]
proc ay*(m: Matrix32): float = m.matrix[0][1]
proc az*(m: Matrix32): float = m.matrix[0][2]
proc bx*(m: Matrix32): float = m.matrix[1][0]
proc by*(m: Matrix32): float = m.matrix[1][1]
proc bz*(m: Matrix32): float = m.matrix[1][2]

proc `ax=`*(m: var Matrix32, v: float) = m.matrix[0][0] = v
proc `ay=`*(m: var Matrix32, v: float) = m.matrix[0][1] = v
proc `az=`*(m: var Matrix32, v: float) = m.matrix[0][2] = v
proc `bx=`*(m: var Matrix32, v: float) = m.matrix[1][0] = v
proc `by=`*(m: var Matrix32, v: float) = m.matrix[1][1] = v
proc `bz=`*(m: var Matrix32, v: float) = m.matrix[1][2] = v

proc ax*(m: Matrix44): float = m.matrix[0][0]
proc ay*(m: Matrix44): float = m.matrix[0][1]
proc az*(m: Matrix44): float = m.matrix[0][2]
proc aw*(m: Matrix44): float = m.matrix[0][3]
proc bx*(m: Matrix44): float = m.matrix[1][0]
proc by*(m: Matrix44): float = m.matrix[1][1]
proc bz*(m: Matrix44): float = m.matrix[1][2]
proc bw*(m: Matrix44): float = m.matrix[1][3]
proc cx*(m: Matrix44): float = m.matrix[2][0]
proc cy*(m: Matrix44): float = m.matrix[2][1]
proc cz*(m: Matrix44): float = m.matrix[2][2]
proc cw*(m: Matrix44): float = m.matrix[2][3]
proc tx*(m: Matrix44): float = m.matrix[3][0]
proc ty*(m: Matrix44): float = m.matrix[3][1]
proc tz*(m: Matrix44): float = m.matrix[3][2]
proc tw*(m: Matrix44): float = m.matrix[3][3]

proc `ax=`*(m: var Matrix44, v: float) = m.matrix[0][0] = v
proc `ay=`*(m: var Matrix44, v: float) = m.matrix[0][1] = v
proc `az=`*(m: var Matrix44, v: float) = m.matrix[0][2] = v
proc `aw=`*(m: var Matrix44, v: float) = m.matrix[0][3] = v
proc `bx=`*(m: var Matrix44, v: float) = m.matrix[1][0] = v
proc `by=`*(m: var Matrix44, v: float) = m.matrix[1][1] = v
proc `bz=`*(m: var Matrix44, v: float) = m.matrix[1][2] = v
proc `bw=`*(m: var Matrix44, v: float) = m.matrix[1][3] = v
proc `cx=`*(m: var Matrix44, v: float) = m.matrix[2][0] = v
proc `cy=`*(m: var Matrix44, v: float) = m.matrix[2][1] = v
proc `cz=`*(m: var Matrix44, v: float) = m.matrix[2][2] = v
proc `cw=`*(m: var Matrix44, v: float) = m.matrix[2][3] = v
proc `tx=`*(m: var Matrix44, v: float) = m.matrix[3][0] = v
proc `ty=`*(m: var Matrix44, v: float) = m.matrix[3][1] = v
proc `tz=`*(m: var Matrix44, v: float) = m.matrix[3][2] = v
proc `tw=`*(m: var Matrix44, v: float) = m.matrix[3][3] = v

# Constructors
proc matrix32*(
    m00, m01, m02,
    m10, m11, m12: float
  ): Matrix32 =
  result.matrix[0][0] = m00
  result.matrix[0][1] = m01
  result.matrix[0][2] = m02
  result.matrix[1][0] = m10
  result.matrix[1][1] = m11
  result.matrix[1][2] = m12

proc matrix44*(
    m00, m01, m02, m03,
    m10, m11, m12, m13,
    m20, m21, m22, m23,
    m30, m31, m32, m33: float
  ): Matrix44 =
  result.matrix[0][0] = m00
  result.matrix[0][1] = m01
  result.matrix[0][2] = m02
  result.matrix[0][3] = m03
  result.matrix[1][0] = m10
  result.matrix[1][1] = m11
  result.matrix[1][2] = m12
  result.matrix[1][3] = m13
  result.matrix[2][0] = m20
  result.matrix[2][1] = m21
  result.matrix[2][2] = m22
  result.matrix[2][3] = m23
  result.matrix[3][0] = m30
  result.matrix[3][1] = m31
  result.matrix[3][2] = m32
  result.matrix[3][3] = m33

# Identity
# NOTE: This is Added, not in design doc
const
  IDMATRIX32*: Matrix32 = matrix32(
    1.0, 0.0, 0.0,
    0.0, 1.0, 0.0)
    ## Quick access to an identity matrix
  IDMATRIX44*: Matrix44 = matrix44(
    1.0, 0.0, 0.0, 0.0,
    0.0, 1.0, 0.0, 0.0,
    0.0, 0.0, 1.0, 0.0,
    0.0, 0.0, 0.0, 1.0)
    ## Quick access to an identity matrix

# Set
# NOTE: This is Added, not in design doc
proc set*(m: var Matrix32, n: float): var Matrix32 {.noinit.} =
  m.matrix = [[n, n, n],[n, n, n]]
  result = m

proc set*(m: var Matrix44, n: float): var Matrix44 {.noinit.} =
  m.matrix = [[n, n, n, n],
              [n, n, n, n],
              [n, n, n, n],
              [n, n, n, n]]
  result = m

proc set*(m: var Matrix32,
    ax, ay, az,
    bx, by, bz: float
  ): var Matrix32 {.noinit.} =
  m.matrix = [[ax, ay, az],[bx, by, bz]]
  result = m

proc set*(m: var Matrix44,
    ax, ay, az, aw,
    bx, by, bz, bw,
    cx, cy, cz, cw,
    tx, ty, tz, tw: float
  ): var Matrix44 {.noinit.} =
  m.matrix = [[ax, ay, az, aw],
              [bx, by, bz, bw],
              [cx, cy, cz, cw],
              [tx, ty, tz, tw]]
  result = m

# Copy
proc copy*(m: Matrix32): Matrix32 =
  result = Matrix32(matrix: m.matrix)

proc copy*(m: Matrix44): Matrix44 =
  result = Matrix44(matrix: m.matrix)

# Clear
proc clear*(m: var Matrix32): var Matrix32 = set(m, 0.0)
proc clear*(m: var Matrix44): var Matrix44 = set(m, 0.0)

# Equals
proc `==`*(m1, m2: Matrix32): bool =
  result = m1.matrix[0][0] == m2.matrix[0][0] and
           m1.matrix[0][1] == m2.matrix[0][1] and
           m1.matrix[0][2] == m2.matrix[0][2] and
           m1.matrix[1][0] == m2.matrix[1][0] and
           m1.matrix[1][1] == m2.matrix[1][1] and
           m1.matrix[1][2] == m2.matrix[1][2]
proc `==`*(m1, m2: Matrix44): bool =
  result = m1.matrix[0][0] == m2.matrix[0][0] and
           m1.matrix[0][1] == m2.matrix[0][1] and
           m1.matrix[0][2] == m2.matrix[0][2] and
           m1.matrix[0][3] == m2.matrix[0][3] and
           m1.matrix[1][0] == m2.matrix[1][0] and
           m1.matrix[1][1] == m2.matrix[1][1] and
           m1.matrix[1][2] == m2.matrix[1][2] and
           m1.matrix[1][3] == m2.matrix[1][3] and
           m1.matrix[2][0] == m2.matrix[2][0] and
           m1.matrix[2][1] == m2.matrix[2][1] and
           m1.matrix[2][2] == m2.matrix[2][2] and
           m1.matrix[2][3] == m2.matrix[2][2] and
           m1.matrix[3][0] == m2.matrix[3][0] and
           m1.matrix[3][1] == m2.matrix[3][1] and
           m1.matrix[3][2] == m2.matrix[3][2] and
           m1.matrix[3][3] == m2.matrix[3][3]

# Hash
proc hash*(m: Matrix32): hashes.Hash =
  result = !$(result !&
    hash(m.matrix[0][0]) !& hash(m.matrix[0][1]) !& hash(m.matrix[0][2]) !&
    hash(m.matrix[1][0]) !& hash(m.matrix[1][1]) !& hash(m.matrix[1][2]))

proc hash*(m: Matrix44): hashes.Hash =
  result = !$(result !&
    hash(m.matrix[0][0]) !& hash(m.matrix[0][1]) !& hash(m.matrix[0][2]) !& hash(m.matrix[0][3]) !&
    hash(m.matrix[1][0]) !& hash(m.matrix[1][1]) !& hash(m.matrix[1][2]) !& hash(m.matrix[1][3]) !&
    hash(m.matrix[2][0]) !& hash(m.matrix[2][1]) !& hash(m.matrix[2][2]) !& hash(m.matrix[2][3]) !&
    hash(m.matrix[3][0]) !& hash(m.matrix[3][1]) !& hash(m.matrix[3][2]) !& hash(m.matrix[3][3]))

# String
# NOTE: Changed from design doc
proc `$`*(m: Matrix32): string =
  result = &"[{m.matrix[0][0]}, {m.matrix[0][1]}, {m.matrix[0][2]}, \n" &
           &"{m.matrix[1][0]}, {m.matrix[1][1]}, {m.matrix[1][2]}]"

proc `$`*(m: Matrix44): string =
  result = &"[{m.matrix[0][0]}, {m.matrix[0][1]}, {m.matrix[0][2]}, {m.matrix[0][3]}, \n" &
           &"{m.matrix[1][0]}, {m.matrix[1][1]}, {m.matrix[1][2]}, {m.matrix[1][3]}, \n" &
           &"{m.matrix[2][0]}, {m.matrix[2][1]}, {m.matrix[2][2]}, {m.matrix[2][3]}, \n" &
           &"{m.matrix[3][0]}, {m.matrix[3][1]}, {m.matrix[3][2]}, {m.matrix[3][3]}]"

# Transpose
proc transposeSelf*(m: var Matrix32): var Matrix32 {.noinit.} =
  swap(m.matrix[0][1], m.matrix[1][0])
  swap(m.matrix[1][0], m.matrix[1][1])
  swap(m.matrix[0][2], m.matrix[1][1])
  result = m

proc transposeNew*(m: Matrix32): Matrix32 =
  result.matrix[0][0] = m.matrix[0][0]
  result.matrix[0][1] = m.matrix[1][0]
  result.matrix[0][2] = m.matrix[0][1]
  result.matrix[1][0] = m.matrix[1][1]
  result.matrix[1][1] = m.matrix[0][2]
  result.matrix[1][2] = m.matrix[1][2]

proc transposeSelf*(m: var Matrix44): var Matrix44 {.noinit.} =
  swap(m.matrix[0][1], m.matrix[1][0])
  swap(m.matrix[0][2], m.matrix[2][0])
  swap(m.matrix[1][2], m.matrix[2][1])
  swap(m.matrix[0][3], m.matrix[3][0])
  swap(m.matrix[1][3], m.matrix[3][1])
  swap(m.matrix[2][3], m.matrix[3][2])
  result = m

proc transposeNew*(m: Matrix44): Matrix44 =
  result.matrix[0][0] = m.matrix[0][0]
  result.matrix[0][1] = m.matrix[1][0]
  result.matrix[0][2] = m.matrix[2][0]
  result.matrix[0][3] = m.matrix[3][0]
  result.matrix[1][0] = m.matrix[0][1]
  result.matrix[1][1] = m.matrix[1][1]
  result.matrix[1][2] = m.matrix[2][1]
  result.matrix[1][3] = m.matrix[3][1]
  result.matrix[2][0] = m.matrix[0][2]
  result.matrix[2][1] = m.matrix[1][2]
  result.matrix[2][2] = m.matrix[2][2]
  result.matrix[2][3] = m.matrix[3][2]
  result.matrix[3][0] = m.matrix[0][3]
  result.matrix[3][1] = m.matrix[1][3]
  result.matrix[3][2] = m.matrix[2][3]
  result.matrix[3][3] = m.matrix[3][3]

proc transpose*(m: Matrix32): Matrix32 = transposeNew(m)
proc transpose*(m: Matrix44): Matrix44 = transposeNew(m)

# Determinant
proc determinants*(m: Matrix44): float =
  result = m.matrix[0][0] * (
    m.matrix[1][1] * m.matrix[2][2] * m.matrix[3][3] + m.matrix[1][2] *
    m.matrix[2][3] * m.matrix[3][1] + m.matrix[1][3] * m.matrix[2][1] *
    m.matrix[3][2] - m.matrix[1][3] * m.matrix[2][2] * m.matrix[3][1] -
    m.matrix[1][1] * m.matrix[2][3] * m.matrix[3][2] - m.matrix[1][2] *
    m.matrix[2][1] * m.matrix[3][3])
  result -= m.matrix[0][1] * (
    m.matrix[1][0] * m.matrix[2][2] * m.matrix[3][3] + m.matrix[1][2] *
    m.matrix[2][3] * m.matrix[3][0] + m.matrix[1][3] * m.matrix[2][0] *
    m.matrix[3][2] - m.matrix[1][3] * m.matrix[2][2] * m.matrix[3][0] -
    m.matrix[1][0] * m.matrix[2][3] * m.matrix[3][2] - m.matrix[1][2] *
    m.matrix[2][0] * m.matrix[3][3])
  result += m.matrix[0][2] * (
    m.matrix[1][0] * m.matrix[2][1] * m.matrix[3][3] + m.matrix[1][1] *
    m.matrix[2][3] * m.matrix[3][0] + m.matrix[1][3] * m.matrix[2][0] *
    m.matrix[3][1] - m.matrix[1][3] * m.matrix[2][1] * m.matrix[3][0] -
    m.matrix[1][0] * m.matrix[2][3] * m.matrix[3][1] - m.matrix[1][1] *
    m.matrix[2][0] * m.matrix[3][3])
  result -= m.matrix[0][3] * (
    m.matrix[1][0] * m.matrix[2][1] * m.matrix[3][2] + m.matrix[1][1] *
    m.matrix[2][2] * m.matrix[3][0] + m.matrix[1][2] * m.matrix[2][0] *
    m.matrix[3][1] - m.matrix[1][2] * m.matrix[2][1] * m.matrix[3][0] -
    m.matrix[1][0] * m.matrix[2][2] * m.matrix[3][1] - m.matrix[1][1] *
    m.matrix[2][0] * m.matrix[3][2])

proc determinant*(m: Matrix32): float =
  return m.matrix[0][0] * m.matrix[1][1] - m.matrix[1][0] * m.matrix[0][1]

proc determinant*(m: Matrix44): float =
  let
    r0 = m.matrix[2][0] * m.matrix[3][3] - m.matrix[2][3] * m.matrix[3][0]
    r1 = m.matrix[2][1] * m.matrix[3][3] - m.matrix[2][3] * m.matrix[3][1]
    r2 = m.matrix[2][0] * m.matrix[3][1] - m.matrix[2][1] * m.matrix[3][0]
    r3 = m.matrix[2][2] * m.matrix[3][3] - m.matrix[2][3] * m.matrix[3][2]
    r4 = m.matrix[2][0] * m.matrix[3][2] - m.matrix[2][2] * m.matrix[3][0]
    r5 = m.matrix[2][2] * m.matrix[3][2] - m.matrix[2][2] * m.matrix[3][1]
  return (r0 * m.matrix[0][1] - r1 * m.matrix[0][0] - r2 * m.matrix[0][3]) * m.matrix[1][2] +
         (-r0 * m.matrix[0][2] + r3 * m.matrix[0][0] + r4 * m.matrix[0][3]) * m.matrix[1][1] +
         (r1 * m.matrix[0][2] - r3 * m.matrix[0][1] - r5 * m.matrix[0][3]) * m.matrix[1][0] +
         (r2 * m.matrix[0][2] - r4 * m.matrix[0][1] + r5 * m.matrix[0][0]) * m.matrix[1][3]

# Invert
proc invert*(m: Matrix32): Matrix32 {.noInit.} =
  let det = m.determinant
  if det == 0.0:
    raise newException(DivByZeroError, "Cannot invert a zero determinant matrix")
  result.set(
    m.matrix[1][1] / det, - m.matrix[0][1] / det,
    -m.matrix[1][0] / det, m.matrix[0][0] / det,
    (m.matrix[1][0] * m.matrix[2][1] - m.matrix[1][1] * m.matrix[2][0]) / det,
    (m.matrix[0][1] * m.matrix[2][0] - m.matrix[0][0] * m.matrix[2][1]) / det)

proc invert*(m: Matrix44): Matrix44 {.noInit.} =
  let det = m.determinant
  if det == 0.0:
    raise newException(DivByZeroError, "Cannot invert a zero determinant matrix")
  let
    r0 = m.matrix[2][1] * m.matrix[3][3] - m.matrix[2][3] * m.matrix[3][1]
    r1 = m.matrix[2][2] * m.matrix[3][3] - m.matrix[2][3] * m.matrix[3][2]
    r2 = m.matrix[2][1] * m.matrix[3][2] - m.matrix[2][2] * m.matrix[3][1]
    r3 = m.matrix[1][1] * m.matrix[3][3] - m.matrix[1][3] * m.matrix[3][1]
    r4 = m.matrix[1][2] * m.matrix[3][3] - m.matrix[1][3] * m.matrix[3][2]
    r5 = m.matrix[1][1] * m.matrix[3][2] - m.matrix[1][2] * m.matrix[3][1]
    r6 = m.matrix[1][1] * m.matrix[2][3] - m.matrix[1][3] * m.matrix[2][1]
    r7 = m.matrix[1][2] * m.matrix[2][3] - m.matrix[1][3] * m.matrix[2][2]
    r8 = m.matrix[1][1] * m.matrix[2][2] - m.matrix[1][2] * m.matrix[2][1]
    r9 = m.matrix[2][0] * m.matrix[3][3] - m.matrix[2][3] * m.matrix[3][0]
    r10 = m.matrix[2][0] * m.matrix[3][2] - m.matrix[2][2] * m.matrix[3][0]
    r11 = m.matrix[1][0] * m.matrix[3][3] - m.matrix[1][3] * m.matrix[3][0]
    r12 = m.matrix[1][0] * m.matrix[3][2] - m.matrix[1][2] * m.matrix[3][0]
    r13 = m.matrix[1][0] * m.matrix[2][3] - m.matrix[1][3] * m.matrix[2][0]
    r14 = m.matrix[1][0] * m.matrix[2][2] - m.matrix[1][2] * m.matrix[2][0]
    r15 = m.matrix[2][0] * m.matrix[3][1] - m.matrix[2][1] * m.matrix[3][0]
    r16 = m.matrix[1][0] * m.matrix[3][1] - m.matrix[1][1] * m.matrix[3][0]
    r17 = m.matrix[1][0] * m.matrix[2][1] - m.matrix[1][1] * m.matrix[2][0]
  result.set(
    (m.matrix[1][3] * r2 + m.matrix[1][1] * r1 - m.matrix[1][2] * r0) / det,
    (-m.matrix[0][3] * r2 - m.matrix[0][1] * r1 + m.matrix[0][2] * r0) / det,
    (m.matrix[0][3] * r5 + m.matrix[0][1] * r4 - m.matrix[0][2] * r3) / det,
    (-m.matrix[0][3] * r8 - m.matrix[0][1] * r7 + m.matrix[0][2] * r6) / det,
    (-m.matrix[1][3] * r10 - m.matrix[1][0] * r1 + m.matrix[1][2] * r9) / det,
    (m.matrix[0][3] * r10 + m.matrix[0][0] * r1 - m.matrix[0][2] * r9) / det,
    (-m.matrix[0][3] * r12 - m.matrix[0][0] * r4 + m.matrix[0][2] * r11) / det,
    (m.matrix[0][3] * r14 + m.matrix[0][0] * r7 - m.matrix[0][2] * r13) / det,
    (m.matrix[1][3] * r15 + m.matrix[1][0] * r0 - m.matrix[1][1] * r9) / det,
    (-m.matrix[0][3] * r15 - m.matrix[0][0] * r0 + m.matrix[0][1] * r9) / det,
    (m.matrix[0][3] * r16 + m.matrix[0][0] * r3 - m.matrix[0][1] * r11) / det,
    (-m.matrix[0][3] * r17 - m.matrix[0][0] * r6 + m.matrix[0][1] * r13) / det,
    (-m.matrix[1][0] * r2 + m.matrix[1][1] * r10 - m.matrix[1][2] * r15) / det,
    (m.matrix[0][0] * r2 - m.matrix[0][1] * r10 + m.matrix[0][2] * r15) / det,
    (-m.matrix[0][0] * r5 + m.matrix[0][1] * r12 - m.matrix[0][2] * r16) / det,
    (m.matrix[0][0] * r8 - m.matrix[0][1] * r14 + m.matrix[0][2] * r17) / det)

# Module Level Procs (Constructors)

from ./quaternion import
  Quaternion

# Rotation
proc fromQuaternion*(q1: Quaternion): Matrix44 {.noinit.} =
  result.matrix[0][0] = 1.0 - 2.0 * q1.y * q1.y - 2.0 * q1.z * q1.z
  result.matrix[1][0] = 2.0 * (q1.x * q1.y + q1.w * q1.z)
  result.matrix[2][0] = 2.0 * (q1.x * q1.z - q1.w * q1.y)
  result.matrix[0][1] = 2.0 * (q1.x * q1.y - q1.w * q1.z)
  result.matrix[1][1] = 1.0 - 2.0 * q1.x * q1.x - 2.0 * q1.z * q1.z
  result.matrix[2][1] = 2.0 * (q1.y * q1.z + q1.w * q1.x)
  result.matrix[0][2] = 2.0 * (q1.x * q1.z + q1.w * q1.y)
  result.matrix[1][2] = 2.0 * (q1.y * q1.z - q1.w * q1.x)
  result.matrix[2][2] = 1.0 - 2.0 * q1.x * q1.x - 2.0 * q1.y * q1.y
  result.matrix[0][3] = 0.0
  result.matrix[1][3] = 0.0
  result.matrix[2][3] = 0.0
  result.matrix[3][0] = 0.0
  result.matrix[3][1] = 0.0
  result.matrix[3][2] = 0.0
  result.matrix[3][3] = 1.0

proc rotate32*(radians: float): Matrix32 {.noinit.} =
  let
    s = sin(radians)
    c = cos(radians)
  result.set(c, s, -s, c, 0.0, 0.0)

proc rotateX44*(angle: float): Matrix44 {.noinit.} =
  let
    c = cos(angle)
    s = sin(angle)
  result.set(
    1.0, 0.0, 0.0, 0.0,
    0.0, c, s, 0.0,
    0.0, -s, c, 0.0,
    0.0, 0.0, 0.0, 1.0)

proc rotateY44*(angle: float): Matrix44 {.noinit.} =
  let
    c = cos(angle)
    s = sin(angle)
  result.set(
    c, 0.0, -s, 0.0,
    0.0, 1.0, 0.0, 0.0,
    s, 0.0, c, 0.0,
    0.0, 0.0, 0.0, 1.0)

proc rotateZ44*(angle: float): Matrix44 {.noinit.} =
  let
    c = cos(angle)
    s = sin(angle)
  result.set(
    c, s, 0.0, 0.0,
    -s, c, 0.0, 0.0,
    0.0, 0.0, 1.0, 0.0,
    0.0, 0.0, 0.0, 1.0)

# Scale
proc scale32*(s: float): Matrix32 {.noinit} =
  result.set(
    s, 0.0, 0.0,
    s, 0.0, 0.0)

proc scale44*(s: float): Matrix44 {.noinit} =
  result.set(
    s, 0.0, 0.0, 0.0,
    0.0, s, 0.0, 0.0,
    0.0, 0.0, s, 0.0,
    0.0, 0.0, 0.0, 1.0)

# NOTE: This is Added, not in design doc
proc scale*(sx, sy: float): Matrix32 {.noInit.} =
  result.set(
    sx, 0.0, 0.0,
    sy, 0.0, 0.0)

proc scale*(sx, sy, sz: float): Matrix44 {.noInit.} =
  result.set(
    sx, 0.0, 0.0, 0.0,
    0.0, sy, 0.0, 0.0,
    0.0, 0.0, sz, 0.0,
    0.0, 0.0, 0.0, 1.0)

# Shear
proc shearX32*(sh: float): Matrix32 {.noinit.} =
  result.set(
    1.0, 0.0, sh,
    1.0, 0.0, 0.0)

proc shearY32*(sh: float): Matrix32 {.noinit} =
  result.set(
    1.0, sh, 0.0,
    1.0, 0.0, 0.0)

# NOTE: Not sure about shear32Z
# NOTE: Shear Operations for Matrix44 incomplete
proc shearX44*(sh: float): Matrix44 {.noinit} =
  result.set(
    1.0, sh, sh, 0.0,
    0.0, 1.0, 0.0, 0.0,
    0.0, 0.0, 1.0, 0.0,
    0.0, 0.0, 0.0, 1.0)

proc shearY44*(sh: float): Matrix44 {.noinit} =
  result.set(
    1.0, 0.0, 0.0, 0.0,
    sh, 1.0, sh, 0.0,
    0.0, 0.0, 1.0, 0.0,
    0.0, 0.0, 0.0, 1.0)

proc shearZ44*(sh: float): Matrix44 {.noinit} =
  result.set(
    1.0, 0.0, 0.0, 0.0,
    0.0, 1.0, 0.0, 0.0,
    sh, sh, 1.0, 0.0,
    0.0, 0.0, 0.0, 1.0)

# Additional Constructors
from ./vector import
  Vector2,
  Vector4

proc matrix32*(v1, v2, v3: Vector2): Matrix44 =
  result.matrix[0][0] = v1.x
  result.matrix[0][1] = v2.x
  result.matrix[0][2] = v3.x
  result.matrix[1][0] = v1.y
  result.matrix[1][1] = v2.y
  result.matrix[1][2] = v3.y

proc matrix44*(v1, v2, v3, v4: Vector4): Matrix44 =
  result.matrix[0][0] = v1.x
  result.matrix[0][1] = v2.x
  result.matrix[0][2] = v3.x
  result.matrix[0][3] = v4.x
  result.matrix[1][0] = v1.y
  result.matrix[1][1] = v2.y
  result.matrix[1][2] = v3.y
  result.matrix[1][3] = v4.y
  result.matrix[2][0] = v1.z
  result.matrix[2][1] = v2.z
  result.matrix[2][2] = v3.z
  result.matrix[2][3] = v4.z
  result.matrix[3][0] = v1.w
  result.matrix[3][1] = v2.w
  result.matrix[3][2] = v3.w
  result.matrix[3][3] = v4.w