import ../../core/matrix
import ../../core/quaternion
from ../../core/vector import Vector3, Vector4

type
  Matrix33_Net* = object
    m00, m01, m02: cdouble 
    m10, m11, m12: cdouble  
    m20, m21, m22: cdouble 

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

proc matrix33_Net*(m: Matrix33_Net): Matrix33 = 
  result = Matrix33(matrix:
    [[m.m00, 
    m.m01,
    m.m02],
    [m.m10,
    m.m11,
    m.m12],
    [m.m20,
    m.m21,
    m.m22]]
  )

# Matrix33 Proc Wraps
proc idMatrix_33*(): Matrix33 {.cdecl, exportc, dynlib.} = IDMatrix33
proc set_33*(m: var Matrix33, n: cdouble): var Matrix33 {.cdecl, exportc, noinit, dynlib.} = set(m, n)
proc set2_33*(m: var Matrix33, 
  m00, m01, m02, 
  m10, m11, m12, 
  m20, m21, m22: cdouble
  ): var Matrix33 {.cdecl, exportc, noinit, dynlib.} = set(m, 
    m00, m01, m02, 
    m10, m11, m12, 
    m20, m21, m22)
proc copy_33*(m: Matrix33): Matrix33 {.cdecl, exportc, dynlib.} = copy(m)
proc clear_33*(m: Matrix33_Net): Matrix33_Net {.cdecl, exportc, noinit, dynlib.} = 
  var x = matrix33_Net(m)
  x = clear(x)
  result = matrix33_Net(x)
proc equals_33*(m1, m2: Matrix33): bool {.cdecl, exportc, dynlib.} = m1 == m2
proc hash_33*(m: Matrix33): int {.cdecl, exportc, dynlib.} = hash(m)
proc stringify_33*(m: Matrix33): cstring {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  $m
proc transposeSelf_33*(m: var Matrix33): var Matrix33 {.cdecl, exportc, noinit, dynlib.} = transposeSelf(m)
proc transposeNew_33*(m: Matrix33): Matrix33 {.cdecl, exportc, dynlib.} = transpose(m)
proc determinant_33*(m: Matrix33): cdouble {.cdecl, exportc, dynlib.} = determinant(m)
proc invertSelf_33*(m: var Matrix33): var Matrix33 {.cdecl, exportc, noinit, dynlib.} = invertSelf(m)
proc invertNew_33*(m: Matrix33): Matrix33 {.cdecl, exportc, dynlib.} = invertNew(m)
proc rotate_33*(theta: cdouble): Matrix33 {.cdecl, exportc, dynlib.} = rotate33(theta)
proc scale_33*(s: cdouble): Matrix33 {.cdecl, exportc, dynlib.} = scale33(s)
proc scale2_33*(sx, sy: cdouble): Matrix33 {.cdecl, exportc, dynlib.} = scale(sx, sy)
proc shearX_33*(sx: cdouble): Matrix33 {.cdecl, exportc, dynlib.} = shearX33(sx)
proc shearY_33*(sy: cdouble): Matrix33 {.cdecl, exportc, dynlib.} = shearY33(sy)
proc fromVector3(v1, v2, v3: Vector3): Matrix33 {.cdecl, exportc, dynlib.} = matrix33(v1, v2, v3)

# Matrix44 Proc Wraps
proc idMatrix_44*(): Matrix44 {.cdecl, exportc, dynlib.} = IDMatrix44
proc set_44*(m: var Matrix44, n: cdouble): var Matrix44 {.cdecl, exportc, noinit, dynlib.} = set(m, n)
proc set2_44*(m: var Matrix44, 
  m00, m01, m02, m03, 
  m10, m11, m12, m13, 
  m20, m21, m22, m23, 
  m30, m31, m32, m33: cdouble
  ): var Matrix44 {.cdecl, exportc, noinit, dynlib.} = set(m, 
    m00, m01, m02, m03, 
    m10, m11, m12, m13, 
    m20, m21, m22, m23, 
    m30, m31, m32, m33)
proc copy_44*(m: Matrix44): Matrix44 {.cdecl, exportc, dynlib.} = copy(m)
proc clear_44*(m: var Matrix44): var Matrix44 {.cdecl, exportc, noinit, dynlib.} = clear(m)
proc equals_44*(m1, m2: Matrix44): bool {.cdecl, exportc, dynlib.} = m1 == m2
proc hash_44*(m: Matrix44): int {.cdecl, exportc, dynlib.} = hash(m)
proc stringify_44*(m: Matrix44): cstring {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  $m
proc transposeSelf_44*(m: var Matrix44): var Matrix44 {.cdecl, exportc, noinit, dynlib.} = transposeSelf(m)
proc transposeNew_44*(m: Matrix44): Matrix44 {.cdecl, exportc, dynlib.} = transpose(m)
proc determinant_44*(m: Matrix44): cdouble {.cdecl, exportc, dynlib.} = determinant(m)
proc invertSelf_44*(m: var Matrix44): var Matrix44 {.cdecl, exportc, noinit, dynlib.} = invertSelf(m)
proc invertNew_44*(m: Matrix44): Matrix44 {.cdecl, exportc, dynlib.} = invertNew(m)
proc fromQuaternion_44*(q: Quaternion): Matrix44 {.cdecl, exportc, dynlib.} = fromQuaternion(q)
proc rotateX_44*(theta: cdouble): Matrix44 {.cdecl, exportc, dynlib.} = rotateX44(theta)
proc rotateY_44*(theta: cdouble): Matrix44 {.cdecl, exportc, dynlib.} = rotateY44(theta)
proc rotateZ_44*(theta: cdouble): Matrix44 {.cdecl, exportc, dynlib.} = rotateZ44(theta)
proc scale_44*(s: cdouble): Matrix44 {.cdecl, exportc, dynlib.} = scale44(s)
proc scale2_44*(sx, sy, sz: cdouble): Matrix44 {.cdecl, exportc, dynlib.} = scale(sx, sy, sz)
proc shearX_44*(sy, sz: cdouble): Matrix44 {.cdecl, exportc, dynlib.} = shearX44(sy, sz)
proc shearY_44*(sx, sz: cdouble): Matrix44 {.cdecl, exportc, dynlib.} = shearY44(sx, sz)
proc shearZ_44*(sx, sy: cdouble): Matrix44 {.cdecl, exportc, dynlib.} = shearZ44(sx, sy)
proc shearUniform_X_44*(sh: cdouble): Matrix44 {.cdecl, exportc, dynlib.} = shearX44(sh)
proc shearUniform_Y_44*(sh: cdouble): Matrix44 {.cdecl, exportc, dynlib.} = shearY44(sh)
proc shearUniform_Z_44*(sh: cdouble): Matrix44 {.cdecl, exportc, dynlib.} = shearZ44(sh)
proc fromVector4(v1, v2, v3, v4: Vector4): Matrix44 {.cdecl, exportc, dynlib.} = matrix44(v1, v2, v3, v4)
