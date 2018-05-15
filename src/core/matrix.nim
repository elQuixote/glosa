from ./concepts import
  Matrix,
  Compare,
  Equals,
  Hash,
  Clear,
  Copy,
  String

from ./types import
  Matrix33,
  Matrix44,
  Quaternion,
  Vector3,
  Vector4

export
  Matrix,
  Compare,
  Equals,
  Hash,
  Clear,
  Copy,
  String,
  Matrix33,
  Matrix44

from strformat import `&`
from math import sin, cos

import hashes

# Accessors
# NOTE: This is Added, not in design doc
proc `[]`*(m: Matrix33, i, j: int): float = m.matrix[i][j]
proc `[]`*(m: Matrix44, i, j: int): float = m.matrix[i][j]
proc `[]=`*(m: var Matrix33, i, j: int, v: float): float {.noinit.} = m.matrix[i][j] = v
proc `[]=`*(m: var Matrix44, i, j: int, v: float): float {.noinit.} = m.matrix[i][j] = v

## 3x3 Matrix
## [ m00(0,0) m01(0,1) m02(0,2) ]
## [ m10(1,0) m11(1,1) m12(1,2) ]
## [ m20(2,0) m21(2,1) m22(2,2) ]
proc m00*(m: Matrix33): float = m.matrix[0][0]
proc m01*(m: Matrix33): float = m.matrix[0][1]
proc m02*(m: Matrix33): float = m.matrix[0][2]
proc m10*(m: Matrix33): float = m.matrix[1][0]
proc m11*(m: Matrix33): float = m.matrix[1][1]
proc m12*(m: Matrix33): float = m.matrix[1][2]
proc m20*(m: Matrix33): float = m.matrix[2][0]
proc m21*(m: Matrix33): float = m.matrix[2][1]
proc m22*(m: Matrix33): float = m.matrix[2][2]

proc `m00=`*(m: var Matrix33, v: float) {.noinit.} = m.matrix[0][0] = v
proc `m01=`*(m: var Matrix33, v: float) {.noinit.} = m.matrix[0][1] = v
proc `m02=`*(m: var Matrix33, v: float) {.noinit.} = m.matrix[0][2] = v
proc `m10=`*(m: var Matrix33, v: float) {.noinit.} = m.matrix[1][0] = v
proc `m11=`*(m: var Matrix33, v: float) {.noinit.} = m.matrix[1][1] = v
proc `m12=`*(m: var Matrix33, v: float) {.noinit.} = m.matrix[1][2] = v
proc `m20=`*(m: var Matrix33, v: float) {.noinit.} = m.matrix[2][0] = v
proc `m21=`*(m: var Matrix33, v: float) {.noinit.} = m.matrix[2][1] = v
proc `m22=`*(m: var Matrix33, v: float) {.noinit.} = m.matrix[2][2] = v

## 4x4
## [ m00(0,0) m01(0,1) m02(0,2) m03(0,3) ]
## [ m10(1,0) m11(1,1) m12(1,2) m13(1,3) ]
## [ m20(2,0) m21(2,1) m22(2,2) m23(2,3) ]
## [ m30(3,0) m31(3,1) m32(3,2) m33(3,3) ]
proc m00*(m: Matrix44): float = m.matrix[0][0]
proc m01*(m: Matrix44): float = m.matrix[0][1]
proc m02*(m: Matrix44): float = m.matrix[0][2]
proc m03*(m: Matrix44): float = m.matrix[0][3]
proc m10*(m: Matrix44): float = m.matrix[1][0]
proc m11*(m: Matrix44): float = m.matrix[1][1]
proc m12*(m: Matrix44): float = m.matrix[1][2]
proc m13*(m: Matrix44): float = m.matrix[1][3]
proc m20*(m: Matrix44): float = m.matrix[2][0]
proc m21*(m: Matrix44): float = m.matrix[2][1]
proc m22*(m: Matrix44): float = m.matrix[2][2]
proc m23*(m: Matrix44): float = m.matrix[2][3]
proc m30*(m: Matrix44): float = m.matrix[3][0]
proc m31*(m: Matrix44): float = m.matrix[3][1]
proc m32*(m: Matrix44): float = m.matrix[3][2]
proc m33*(m: Matrix44): float = m.matrix[3][3]

proc `m00=`*(m: var Matrix44, v: float) {.noinit.} = m.matrix[0][0] = v
proc `m01=`*(m: var Matrix44, v: float) {.noinit.} = m.matrix[0][1] = v
proc `m02=`*(m: var Matrix44, v: float) {.noinit.} = m.matrix[0][2] = v
proc `m03=`*(m: var Matrix44, v: float) {.noinit.} = m.matrix[0][3] = v
proc `m10=`*(m: var Matrix44, v: float) {.noinit.} = m.matrix[1][0] = v
proc `m11=`*(m: var Matrix44, v: float) {.noinit.} = m.matrix[1][1] = v
proc `m12=`*(m: var Matrix44, v: float) {.noinit.} = m.matrix[1][2] = v
proc `m13=`*(m: var Matrix44, v: float) {.noinit.} = m.matrix[1][3] = v
proc `m20=`*(m: var Matrix44, v: float) {.noinit.} = m.matrix[2][0] = v
proc `m21=`*(m: var Matrix44, v: float) {.noinit.} = m.matrix[2][1] = v
proc `m22=`*(m: var Matrix44, v: float) {.noinit.} = m.matrix[2][2] = v
proc `m23=`*(m: var Matrix44, v: float) {.noinit.} = m.matrix[2][3] = v
proc `m30=`*(m: var Matrix44, v: float) {.noinit.} = m.matrix[3][0] = v
proc `m31=`*(m: var Matrix44, v: float) {.noinit.} = m.matrix[3][1] = v
proc `m32=`*(m: var Matrix44, v: float) {.noinit.} = m.matrix[3][2] = v
proc `m33=`*(m: var Matrix44, v: float) {.noinit.} = m.matrix[3][3] = v

# Constructors
proc matrix33*(
    m00, m01, m02,
    m10, m11, m12,
    m20, m21, m22: float
  ): Matrix33 =
  result.matrix[0][0] = m00
  result.matrix[0][1] = m01
  result.matrix[0][2] = m02
  result.matrix[1][0] = m10
  result.matrix[1][1] = m11
  result.matrix[1][2] = m12
  result.matrix[2][0] = m20
  result.matrix[2][1] = m21
  result.matrix[2][2] = m22

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

proc matrix33*(v1, v2, v3: Vector3): Matrix44 =
  result.matrix[0][0] = v1.x
  result.matrix[0][1] = v2.x
  result.matrix[0][2] = v3.x
  result.matrix[1][0] = v1.y
  result.matrix[1][1] = v2.y
  result.matrix[1][2] = v3.y
  result.matrix[2][0] = v1.z
  result.matrix[2][1] = v2.z
  result.matrix[2][2] = v3.z

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

# Identity
# NOTE: This is Added, not in design doc
const
  IDMatrix33*: Matrix33 = matrix33(
    1.0, 0.0, 0.0,
    0.0, 1.0, 0.0,
    0.0, 0.0, 1.0
  )
    ## Quick access to an identity matrix
  IDMATRIX44*: Matrix44 = matrix44(
    1.0, 0.0, 0.0, 0.0,
    0.0, 1.0, 0.0, 0.0,
    0.0, 0.0, 1.0, 0.0,
    0.0, 0.0, 0.0, 1.0
  )
    ## Quick access to an identity matrix

# Set
# NOTE: This is Added, not in design doc
proc set*(m: var Matrix33, n: float): var Matrix33 {.noinit.} =
  m.matrix = [[n, n, n],
              [n, n, n],
              [n, n, n]]
  result = m

proc set*(m: var Matrix44, n: float): var Matrix44 {.noinit.} =
  m.matrix = [[n, n, n, n],
              [n, n, n, n],
              [n, n, n, n],
              [n, n, n, n]]
  result = m

proc set*(m: var Matrix33,
    m00, m01, m02,
    m10, m11, m12,
    m20, m21, m22: float
  ): var Matrix33 {.noinit.} =
  m.matrix = [[m00, m01, m02],
              [m10, m11, m12],
              [m20, m21, m22]]
  result = m

proc set*(m: var Matrix44,
    m00, m01, m02, m03,
    m10, m11, m12, m13,
    m20, m21, m22, m23,
    m30, m31, m32, m33: float
  ): var Matrix44 {.noinit.} =
  m.matrix = [[m00, m01, m02, m03],
              [m10, m11, m12, m13],
              [m20, m21, m22, m23],
              [m30, m31, m32, m33]]
  result = m

# Copy
proc copy*(m: Matrix33): Matrix33 =
  result = Matrix33(matrix: m.matrix)

proc copy*(m: Matrix44): Matrix44 =
  result = Matrix44(matrix: m.matrix)

# Clear
proc clear*(m: var Matrix33): var Matrix33 = set(m, 0.0)
proc clear*(m: var Matrix44): var Matrix44 = set(m, 0.0)

# Equals
proc `==`*(m1, m2: Matrix33): bool =
  result = m1.matrix[0][0] == m2.matrix[0][0] and
           m1.matrix[0][1] == m2.matrix[0][1] and
           m1.matrix[0][2] == m2.matrix[0][2] and
           m1.matrix[1][0] == m2.matrix[1][0] and
           m1.matrix[1][1] == m2.matrix[1][1] and
           m1.matrix[1][2] == m2.matrix[1][2] and
           m1.matrix[2][0] == m2.matrix[2][0] and
           m1.matrix[2][1] == m2.matrix[2][1] and
           m1.matrix[2][2] == m2.matrix[2][2]

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
           m1.matrix[2][3] == m2.matrix[2][3] and
           m1.matrix[3][0] == m2.matrix[3][0] and
           m1.matrix[3][1] == m2.matrix[3][1] and
           m1.matrix[3][2] == m2.matrix[3][2] and
           m1.matrix[3][3] == m2.matrix[3][3]

# Hash
proc hash*(m: Matrix33): hashes.Hash =
  result = !$(result !&
    hash(m.matrix[0][0]) !& hash(m.matrix[0][1]) !& hash(m.matrix[0][2]) !&
    hash(m.matrix[1][0]) !& hash(m.matrix[1][1]) !& hash(m.matrix[1][2]) !&
    hash(m.matrix[2][0]) !& hash(m.matrix[2][1]) !& hash(m.matrix[2][2])
  )

proc hash*(m: Matrix44): hashes.Hash =
  result = !$(result !&
    hash(m.matrix[0][0]) !& hash(m.matrix[0][1]) !& hash(m.matrix[0][2]) !& hash(m.matrix[0][3]) !&
    hash(m.matrix[1][0]) !& hash(m.matrix[1][1]) !& hash(m.matrix[1][2]) !& hash(m.matrix[1][3]) !&
    hash(m.matrix[2][0]) !& hash(m.matrix[2][1]) !& hash(m.matrix[2][2]) !& hash(m.matrix[2][3]) !&
    hash(m.matrix[3][0]) !& hash(m.matrix[3][1]) !& hash(m.matrix[3][2]) !& hash(m.matrix[3][3])
  )

# String
# NOTE: Changed from design doc
proc `$`*(m: Matrix33): string =
  result = &"[[{m.matrix[0][0]}, {m.matrix[0][1]}, {m.matrix[0][2]}],\n" &
            &"[{m.matrix[1][0]}, {m.matrix[1][1]}, {m.matrix[1][2]}],\n" &
            &"[{m.matrix[2][0]}, {m.matrix[2][1]}, {m.matrix[2][2]}]]"

proc `$`*(m: Matrix44): string =
  result = &"[[{m.matrix[0][0]}, {m.matrix[0][1]}, {m.matrix[0][2]}, {m.matrix[0][3]}],\n" &
            &"[{m.matrix[1][0]}, {m.matrix[1][1]}, {m.matrix[1][2]}, {m.matrix[1][3]}],\n" &
            &"[{m.matrix[2][0]}, {m.matrix[2][1]}, {m.matrix[2][2]}, {m.matrix[2][3]}],\n" &
            &"[{m.matrix[3][0]}, {m.matrix[3][1]}, {m.matrix[3][2]}, {m.matrix[3][3]}]]"

# Transpose
proc transposeSelf*(m: var Matrix33): var Matrix33 {.noinit.} =
  swap(m.matrix[0][1], m.matrix[1][0])
  swap(m.matrix[0][2], m.matrix[2][0])
  swap(m.matrix[1][2], m.matrix[2][1])
  result = m

proc transposeNew*(m: Matrix33): Matrix33 =
  var n = copy(m)
  result = transposeSelf(n)

proc transposeSelf*(m: var Matrix44): var Matrix44 {.noinit.} =
  swap(m.matrix[0][1], m.matrix[1][0])
  swap(m.matrix[0][2], m.matrix[2][0])
  swap(m.matrix[1][2], m.matrix[2][1])
  swap(m.matrix[0][3], m.matrix[3][0])
  swap(m.matrix[1][3], m.matrix[3][1])
  swap(m.matrix[2][3], m.matrix[3][2])
  result = m

proc transposeNew*(m: Matrix44): Matrix44 =
  var n = copy(m)
  result = transposeSelf(n)

proc transpose*(m: Matrix33): Matrix33 = transposeNew(m)
proc transpose*(m: Matrix44): Matrix44 = transposeNew(m)

# Determinant
proc determinant*(m: Matrix33): float =
  result = m.matrix[0][0] * (m.matrix[1][1] * m.matrix[2][2] - m.matrix[1][2] * m.matrix[2][1]) -
           m.matrix[0][1] * (m.matrix[1][0] * m.matrix[2][2] - m.matrix[1][2] * m.matrix[2][0]) +
           m.matrix[0][2] * (m.matrix[1][0] * m.matrix[2][1] - m.matrix[1][1] * m.matrix[2][0])

proc determinant*(m: Matrix44): float =
  let
    p0 = m.matrix[0][2] * m.matrix[1][3]
    p1 = m.matrix[0][2] * m.matrix[2][3]
    p2 = m.matrix[0][2] * m.matrix[3][3]
    p3 = m.matrix[1][2] * m.matrix[0][3]
    p4 = m.matrix[1][2] * m.matrix[2][3]
    p5 = m.matrix[1][2] * m.matrix[3][3]
    p6 = m.matrix[2][2] * m.matrix[0][3]
    p7 = m.matrix[2][2] * m.matrix[1][3]
    p8 = m.matrix[2][2] * m.matrix[3][3]
    p9 = m.matrix[3][2] * m.matrix[0][3]
    pA = m.matrix[3][2] * m.matrix[1][3]
    pB = m.matrix[3][2] * m.matrix[2][3]
  result = m.matrix[0][0] * m.matrix[1][1] * (p8 - pB) +
           m.matrix[0][0] * m.matrix[2][1] * (pA - p5) +
           m.matrix[0][0] * m.matrix[3][1] * (p4 - p7) +
           m.matrix[1][0] * m.matrix[0][1] * (pB - p8) +
           m.matrix[1][0] * m.matrix[2][1] * (p2 - p9) +
           m.matrix[1][0] * m.matrix[3][1] * (p6 - p1) +
           m.matrix[2][0] * m.matrix[0][1] * (p5 - pA) +
           m.matrix[2][0] * m.matrix[1][1] * (p9 - p2) +
           m.matrix[2][0] * m.matrix[3][1] * (p0 - p3) +
           m.matrix[3][0] * m.matrix[0][1] * (p7 - p4) +
           m.matrix[3][0] * m.matrix[1][1] * (p1 - p6) +
           m.matrix[3][0] * m.matrix[2][1] * (p3 - p0)
# Invert
proc invertSelf*(m: var Matrix33): var Matrix33 {.noinit.} =
  let
    q0 = m.matrix[1][1] * m.matrix[2][2] - m.matrix[1][2] * m.matrix[2][1]
    q1 = m.matrix[1][0] * m.matrix[2][1] - m.matrix[1][1] * m.matrix[2][0]
    p0 = m.matrix[1][0] * m.matrix[2][2]
    p1 = m.matrix[1][2] * m.matrix[2][0]
    det = m.matrix[0][0] * q0 - m.matrix[0][1] * (p0 - p1) + m.matrix[0][2] * q1
  if det == 0.0:
    raise newException(DivByZeroError, "Cannot invert a zero determinant matrix")
  m = m.set(
    q0 / det,
    (m.matrix[0][2] * m.matrix[2][1] - m.matrix[0][1] * m.matrix[2][2]) / det,
    (m.matrix[0][1] * m.matrix[1][2] - m.matrix[0][2] * m.matrix[1][1]) / det,
    (p1 - p0) / det,
    (m.matrix[0][0] * m.matrix[2][2] - m.matrix[0][2] * m.matrix[2][0]) / det,
    (m.matrix[0][2] * m.matrix[1][0] - m.matrix[0][0] * m.matrix[1][2]) / det,
    q1 / det,
    (m.matrix[0][1] * m.matrix[2][0] - m.matrix[0][0] * m.matrix[2][1]) / det,
    (m.matrix[0][0] * m.matrix[1][1] - m.matrix[0][1] * m.matrix[1][0]) / det,
  )
  result = m

proc invertNew*(m: Matrix33): Matrix33 =
  var n = m.copy()
  result = invertSelf(n)

proc invertSelf*(m: var Matrix44): var Matrix44 {.noinit.} =
  let
    lr10 = m.matrix[1][0] * m.matrix[2][1]
    lr11 = m.matrix[1][1] * m.matrix[2][2]
    lr12 = m.matrix[1][2] * m.matrix[2][3]
    lr13 = m.matrix[1][3] * m.matrix[2][0]
    lr20 = m.matrix[2][0] * m.matrix[3][1]
    lr21 = m.matrix[2][1] * m.matrix[3][2]
    lr22 = m.matrix[2][2] * m.matrix[3][3]
    lr23 = m.matrix[2][3] * m.matrix[3][0]
    rl10 = m.matrix[1][0] * m.matrix[2][3]
    rl11 = m.matrix[1][1] * m.matrix[2][0]
    rl12 = m.matrix[1][2] * m.matrix[2][1]
    rl13 = m.matrix[1][3] * m.matrix[2][2]
    rl20 = m.matrix[2][0] * m.matrix[3][3]
    rl21 = m.matrix[2][1] * m.matrix[3][0]
    rl22 = m.matrix[2][2] * m.matrix[3][1]
    rl23 = m.matrix[2][3] * m.matrix[3][2]
  let
    i0  = lr11 * m.matrix[3][3] - m.matrix[1][1] * rl23 - rl12 * m.matrix[3][3] +
          m.matrix[1][3] * lr21 + lr12 * m.matrix[3][1] - rl13 * m.matrix[3][1]
    i4  = rl10 * m.matrix[3][2] - m.matrix[1][0] * lr22 + m.matrix[1][2] * rl20 -
          lr13 * m.matrix[3][2] - lr12 * m.matrix[3][0] + rl13 * m.matrix[3][0]
    i8  = lr10 * m.matrix[3][3] - rl10 * m.matrix[3][1] - rl11 * m.matrix[3][3] +
          lr13 * m.matrix[3][1] + m.matrix[1][1] * lr23 - m.matrix[1][3] * rl21
    i12 = m.matrix[1][0] * rl22 - lr10 * m.matrix[3][2] + rl11 * m.matrix[3][2] -
          m.matrix[1][2] * lr20 - lr11 * m.matrix[3][0] + rl12 * m.matrix[3][0]
    det = m.matrix[0][0] * i0 + m.matrix[0][1] * i4 + m.matrix[0][2] * i8 + m.matrix[0][3] * i12
  if det == 0.0:
    raise newException(DivByZeroError, "Cannot invert a zero determinant matrix")
  let
    lr00 = m.matrix[0][0] * m.matrix[1][1]
    lr01 = m.matrix[0][1] * m.matrix[1][2]
    lr02 = m.matrix[0][2] * m.matrix[1][3]
    lr03 = m.matrix[0][3] * m.matrix[1][0]
    lr30 = m.matrix[3][0] * m.matrix[0][1]
    lr31 = m.matrix[3][1] * m.matrix[0][2]
    lr32 = m.matrix[3][2] * m.matrix[0][3]
    lr33 = m.matrix[3][3] * m.matrix[0][0]
    rl00 = m.matrix[0][0] * m.matrix[1][3]
    rl01 = m.matrix[0][1] * m.matrix[1][0]
    rl02 = m.matrix[0][2] * m.matrix[1][1]
    rl03 = m.matrix[0][3] * m.matrix[1][2]
    rl30 = m.matrix[3][0] * m.matrix[0][3]
    rl31 = m.matrix[3][1] * m.matrix[0][0]
    rl32 = m.matrix[3][2] * m.matrix[0][1]
    rl33 = m.matrix[3][3] * m.matrix[0][2]
  m = m.set(
     i0 / det,
    (m.matrix[0][1] * rl23 - m.matrix[0][1] * lr22 + rl33 * m.matrix[2][1] -
     m.matrix[0][3] * lr21 - lr31 * m.matrix[2][3] + m.matrix[0][3] * rl22) / det,
    (lr01 * m.matrix[3][3] - rl32 * m.matrix[1][3] - rl02 * m.matrix[3][3] +
     lr32 * m.matrix[1][1] + lr02 * m.matrix[3][1] - rl03 * m.matrix[3][1]) / det,
    (m.matrix[0][1] * rl13 - lr01 * m.matrix[2][3] + rl02 * m.matrix[2][3] -
     m.matrix[0][3] * lr11 - lr02 * m.matrix[2][1] + rl03 * m.matrix[2][1]) / det,
     i4 / det,
    (m.matrix[0][0] * lr22 - m.matrix[0][0] * rl23 - m.matrix[0][2] * rl20 +
     lr32 * m.matrix[2][0] + m.matrix[0][2] * lr23 - rl30 * m.matrix[2][2]) / det,
    (rl00 * m.matrix[3][2] - lr33 * m.matrix[1][2] + rl33 * m.matrix[1][0] -
     lr03 * m.matrix[3][2] - lr02 * m.matrix[3][0] + rl03 * m.matrix[3][0]) / det,
    (m.matrix[0][0] * lr12 - rl00 * m.matrix[2][2] - m.matrix[0][2] * rl10 +
     lr03 * m.matrix[2][2] + lr02 * m.matrix[2][0] - rl03 * m.matrix[2][0]) / det,
     i8 / det,
    (rl31 * m.matrix[2][3] - lr33 * m.matrix[2][1] + m.matrix[0][1] * rl20 -
     m.matrix[0][3] * lr20 - m.matrix[0][1] * lr23 + m.matrix[0][3] * rl21) / det,
    (lr00 * m.matrix[3][3] - rl00 * m.matrix[3][1] - rl01 * m.matrix[3][3] +
     lr03 * m.matrix[3][1] + lr30 * m.matrix[1][3] - rl30 * m.matrix[1][1]) / det,
    (rl00 * m.matrix[2][1] - lr00 * m.matrix[2][3] + rl01 * m.matrix[2][3] -
     lr03 * m.matrix[2][1] - m.matrix[0][1] * lr13 + m.matrix[0][3] * rl11) / det,
     i12 / det,
    (m.matrix[0][0] * lr21 - m.matrix[0][0] * rl22 - rl32 * m.matrix[2][0] +
     m.matrix[0][2] * lr20 + lr30 * m.matrix[2][2] - m.matrix[0][2] * rl21) / det,
    (rl31 * m.matrix[1][2] - lr00 * m.matrix[3][2] + rl01 * m.matrix[3][2] -
     lr31 * m.matrix[1][0] - lr01 * m.matrix[3][0] + rl02 * m.matrix[3][0]) / det,
    (lr00 * m.matrix[2][2] - m.matrix[0][0] * rl12 - rl01 * m.matrix[2][2] +
     m.matrix[0][2] * lr10 + lr01 * m.matrix[2][0] - rl02 * m.matrix[2][0]) / det,
  )
  result = m

proc invertNew*(m: Matrix44): Matrix44 =
  var n = m.copy()
  result = invertSelf(n)

proc invert*(m: var Matrix33): var Matrix33 {.noinit.} = invertSelf(m)
proc invert*(m: var Matrix44): var Matrix44 {.noinit.} = invertSelf(m)

# Module Level Procs (Constructors)
# Rotation
proc fromQuaternion*(q: Quaternion): Matrix44 =
  result.matrix[0][0] = 1.0 - 2.0 * q.y * q.y - 2.0 * q.z * q.z
  result.matrix[1][0] = 2.0 * (q.x * q.y + q.w * q.z)
  result.matrix[2][0] = 2.0 * (q.x * q.z - q.w * q.y)
  result.matrix[0][1] = 2.0 * (q.x * q.y - q.w * q.z)
  result.matrix[1][1] = 1.0 - 2.0 * q.x * q.x - 2.0 * q.z * q.z
  result.matrix[2][1] = 2.0 * (q.y * q.z + q.w * q.x)
  result.matrix[0][2] = 2.0 * (q.x * q.z + q.w * q.y)
  result.matrix[1][2] = 2.0 * (q.y * q.z - q.w * q.x)
  result.matrix[2][2] = 1.0 - 2.0 * q.x * q.x - 2.0 * q.y * q.y
  result.matrix[0][3] = 0.0
  result.matrix[1][3] = 0.0
  result.matrix[2][3] = 0.0
  result.matrix[3][0] = 0.0
  result.matrix[3][1] = 0.0
  result.matrix[3][2] = 0.0
  result.matrix[3][3] = 1.0

proc rotate33*(theta: float): Matrix33 =
  let
    s = sin(theta)
    c = cos(theta)
  result.set(
      c,   s,  -s,
      c, 0.0, 0.0,
    0.0, 0.0, 1.0
  )

proc rotateX44*(theta: float): Matrix44 =
  let
    c = cos(theta)
    s = sin(theta)
  result.set(
    1.0, 0.0, 0.0, 0.0,
    0.0,   c,   s, 0.0,
    0.0,  -s,   c, 0.0,
    0.0, 0.0, 0.0, 1.0
  )

proc rotateY44*(theta: float): Matrix44 =
  let
    c = cos(theta)
    s = sin(theta)
  result.set(
      c, 0.0,  -s, 0.0,
    0.0, 1.0, 0.0, 0.0,
      s, 0.0,   c, 0.0,
    0.0, 0.0, 0.0, 1.0
  )

proc rotateZ44*(theta: float): Matrix44 =
  let
    c = cos(theta)
    s = sin(theta)
  result.set(
      c,   s, 0.0, 0.0,
     -s,   c, 0.0, 0.0,
    0.0, 0.0, 1.0, 0.0,
    0.0, 0.0, 0.0, 1.0
  )

# NOTE: This is Added, not in design doc
proc scale*(sx, sy: float): Matrix33 =
  result.set(
     sx, 0.0, 0.0,
    0.0,  sy, 0.0,
    0.0, 0.0, 1.0
  )

proc scale*(sx, sy, sz: float): Matrix44 =
  result.set(
     sx, 0.0, 0.0, 0.0,
    0.0,  sy, 0.0, 0.0,
    0.0, 0.0,  sz, 0.0,
    0.0, 0.0, 0.0, 1.0
  )

proc scale33*(s: float): Matrix33 = scale(s, s)
proc scale44*(s: float): Matrix44 = scale(s, s, s)

# Shear
proc shearX33*(sx: float): Matrix33 {.noinit.} =
  result.set(
    1.0, 0.0, 0.0,
     sx, 1.0, 0.0,
    0.0, 0.0, 1.0
  )

proc shearY33*(sy: float): Matrix33 {.noinit} =
  result.set(
    1.0,  sy, 0.0,
    0.0, 1.0, 0.0,
    0.0, 0.0, 1.0
  )

proc shearX44*(sy, sz: float): Matrix44 =
  result.set(
    1.0,  sy,  sz, 0.0,
    0.0, 1.0, 0.0, 0.0,
    0.0, 0.0, 1.0, 0.0,
    0.0, 0.0, 0.0, 1.0
  )

proc shearY44*(sx, sz: float): Matrix44 =
  result.set(
    1.0, 0.0, 0.0, 0.0,
     sx, 1.0,  sz, 0.0,
    0.0, 0.0, 1.0, 0.0,
    0.0, 0.0, 0.0, 1.0
  )

proc shearZ44*(sx, sy: float): Matrix44 =
  result.set(
    1.0, 0.0, 0.0, 0.0,
    0.0, 1.0, 0.0, 0.0,
     sx,  sy, 1.0, 0.0,
    0.0, 0.0, 0.0, 1.0
  )

proc shearX44*(sh: float): Matrix44 = shearX44(sh, sh)
proc shearY44*(sh: float): Matrix44 = shearY44(sh, sh)
proc shearZ44*(sh: float): Matrix44 = shearZ44(sh, sh)