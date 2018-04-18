from concepts import matrix

type 
    Matrix32* = object
        m00*, m01*, m02*, m10*, m11*, m12*: float
        matrix23*: array[2,array[3,string]] #NOTE: Do we want an array for matrix access?
    
    Matrix44* = object
        m00*, m01*, m02*, m03*, m10*, m11*, m12*, m13*, m20*, m21*, m22*, m23*, m30*, m31*, m32*, m33*: float
        matrix44*: array[4,array[4,string]] #NOTE: Do we want an array for matrix access?

#Constructors
proc matrix32*(m00, m01, m02, m10, m11, m12 : float): Matrix32 = 
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

    result.matrix23 = mx

proc matrix44*(m00, m01, m02, m03, m10, m11, m12, m13, m20, m21, m22, m23, m30, m31, m32, m33): Matrix44 = 
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

    result.matrix44 = mx
    