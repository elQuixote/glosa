import ./concepts

from strformat import `&`
import hashes

type 
    Matrix32* = object
        m00*, m01*, m02*, 
        m10*, m11*, m12*: float
        matrix*: array[2,array[3,float]] #NOTE: Do we want an array for matrix access?
    
    Matrix44* = object
        m00*, m01*, m02*, m03*, 
        m10*, m11*, m12*, m13*, 
        m20*, m21*, m22*, m23*, 
        m30*, m31*, m32*, m33*: float
        matrix*: array[4,array[4,float]] #NOTE: Do we want an array for matrix access?

#Constructors
proc matrix32*(
    m00, m01, m02, 
    m10, m11, m12 : float
    ): Matrix32 = 
    var mx: array[2,array[3,float]] # NOTE: Do we need this for better access to matrix data?
    mx[0][0] = m00
    mx[0][1] = m01
    mx[0][2] = m02
    mx[1][0] = m10
    mx[1][1] = m11
    mx[1][2] = m12
    result.m00 = m00
    result.m01 = m01
    result.m02 = m02
    result.m10 = m10
    result.m11 = m11
    result.m12 = m12
    result.matrix = mx

proc matrix44*(
    m00, m01, m02, m03, 
    m10, m11, m12, m13, 
    m20, m21, m22, m23, 
    m30, m31, m32, m33): Matrix44 = 
    var mx: array[4,array[4,float]] # NOTE: Do we need this for better access to matrix data?
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
    result.m00 = m00
    result.m01 = m01
    result.m02 = m02
    result.m03 = m03
    result.m10 = m10
    result.m11 = m11
    result.m12 = m12
    result.m13 = m13
    result.m20 = m20
    result.m21 = m21
    result.m22 = m22
    result.m23 = m23
    result.m30 = m30
    result.m31 = m31
    result.m32 = m32
    result.m33 = m33
    result.matrix = mx
    
#Set
#NOTE : This is Added, not in design doc
proc set*(m: var Matrix32, n: float): var Matrix32 {.noinit.} =
    m.m00 = n
    m.m01 = n
    m.m02 = n
    m.m10 = n
    m.m11 = n
    m.m12 = n
    m.matrix[0][0] = n
    m.matrix[0][1] = n
    m.matrix[0][2] = n
    m.matrix[1][0] = n
    m.matrix[1][1] = n
    m.matrix[1][2] = n
    result = m

proc set*(m: var Matrix44, n: float): var Matrix44 {.noinit.} =
    m.m00 = n
    m.m01 = n
    m.m02 = n
    m.m03 = n
    m.m10 = n
    m.m11 = n
    m.m12 = n
    m.m13 = n
    m.m20 = n
    m.m21 = n
    m.m22 = n
    m.m23 = n
    m.m30 = n
    m.m31 = n
    m.m32 = n
    m.m33 = n
    m.matrix[0][0] = n
    m.matrix[0][1] = n
    m.matrix[0][2] = n
    m.matrix[0][3] = n
    m.matrix[1][0] = n
    m.matrix[1][1] = n
    m.matrix[1][2] = n
    m.matrix[1][3] = n
    m.matrix[2][0] = n
    m.matrix[2][1] = n
    m.matrix[2][2] = n
    m.matrix[2][3] = n
    m.matrix[3][0] = n
    m.matrix[3][1] = n
    m.matrix[3][2] = n
    m.matrix[3][3] = n
    result = m   

proc set*(m: var Matrix32, a,b,c,d,e,f: float): var Matrix32 {.noinit.} =
    m.m00 = a
    m.m01 = b
    m.m02 = c
    m.m10 = d
    m.m11 = e
    m.m12 = f
    m.matrix[0][0] = a
    m.matrix[0][1] = b
    m.matrix[0][2] = c
    m.matrix[1][0] = d
    m.matrix[1][1] = e
    m.matrix[1][2] = f
    result = m

proc set*(m: var Matrix44, a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p: float): var Matrix44 {.noinit.} =
    m.m00 = a
    m.m01 = b
    m.m02 = c
    m.m03 = d
    m.m10 = e   
    m.m11 = f
    m.m12 = g
    m.m13 = h
    m.m20 = i
    m.m21 = j
    m.m22 = k
    m.m23 = l
    m.m30 = m
    m.m31 = n
    m.m32 = o
    m.m33 = p
    m.matrix[0][0] = a
    m.matrix[0][1] = b
    m.matrix[0][2] = c
    m.matrix[0][3] = d
    m.matrix[1][0] = e
    m.matrix[1][1] = f
    m.matrix[1][2] = g
    m.matrix[1][3] = h
    m.matrix[2][0] = i
    m.matrix[2][1] = j
    m.matrix[2][2] = k
    m.matrix[2][3] = l
    m.matrix[3][0] = m
    m.matrix[3][1] = n
    m.matrix[3][2] = o
    m.matrix[3][3] = p
    result = m      

#Copy
proc copy*(m: Matrix32): Matrix32 =
    result = Matrix32(
      m00: m.m00, m01: m.m01, m02: m.m02, 
      m10: m.m10, m11: m.m11, m12: m.m12, matrix: m.matrix)
  
proc copy*(m: Matrix44): Matrix44 =
    result = Matrix44(
        m00: m.m00, m01: m.m01, m02: m.m02, m03: m.m03, 
        m10: m.m10, m11: m.m11, m12: m.m12, m13: m.m13,
        m20: m.m20, m21: m.m21, m22: m.m22, m23: m.m23, 
        m30: m.m30, m31: m.m31, m32: m.m32, m33: m.m33, matrix: m.matrix)

#Clear
template clear*(m: var Matrix32): var Matrix32 = set(m, 0.0)
template clear*(m: var Matrix44): var Matrix44 = set(m, 0.0)

#Equals
proc `==`*(m1, m2: Matrix32): bool = 
   result = m1.m00 == m2.m00 and m1.m01 == m2.m01 and m1.m02 == m2.m02 and
           m1.m10 == m2.m10 and m1.m11 == m2.m11 and m1.m12 == m2.m12   
proc `==`*(m1, m2: Matrix44): bool =
  result = m1.m00 == m2.m00 and m1.m01 == m2.m01 and m1.m02 == m2.m02 and m1.m03 == m2.m03 and
           m1.m10 == m2.m10 and m1.m11 == m2.m11 and m1.m12 == m2.m12 and m1.m13 == m2.m13 and
           m1.m20 == m2.m20 and m1.m21 == m2.m21 and m1.m22 == m2.m22 and m1.m23 == m2.m23 and
           m1.m30 == m2.m30 and m1.m31 == m2.m31 and m1.m32 == m2.m32 and m1.m33 == m2.m33  

# Hash
proc hash*(m: Matrix32): hashes.Hash =
    result = !$(result !& 
      hash(m.m00) !& hash(m.m01) !& hash(m.m02) !&
      hash(m.m10) !& hash(m.m11) !& hash(m.m12))
  
proc hash*(m: Matrix44): hashes.Hash =
    result = !$(result !& 
        hash(m.m00) !& hash(m.m01) !& hash(m.m02) !& hash(m.m03) !&
        hash(m.m10) !& hash(m.m11) !& hash(m.m12) !& hash(m.m13) !&
        hash(m.m20) !& hash(m.m21) !& hash(m.m22) !& hash(m.m23) !&
        hash(m.m30) !& hash(m.m31) !& hash(m.m32) !& hash(m.m33))

# String
# NOTE: Changed from design doc
proc `$`*(m: Matrix32): string =
    result = &"[{m.m00}, {m.m01}, {m.m02}, \n" &
             &"{m.m10}, {m.m11}, {m.m12}]"
  
proc `$`*(m: Matrix44): string =
    result = &"[{m.m00}, {m.m01}, {m.m02}, {m.m03}, \n" &
                &"{m.m10}, {m.m11}, {m.m12}, {m.m13}, \n" &
                &"{m.m20}, {m.m21}, {m.m22}, {m.m23}, \n" &
                &"{m.m30}, {m.m31}, {m.m32}, {m.m33}]"

#Transpose
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

template transpose*(m: Matrix32): Matrix32 = transposeNew*(m)
template transpose*(m: Matrix44): Matrix44 = transposeNew*(m)

#Determinant
#Note can we calculate the determinant of a non square matrix?
proc determinant(m: Matrix44): float = 
    result = m.matrix[0][0] * 
        (m.matrix[1][1] * m.matrix[2][2] * m.matrix[3][3] + m.matrix[1][2] * 
        m.matrix[2][3] * m.matrix[3][1] + m.matrix[1][3] * m.matrix[2][1] * 
        m.matrix[3][2] - m.matrix[1][3] * m.matrix[2][2]  * m.matrix[3][1] - 
        m.matrix[1][1] * m.matrix[2][3] * m.matrix[3][2] - m.matrix[1][2] * 
        m.matrix[2][1] * m.matrix[3][3])
    result -= m.matrix[0][1] * 
        (m.matrix[1][0] * m.matrix[2][2] * m.matrix[3][3] + m.matrix[1][2] * 
        m.matrix[2][3] * m.matrix[3][0] + m.matrix[1][3] * m.matrix[2][0] * 
        m.matrix[3][2] - m.matrix[1][3] * m.matrix[2][2]  * m.matrix[3][0] - 
        m.matrix[1][0] * m.matrix[2][3] * m.matrix[3][2] - m.matrix[1][2] * 
        m.matrix[2][0] * m.matrix[3][3])
    result += m.matrix[0][2] * 
        (m.matrix[1][0] * m.matrix[2][1] * m.matrix[3][3] + m.matrix[1][1] * 
        m.matrix[2][3] * m.matrix[3][0] + m.matrix[1][3] * m.matrix[2][0] * 
        m.matrix[3][1] - m.matrix[1][3] * m.matrix[2][1]  * m.matrix[3][0] - 
        m.matrix[1][0] * m.matrix[2][3] * m.matrix[3][1] - m.matrix[1][1] * 
        m.matrix[2][0] * m.matrix[3][3])
    result -= m.matrix[0][3] * 
        (m.matrix[1][0] * m.matrix[2][1] * m.matrix[3][2] + m.matrix[1][1] * 
        m.matrix[2][2] * m.matrix[3][0] + m.matrix[1][2] * m.matrix[2][0] * 
        m.matrix[3][1] - m.matrix[1][2] * m.matrix[2][1]  * m.matrix[3][0] - 
        m.matrix[1][0] * m.matrix[2][2] * m.matrix[3][1] - m.matrix[1][1] * 
        m.matrix[2][0] * m.matrix[3][2])
#Invert