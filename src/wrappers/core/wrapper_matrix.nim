import ../../core/matrix
import ../../core/quaternion
from ../../core/vector import Vector3, Vector4

type
  Matrix33_Net* = object
    m00, m01, m02: cdouble 
    m10, m11, m12: cdouble  
    m20, m21, m22: cdouble 

  Matrix44_Net* = object
    m00, m01, m02, m03: cdouble
    m10, m11, m12, m13: cdouble
    m20, m21, m22, m23: cdouble
    m30, m31, m32, m33: cdouble

proc matrix33_Net*(m: Matrix33): Matrix33_Net = 
  result = Matrix33_Net(
    m00 : m.matrix[0][0],
    m01 : m.matrix[0][1],
    m02 : m.matrix[0][2],
    m10 : m.matrix[1][0],
    m11 : m.matrix[1][1],
    m12 : m.matrix[1][2],
    m20 : m.matrix[2][0],
    m21 : m.matrix[2][1],
    m22 : m.matrix[2][2]
  )

proc matrix44_Net*(m: Matrix44): Matrix44_Net = 
  result = Matrix44_Net(
    m00 : m.matrix[0][0],
    m01 : m.matrix[0][1],
    m02 : m.matrix[0][2],
    m03 : m.matrix[0][3],
    m10 : m.matrix[1][0],
    m11 : m.matrix[1][1],
    m12 : m.matrix[1][2],
    m13 : m.matrix[1][3],
    m20 : m.matrix[2][0],
    m21 : m.matrix[2][1],
    m22 : m.matrix[2][2],
    m23 : m.matrix[2][3],
    m30 : m.matrix[3][0],
    m31 : m.matrix[3][1],
    m32 : m.matrix[3][2],
    m33 : m.matrix[3][3]
  )

proc matrix33_Net*(m: Matrix33_Net): Matrix33 = 
  result = Matrix33(matrix:
    [[m.m00, m.m01, m.m02],
    [m.m10, m.m11, m.m12],
    [m.m20, m.m21, m.m22]]
  )

proc matrix44_Net*(m: Matrix44_Net): Matrix44 = 
  result = Matrix44(matrix:
    [[m.m00, m.m01, m.m02, m.m03],
    [m.m10, m.m11, m.m12, m.m13],
    [m.m20, m.m21, m.m22, m.m23],
    [m.m30, m.m31, m.m32, m.m33]]
  )

# ***************************************
#     Matrix33 Proc Wrappers
# ***************************************
proc idMatrix_33*(): Matrix33_Net {.cdecl, exportc, dynlib.} = matrix33_Net(IDMatrix33)
proc set_33*(m: Matrix33_Net, n: cdouble): Matrix33_Net {.cdecl, exportc, noinit, dynlib.} = 
  var x = matrix33_Net(m)
  x = set(x, n)
  result = matrix33_Net(x)
proc set2_33*(m: Matrix33_Net, 
  m00, m01, m02, 
  m10, m11, m12, 
  m20, m21, m22: cdouble
  ): Matrix33_Net {.cdecl, exportc, noinit, dynlib.} = 
    var x = matrix33_Net(m)
    x = set(x, 
    m00, m01, m02, 
    m10, m11, m12, 
    m20, m21, m22)
    result = matrix33_Net(x)
proc copy_33*(m: Matrix33_Net): Matrix33_Net {.cdecl, exportc, dynlib.} = 
  result = matrix33_Net(copy(matrix33_Net(m)))
proc clear_33*(m: Matrix33_Net): Matrix33_Net {.cdecl, exportc, noinit, dynlib.} = 
  var x = matrix33_Net(m)
  x = clear(x)
  result = matrix33_Net(x)
proc equals_33*(m1, m2: Matrix33_Net): bool {.cdecl, exportc, dynlib.} = matrix33_Net(m1) == matrix33_Net(m2)
proc hash_33*(m: Matrix33_Net): int {.cdecl, exportc, dynlib.} = hash(matrix33_Net(m))
proc stringify_33*(m: Matrix33_Net): cstring {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  result = $matrix33_Net(m)
  tearDownForeignThreadGc()
proc transposeSelf_33*(m: Matrix33_Net): Matrix33_Net {.cdecl, exportc, noinit, dynlib.} = 
  var x = matrix33_Net(m)
  x = transposeSelf(x)
  result = matrix33_Net(x)
proc transposeNew_33*(m: Matrix33_Net): Matrix33_Net {.cdecl, exportc, dynlib.} = 
  result = matrix33_Net(transpose(matrix33_Net(m)))
proc determinant_33*(m: Matrix33_Net): cdouble {.cdecl, exportc, dynlib.} = determinant(matrix33_Net(m))
proc invertSelf_33*(m: Matrix33_Net): Matrix33_Net {.cdecl, exportc, noinit, dynlib.} = 
  var x = matrix33_Net(m)
  x = invertSelf(x)
  result = matrix33_Net(x)
proc invertNew_33*(m: Matrix33_Net): Matrix33_Net {.cdecl, exportc, dynlib.} = 
  result = matrix33_Net(invertNew(matrix33_Net(m)))
proc rotateMatrix_33*(theta: cdouble): Matrix33_Net {.cdecl, exportc, dynlib.} = matrix33_Net(rotate33(theta))
proc scaleMatrix_33*(s: cdouble): Matrix33_Net {.cdecl, exportc, dynlib.} = matrix33_Net(scale33(s))
proc scaleMatrix2_33*(sx, sy: cdouble): Matrix33_Net {.cdecl, exportc, dynlib.} = matrix33_Net(scale(sx, sy))
proc shearMatrixX_33*(sx: cdouble): Matrix33_Net {.cdecl, exportc, dynlib.} = matrix33_Net(shearX33(sx))
proc shearMatrixY_33*(sy: cdouble): Matrix33_Net {.cdecl, exportc, dynlib.} = matrix33_Net(shearY33(sy))
proc fromVector3(v1, v2, v3: Vector3): Matrix33_Net {.cdecl, exportc, dynlib.} = matrix33_Net(matrix33(v1, v2, v3))
proc toArray_33*(m: Matrix33_Net, a: var array[3, array[3, cdouble]]): void {.cdecl, exportc, dynlib.} =
  a = matrix33_Net(m).matrix

# ***************************************
#     Matrix44 Proc Wrappers
# ***************************************
proc idMatrix_44*(): Matrix44_Net {.cdecl, exportc, dynlib.} = matrix44_Net(IDMatrix44)
proc set_44*(m: Matrix44_Net, n: cdouble): Matrix44_Net {.cdecl, exportc, noinit, dynlib.} = 
  var x = matrix44_Net(m)
  x = set(x, n)
  result = matrix44_Net(x)
proc set2_44*(m: Matrix44_Net, 
  m00, m01, m02, m03, 
  m10, m11, m12, m13, 
  m20, m21, m22, m23, 
  m30, m31, m32, m33: cdouble
  ): Matrix44_Net {.cdecl, exportc, noinit, dynlib.} = 
    var x = matrix44_Net(m)
    x = set(x, 
    m00, m01, m02, m03, 
    m10, m11, m12, m13, 
    m20, m21, m22, m23, 
    m30, m31, m32, m33)
    result = matrix44_Net(x)
proc copy_44*(m: Matrix44_Net): Matrix44_Net {.cdecl, exportc, dynlib.} = 
  result = matrix44_Net(copy(matrix44_Net(m)))
proc clear_44*(m: Matrix44_Net): Matrix44_Net {.cdecl, exportc, noinit, dynlib.} = 
  var x = matrix44_Net(m)
  x = clear(x)
  result = matrix44_Net(x)
proc equals_44*(m1, m2: Matrix44_Net): bool {.cdecl, exportc, dynlib.} = matrix44_Net(m1) == matrix44_Net(m2)
proc hash_44*(m: Matrix44_Net): int {.cdecl, exportc, dynlib.} = hash(matrix44_Net(m))
proc stringify_44*(m: Matrix44_Net): cstring {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  result = $matrix44_Net(m)
  tearDownForeignThreadGc()
proc transposeSelf_44*(m: Matrix44_Net): Matrix44_Net {.cdecl, exportc, noinit, dynlib.} = 
  var x = matrix44_Net(m)
  x = transposeSelf(x)
  result = matrix44_Net(x)
proc transposeNew_44*(m: Matrix44_Net): Matrix44_Net {.cdecl, exportc, dynlib.} = 
  result = matrix44_Net(transpose(matrix44_Net(m)))
proc determinant_44*(m: Matrix44_Net): cdouble {.cdecl, exportc, dynlib.} = determinant(matrix44_Net(m))
proc invertSelf_44*(m: Matrix44_Net): Matrix44_Net {.cdecl, exportc, noinit, dynlib.} = 
  var x = matrix44_Net(m)
  x = invertSelf(x)
  result = matrix44_Net(x)
proc invertNew_44*(m: Matrix44_Net): Matrix44_Net {.cdecl, exportc, dynlib.} = 
  result = matrix44_Net(invertNew(matrix44_Net(m)))
proc fromQuaternion_44*(q: Quaternion): Matrix44_Net {.cdecl, exportc, dynlib.} = matrix44_Net(fromQuaternion(q))
proc rotateMatrixX_44*(theta: cdouble): Matrix44_Net {.cdecl, exportc, dynlib.} = matrix44_Net(rotateX44(theta))
proc rotateMatrixY_44*(theta: cdouble): Matrix44_Net {.cdecl, exportc, dynlib.} = matrix44_Net(rotateY44(theta))
proc rotateMatrixZ_44*(theta: cdouble): Matrix44_Net {.cdecl, exportc, dynlib.} = matrix44_Net(rotateZ44(theta))
proc scaleMatrix_44*(s: cdouble): Matrix44_Net {.cdecl, exportc, dynlib.} = matrix44_Net(scale44(s))
proc scaleMatrix2_44*(sx, sy, sz: cdouble): Matrix44_Net {.cdecl, exportc, dynlib.} = matrix44_Net(scale(sx, sy, sz))
proc shearMatrixX_44*(sy, sz: cdouble): Matrix44_Net {.cdecl, exportc, dynlib.} = matrix44_Net(shearX44(sy, sz))
proc shearMatrixY_44*(sx, sz: cdouble): Matrix44_Net {.cdecl, exportc, dynlib.} = matrix44_Net(shearY44(sx, sz))
proc shearMatrixZ_44*(sx, sy: cdouble): Matrix44_Net {.cdecl, exportc, dynlib.} = matrix44_Net(shearZ44(sx, sy))
proc shearUniformMatrix_X_44*(sh: cdouble): Matrix44_Net {.cdecl, exportc, dynlib.} = matrix44_Net(shearX44(sh))
proc shearUniformMatrix_Y_44*(sh: cdouble): Matrix44_Net {.cdecl, exportc, dynlib.} = matrix44_Net(shearY44(sh))
proc shearUniformMatrix_Z_44*(sh: cdouble): Matrix44_Net {.cdecl, exportc, dynlib.} = matrix44_Net(shearZ44(sh))
proc fromVector4(v1, v2, v3, v4: Vector4): Matrix44_Net {.cdecl, exportc, dynlib.} = matrix44_Net(matrix44(v1, v2, v3, v4))
proc toArray_44*(m: Matrix44_Net, a: var array[4, array[4, cdouble]]): void {.cdecl, exportc, dynlib.} =
  a = matrix44_Net(m).matrix