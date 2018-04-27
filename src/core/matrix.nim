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
    ## Implements a row major 2D matrix
    ## ax ay az
    ## bx by bz
    matrix*: array[2, array[3, float]]
  
  Matrix44* = object
    ## Implements a row major 3D matrix 
    ## [ ax(0,0) ay(0,1) az(0,2) aw(0,3) ]
    ## [ bx(1,0) by(1,1) bz(1,2) bw(1,3) ]
    ## [ cx(2,0) cy(2,1) cz(2,2) cw(2,3) ]
    ## [ tx(3,0) ty(3,1) tz(3,2) tw(3,3) ]
    matrix*: array[4, array[4, float]]

from ./quaternion import
  Quaternion

# Constructors
proc matrix32*(
    m00, m01, m02, 
    m10, m11, m12: float
  ): Matrix32 = 
  ## Creates a new 2x3 2D transformation matrix.
  ## `ax`,`ay` is the local x axis
  ## `bx`,`by` is the local y axis
  ## `tx`,`ty` is the translation
  var mx: array[2,array[3,float]] 
  mx[0][0] = m00
  mx[0][1] = m01
  mx[0][2] = m02
  mx[1][0] = m10
  mx[1][1] = m11
  mx[1][2] = m12
  result.matrix = mx

proc matrix44*(
    m00, m01, m02, m03, 
    m10, m11, m12, m13, 
    m20, m21, m22, m23, 
    m30, m31, m32, m33: float
  ): Matrix44 = 
  ## Creates a new 4x4 3d transformation matrix.
  ## `ax` , `ay` , `az` is the local x axis.
  ## `bx` , `by` , `bz` is the local y axis.
  ## `cx` , `cy` , `cz` is the local z axis.
  ## `tx` , `ty` , `tz` is the translation.
  var mx: array[4, array[4, float]] 
  mx[0][0] = m00
  mx[0][1] = m01
  mx[0][2] = m02
  mx[0][3] = m03
  mx[1][0] = m10
  mx[1][1] = m11
  mx[1][2] = m12
  mx[1][3] = m13
  mx[2][0] = m20
  mx[2][1] = m21
  mx[2][2] = m22
  mx[2][3] = m23
  mx[3][0] = m30
  mx[3][1] = m31
  mx[3][2] = m32
  mx[3][3] = m33
  result.matrix = mx

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

# Accessors 
# NOTE: This is Added, not in design doc
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

# Set
# NOTE: This is Added, not in design doc
proc set*(m: var Matrix32, n: float): var Matrix32 {.noinit.} =
  ## Sets all elements in an existing matrix32 to single value.
  m.matrix = [[n, n, n],[n, n, n]]
  result = m

proc set*(m: var Matrix44, n: float): var Matrix44 {.noinit.} =
  ## Sets all elements in an existing matrix44 to single value.
  m.matrix = [[n, n, n, n],
              [n, n, n, n],
              [n, n, n, n],
              [n, n, n, n]]
  result = m  

proc set*(m: var Matrix32, 
  ax, ay, az, 
  bx, by, bz: float): var Matrix32 {.noinit.} =
  ## Sets arbitrary elements in an existing matrix32.
  m.matrix = [[ax, ay, az],[bx, by, bz]]
  result = m

proc set*(m: var Matrix44, 
  ax, ay, az, aw, 
  bx, by, bz, bw, 
  cx, cy, cz, cw, 
  tx, ty, tz, tw: float): var Matrix44 {.noinit.} =
  ## Sets arbitrary elements in an existing matrix44.
  m.matrix = [[ax, ay, az, aw],
              [bx, by, bz, bw],
              [cx, cy, cz, cw],
              [tx, ty, tz, tw]]
  result = m    

# Copy
proc copy*(m: Matrix32): Matrix32 =
  ## Copies an existing matrix32 to another
  result = Matrix32(matrix: m.matrix)
  
proc copy*(m: Matrix44): Matrix44 =
  ## Copies an existing matrix44 to another
  result = Matrix44(matrix: m.matrix)

# Clear
proc clear*(m: var Matrix32): var Matrix32 = set(m, 0.0)
proc clear*(m: var Matrix44): var Matrix44 = set(m, 0.0)

# Equals
proc `==`*(m1, m2: Matrix32): bool = 
  ## Checks is all elements of m1 and m2 are the same
  result = m1.matrix[0][0] == m2.matrix[0][0] and 
           m1.matrix[0][1] == m2.matrix[0][1] and 
           m1.matrix[0][2] == m2.matrix[0][2] and 
           m1.matrix[1][0] == m2.matrix[1][0] and 
           m1.matrix[1][1] == m2.matrix[1][1] and 
           m1.matrix[1][2] == m2.matrix[1][2]  
proc `==`*(m1, m2: Matrix44): bool =
  ## Checks is all elements of m1 and m2 are the same
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
  ## Returns a string representation of the matrix32
  result = &"[{m.matrix[0][0]}, {m.matrix[0][1]}, {m.matrix[0][2]}, \n" &
           &"{m.matrix[1][0]}, {m.matrix[1][1]}, {m.matrix[1][2]}]"
  
proc `$`*(m: Matrix44): string =
  ## Returns a string representation of the matrix44
  result = &"[{m.matrix[0][0]}, {m.matrix[0][1]}, {m.matrix[0][2]}, {m.matrix[0][3]}, \n" &
           &"{m.matrix[1][0]}, {m.matrix[1][1]}, {m.matrix[1][2]}, {m.matrix[1][3]}, \n" &
           &"{m.matrix[2][0]}, {m.matrix[2][1]}, {m.matrix[2][2]}, {m.matrix[2][3]}, \n" &
           &"{m.matrix[3][0]}, {m.matrix[3][1]}, {m.matrix[3][2]}, {m.matrix[3][3]}]"

# Transpose
proc transposeSelf*(m: var Matrix32): var Matrix32 {.noinit.} =
  ## Transposes a matrix, whose rows are the columns, and
  ## columns are the rows of the original.
  swap(m.matrix[0][1], m.matrix[1][0])
  swap(m.matrix[1][0], m.matrix[1][1])
  swap(m.matrix[0][2], m.matrix[1][1])
  result = m

proc transposeNew*(m: Matrix32): Matrix32 =
  ## Returns a new matrix whose rows are the columns, and
  ## columns are the rows of the original.
  result.matrix[0][0] = m.matrix[0][0]
  result.matrix[0][1] = m.matrix[1][0]
  result.matrix[0][2] = m.matrix[0][1]
  result.matrix[1][0] = m.matrix[1][1]
  result.matrix[1][1] = m.matrix[0][2]
  result.matrix[1][2] = m.matrix[1][2]

proc transposeSelf*(m: var Matrix44): var Matrix44 {.noinit.} =
  ## Transposes a matrix, whose rows are the columns, and
  ## columns are the rows of the original.
  swap(m.matrix[0][1], m.matrix[1][0])
  swap(m.matrix[0][2], m.matrix[2][0])
  swap(m.matrix[1][2], m.matrix[2][1])
  swap(m.matrix[0][3], m.matrix[3][0])
  swap(m.matrix[1][3], m.matrix[3][1])
  swap(m.matrix[2][3], m.matrix[3][2])
  result = m

proc transposeNew*(m: Matrix44): Matrix44 =
  ## Returns a new matrix whose rows are the columns, and
  ## columns are the rows of the original.
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
  ## Ignore this method
  ## Computes the determinant of the matrix44.
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
  ## Computes the determinant of the matrix32.
  return m.matrix[0][0] * m.matrix[1][1] - m.matrix[1][0] * m.matrix[0][1]

proc determinant*(m: Matrix44): float =
  ## Computes the determinant of the matrix44.
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
  ## Returns a new matrix, which is the inverse of the matrix
  ## If the matrix is not invertible (determinant=0), an EDivByZero
  ## will be raised.
  let det = m.determinant
  if det == 0.0:
    raise newException(DivByZeroError, "Cannot invert a zero determinant matrix")
  result.set(
    m.matrix[1][1] / det, - m.matrix[0][1] / det,
    -m.matrix[1][0] / det, m.matrix[0][0] / det,
    (m.matrix[1][0] * m.matrix[2][1] - m.matrix[1][1] * m.matrix[2][0]) / det,
    (m.matrix[0][1] * m.matrix[2][0] - m.matrix[0][0] * m.matrix[2][1]) / det)

proc invert*(m: Matrix44): Matrix44 {.noInit.} =
  ## Computes the inverse of matrix `m`. If the matrix
  ## determinant is zero, thus not invertible, a EDivByZero
  ## will be raised.

  # this computation comes from optimize(invert(m)) in maxima CAS
  let det = m.determinant
  if det == 0.0:
    raise newException(DivByZeroError, "Cannot normalize zero length vector")
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
# Rotation 
proc fromQuaternion*(q1: Quaternion): Matrix44 {.noinit.} = 
  ## Sets the value of this matrix to the matrix conversion of the single quaternion
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
  ## Returns a new rotation matrix, which
  ## represents a rotation by `rad` radians
  let  
    s = sin(radians)
    c = cos(radians)
  result.set(c, s, -s, c, 0.0, 0.0)

proc rotate44X*(angle: float): Matrix44 {.noinit.} = 
  ## Creates a matrix that rotates around the x-axis with `angle` radians,
  ## which is also called a 'roll' matrix.
  let 
    c = cos(angle)
    s = sin(angle)
  result.set(
    1.0, 0.0, 0.0, 0.0,
    0.0, c, s, 0.0,
    0.0, -s, c, 0.0,
    0.0, 0.0, 0.0, 1.0)

proc rotate44Y*(angle: float): Matrix44 {.noinit.} = 
  ## Creates a matrix that rotates around the y-axis with `angle` radians,
  ## which is also called a 'pitch' matrix.
  let 
    c = cos(angle)
    s = sin(angle)
  result.set(
    c, 0.0, -s, 0.0,
    0.0, 1.0, 0.0, 0.0,
    s, 0.0, c, 0.0,
    0.0, 0.0, 0.0, 1.0)

proc rotate44Z*(angle: float): Matrix44 {.noinit.} = 
  ## Creates a matrix that rotates around the z-axis with `angle` radians,
  ## which is also called a 'yaw' matrix.
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
  ## Returns a new scale matrix32.
  result.set(
    s, 0.0, 0.0,
    s, 0.0, 0.0)

proc scale44*(s: float): Matrix44 {.noinit} = 
  ## Returns a new scale matrix44.
  result.set(
    s, 0.0, 0.0, 0.0,
    0.0, s, 0.0, 0.0,
    0.0, 0.0, s, 0.0,
    0.0, 0.0, 0.0, 1.0)

# Shear
proc shear32X*(sh: float): Matrix32 {.noinit.} = 
  ## Returns a new X-Shear matrix32.
  result.set(
    1.0, 0.0, sh,
    1.0, 0.0, 0.0)

proc shear32Y*(sh: float): Matrix32 {.noinit} = 
  ## Returns a new Y-Shear matrix32.
  result.set(
    1.0, sh, 0.0,
    1.0, 0.0, 0.0)

# NOTE: Not sure about shear32Z 
# NOTE: Shear Operations for Matrix44 incomplete
proc shear44X*(sh: float): Matrix44 {.noinit} =
  ## Returns a new X-Shear matrix44.
  result.set(
    1.0, sh, sh, 0.0,
    0.0, 1.0, 0.0, 0.0,
    0.0, 0.0, 1.0, 0.0,
    0.0, 0.0, 0.0, 1.0)

proc shear44Y*(sh: float): Matrix44 {.noinit} =
  ## Returns a new Y-Shear matrix44.
  result.set(
    1.0, 0.0, 0.0, 0.0,
    sh, 1.0, sh, 0.0,
    0.0, 0.0, 1.0, 0.0,
    0.0, 0.0, 0.0, 1.0)

proc shear44Z*(sh: float): Matrix44 {.noinit} =
  ## Returns a new Z-Shear matrix44.
  result.set(
    1.0, 0.0, 0.0, 0.0,
    0.0, 1.0, 0.0, 0.0,
    sh, sh, 1.0, 0.0,
    0.0, 0.0, 0.0, 1.0)

# Stretch
# NOTE: This is Added, not in design doc
proc stretch*(sx, sy: float): Matrix32 {.noInit.} =
  ## Returns new a stretch matrix, which is a
  ## scale matrix with non uniform scale in x and y.
  result.set(
    sx, 0.0, 0.0,
    sy, 0.0, 0.0)

proc stretch*(sx, sy, sz: float): Matrix44 {.noInit.} =
  ## Returns new a stretch matrix, which is a
  ## scale matrix with non uniform scale in x,y and z.
  result.set(
    sx, 0.0, 0.0, 0.0,
    0.0, sy, 0.0, 0.0,
    0.0, 0.0, sz, 0.0,
    0.0, 0.0, 0.0, 1.0)