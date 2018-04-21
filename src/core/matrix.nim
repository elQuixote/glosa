import ./concepts

from strformat import `&`
from math import arctan2, arccos, sqrt, sin, cos

import hashes

type 
    Matrix32* = object
        matrix*: array[2,array[3,float]] #NOTE: Do we want an array for matrix access?
    
    Matrix44* = object
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
    result.matrix = mx

proc matrix44*(
    m00, m01, m02, m03, 
    m10, m11, m12, m13, 
    m20, m21, m22, m23, 
    m30, m31, m32, m33 : float
    ): Matrix44 = 
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
    result.matrix = mx

#Identity
#NOTE : This is Added, not in design doc
let 
    IDMATRIX32*: Matrix32 = matrix32(
        1.0,0.0, 
        0.0,0.0, 
        1.0,0.0)
    IDMATRIX44*: Matrix44 = matrix44(      
        1.0,0.0,0.0,0.0,
        0.0,1.0,0.0,0.0,
        0.0,0.0,1.0,0.0,
        0.0,0.0,0.0,1.0)

#Accessors 
#NOTE : This is Added, not in design doc
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

#Set
#NOTE : This is Added, not in design doc
proc set*(m: var Matrix32, n: float): var Matrix32 {.noinit.} =
    m.matrix[0][0] = n
    m.matrix[0][1] = n
    m.matrix[0][2] = n
    m.matrix[1][0] = n
    m.matrix[1][1] = n
    m.matrix[1][2] = n
    result = m

proc set*(m: var Matrix44, n: float): var Matrix44 {.noinit.} =
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
    m.matrix[0][0] = a
    m.matrix[0][1] = b
    m.matrix[0][2] = c
    m.matrix[1][0] = d
    m.matrix[1][1] = e
    m.matrix[1][2] = f
    result = m

proc set*(m: var Matrix44, a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p: float): var Matrix44 {.noinit.} =
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
    result = Matrix32(matrix: m.matrix)
  
proc copy*(m: Matrix44): Matrix44 =
    result = Matrix44(matrix: m.matrix)

#Clear
template clear*(m: var Matrix32): var Matrix32 = set(m, 0.0)
template clear*(m: var Matrix44): var Matrix44 = set(m, 0.0)

#Equals
proc `==`*(m1, m2: Matrix32): bool = 
    result = m1.matrix[0][0] == m2.matrix[0][0] and m1.matrix[0][1] == m2.matrix[0][1] and m1.matrix[0][2] == m2.matrix[0][2] and m1
        m1.matrix[1][0] == m2.matrix[1][0] and m1.matrix[1][1] == m2.matrix[1][1] and m1.matrix[1][2] == m2.matrix[1][2]  
proc `==`*(m1, m2: Matrix44): bool =
    result = m1.matrix[0][0] == m2.matrix[0][0] and m1.matrix[0][1] == m2.matrix[0][1] and m1.matrix[0][2] == m2.matrix[0][2] and m1.matrix[0][3] == m2.matrix[0][3] and
        m1.matrix[1][0] == m2.matrix[1][0] and m1.matrix[1][1] == m2.matrix[1][1] and m1.matrix[1][2] == m2.matrix[1][2] and m1.matrix[1][3] == m2.matrix[1][3] and
        m1.matrix[2][0] == m2.matrix[2][0] and m1.matrix[2][1] == m2.matrix[2][1] and m1.matrix[2][2] == m2.matrix[2][2] and m1.matrix[2][3] == m2.matrix[2][2] and
        m1.matrix[3][0] == m3.matrix[3][0] and m1.matrix[3][1] == m2.matrix[3][1] and m1.matrix[3][2] == m2.matrix[3][2] and m1.matrix[3][3] == m2.matrix[3][3]  

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
proc determinants*(m: Matrix44): float = 
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
#Note calculate the determinant of a non square matrix?
proc determinant*(m: Matrix32): float =
    return m.matrix[0][0]*m.matrix[1][1]-m.matrix[1][0]*m.matrix[0][1]

proc determinant*(m: Matrix44): float =
    let
        O1 = m.matrix[2][0]*m.matrix[3][3]-m.matrix[2][3]*m.matrix[3][0]
        O2 = m.matrix[2][1]*m.matrix[3][3]-m.matrix[2][3]*m.matrix[3][1]
        O3 = m.matrix[2][0]*m.matrix[3][1]-m.matrix[2][1]*m.matrix[3][0]
        O4 = m.matrix[2][2]*m.matrix[3][3]-m.matrix[2][3]*m.matrix[3][2]
        O5 = m.matrix[2][0]*m.matrix[3][2]-m.matrix[2][2]*m.matrix[3][0]
        O6 = m.matrix[2][2]*m.matrix[3][2]-m.matrix[2][2]*m.matrix[3][1]
    
    return (O1*m.matrix[0][1]-O2*m.matrix[0][0]-O3*m.matrix[0][3])*m.matrix[1][2]+
        (-O1*m.matrix[0][2]+O4*m.matrix[0][0]+O5*m.matrix[0][3])*m.matrix[1][1]+
        (O2*m.matrix[0][2]-O4*m.matrix[0][1]-O6*m.aw)*m.matrix[1][0]+
        (O3*m.matrix[0][2]-O5*m.matrix[0][1]+O6*m.matrix[0][0])*m.matrix[1][3]

#Invert
proc invert*(m: Matrix32): Matrix32 {.noInit.} =
    let d = m.determinant
    if d == 0.0:
        raise newException(DivByZeroError,"Cannot invert a zero determinant matrix")
    result.set(
        m.matrix[1][1]/d,-m.matrix[0][1]/d,
        -m.matrix[1][0]/d,m.matrix[0][0]/d,
        (m.matrix[1][0]*m.matrix[2][1]-m.matrix[1][1]*m.matrix[2][0])/d,
        (m.matrix[0][1]*m.matrix[2][0]-m.matrix[0][0]*m.matrix[2][1])/d)

proc invert*(m: Matrix44): Matrix44 {.noInit.} =
    let
        det = m.determinant
        O2 = m.matrix[2][1]*m.matrix[3][3]-m.matrix[2][3]*m.matrix[3][1]
        O3 = m.matrix[2][2]*m.matrix[3][3]-m.matrix[2][3]*m.matrix[3][2]
        O4 = m.matrix[2][1]*m.matrix[3][2]-m.matrix[2][2]*m.matrix[3][1]
        O5 = m.matrix[1][1]*m.matrix[3][3]-m.matrix[1][3]*m.matrix[3][1]
        O6 = m.matrix[1][2]*m.matrix[3][3]-m.matrix[1][3]*m.matrix[3][2]
        O7 = m.matrix[1][1]*m.matrix[3][2]-m.matrix[1][2]*m.matrix[3][1]
        O8 = m.matrix[1][1]*m.matrix[2][3]-m.matrix[1][3]*m.matrix[2][1]
        O9 = m.matrix[1][2]*m.matrix[2][3]-m.matrix[1][3]*m.matrix[2][2]
        O10 = m.matrix[1][1]*m.matrix[2][2]-m.matrix[1][2]*m.matrix[2][1]
        O11 = m.matrix[2][0]*m.matrix[3][3]-m.matrix[2][3]*m.matrix[3][0]
        O12 = m.matrix[2][0]*m.matrix[3][2]-m.matrix[2][2]*m.matrix[3][0]
        O13 = m.matrix[1][0]*m.matrix[3][3]-m.matrix[1][3]*m.matrix[3][0]
        O14 = m.matrix[1][0]*m.matrix[3][2]-m.matrix[1][2]*m.matrix[3][0]
        O15 = m.matrix[1][0]*m.matrix[2][3]-m.matrix[1][3]*m.matrix[2][0]
        O16 = m.matrix[1][0]*m.matrix[2][2]-m.matrix[1][2]*m.matrix[2][0]
        O17 = m.matrix[2][0]*m.matrix[3][1]-m.matrix[2][1]*m.matrix[3][0]
        O18 = m.matrix[1][0]*m.matrix[3][1]-m.matrix[1][1]*m.matrix[3][0]
        O19 = m.matrix[1][0]*m.matrix[2][1]-m.matrix[1][1]*m.matrix[2][0]
    if det == 0.0:
        raise newException(DivByZeroError,"Cannot normalize zero length vector") 
    result.set(
        (m.matrix[1][3]*O4+m.matrix[1][1]*O3-m.matrix[1][2]*O2)/det    , (-m.matrix[0][3]*O4-m.matrix[0][1]*O3+m.matrix[0][2]*O2)/det,
        (m.matrix[0][3]*O7+m.matrix[0][1]*O6-m.matrix[0][2]*O5)/det    , (-m.matrix[0][3]*O10-m.matrix[0][1]*O9+m.matrix[0][2]*O8)/det,
        (-m.matrix[1][3]*O12-m.matrix[1][0]*O3+m.matrix[1][2]*O11)/det , (m.matrix[0][3]*O12+m.matrix[0][0]*O3-m.matrix[0][2]*O11)/det,
        (-m.matrix[0][3]*O14-m.matrix[0][0]*O6+m.matrix[0][2]*O13)/det , (m.matrix[0][3]*O16+m.matrix[0][0]*O9-m.matrix[0][2]*O15)/det,
        (m.matrix[1][3]*O17+m.matrix[1][0]*O2-m.matrix[1][1]*O11)/det  , (-m.matrix[0][3]*O17-m.matrix[0][0]*O2+m.matrix[0][1]*O11)/det,
        (m.matrix[0][3]*O18+m.matrix[0][0]*O5-m.matrix[0][1]*O13)/det  , (-m.matrix[0][3]*O19-m.matrix[0][0]*O8+m.matrix[0][1]*O15)/det,
        (-m.matrix[1][0]*O4+m.matrix[1][1]*O12-m.matrix[1][2]*O17)/det , (m.matrix[0][0]*O4-m.matrix[0][1]*O12+m.matrix[0][2]*O17)/det,
        (-m.matrix[0][0]*O7+m.matrix[0][1]*O14-m.matrix[0][2]*O18)/det , (m.matrix[0][0]*O10-m.matrix[0][1]*O16+m.matrix[0][2]*O19)/det)

#Module Level Procs (Constructors)
#Rotation 
proc rotate32*(radians: float): Matrix32 {.noinit.} =
    let  
        s = sin(radians)
        c = cos(radians)
    result.set(c,s,-s,c,0,0)

proc rotate44X*(angle: float): Matrix44 {.noinit.} = 
    let 
        c = cos(angle)
        s = sin(angle)
    result.set(
        1,0,0,0,
        0,c,s,0,
        0,-s,c,0,
        0,0,0,1)

proc rotate44Y*(angle: float): Matrix44 {.noinit.} = 
    let 
        c = cos(angle)
        s = sin(angle)
    result.set(
        c,0,-s,0,
        0,1,0,0,
        s,0,c,0,
        0,0,0,1)

proc rotate44Z*(angle: float): Matrix44 {.noinit.} = 
    let 
        c = cos(angle)
        s = sin(angle)
    result.set(
        c,s,0,0,
        -s,c,0,0,
        0,0,1,0,
        0,0,0,1)

#Scale
proc scale32*(s: float): Matrix32 {.noinit} = 
    result.set(s,0,0,s,0,0)

proc scale44*(s: float): Matrix44 {.noinit} = 
    result.set(s,0,0,0, 0,s,0,0, 0,0,s,0, 0,0,0,1)

#Shear
proc shear32X(sh: float): Matrix32 {.noinit.} = 
    result.set(1,0,sh,1,0,0)

proc shear32Y(sh: float): Matrix32 {.noinit} = 
    result.set(1,sh,0,1,0,0)

#NOTE : Not sure about shear32Z 
#NOTE : Shear Operations for Matrix44 incomplete
proc shear44X(sh: float): Matrix44 {.noinit} =
    result.set(1,sh,sh,0, 0,1,0,0, 0,0,1,0, 0,0,0,1)

proc shear44Y(sh: float): Matrix44 {.noinit} =
    result.set(1,0,0,0, sh,1,sh,0, 0,0,1,0, 0,0,0,1)

proc shear44Z(sh: float): Matrix44 {.noinit} =
    result.set(1,0,0,0, 0,1,0,0, sh,sh,1,0, 0,0,0,1)
