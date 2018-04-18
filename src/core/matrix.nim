from concepts import matrix

type 
    Matrix32* = object
        m00*, m01*, m02*, m10*, m11*, m12*: float
    
    Matrix44* = object
        m00*, m01*, m02*, m03*, m10*, m11*, m12*, m13*, m20*, m21*, m22*, m23*, m30*, m31*, m32*, m33*: float