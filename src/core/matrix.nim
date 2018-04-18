from concepts import matrix

type 
    Matrix32* = object
        m00*, m01*, m02*, m10*, m11*, m12*: float
    
    Matrix44* = object
        m00*, m01*, m02*, m03*, m10*, m11*, m12*, m13*, m20*, m21*, m22*, m23*, m30*, m31*, m32*, m33*: float

#Constructors
proc matrix32*(m00, m01, m02, m10, m11, m12 : float): Matrix32 = 
    result.m00 = m00
    result.m01 = m01
    result.m02 = m02
    result.m10 = m10
    result.m11 = m11
    result.m12 = m12

proc matrix44*(m00, m01, m02, m03, m10, m11, m12, m13, m20, m21, m22, m23, m30, m31, m32, m33): Matrix44 = 
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
    