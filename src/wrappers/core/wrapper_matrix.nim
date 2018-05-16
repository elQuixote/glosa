import ../../core/matrix

# Matrix33 Proc Wraps
proc idMatrix_33*(): Matrix33 {.cdecl, exportc, dynlib.} = IDMatrix33
proc set_33*(m: var Matrix33, n: cdouble): var Matrix33 {.cdecl, exportc, noinit, dynlib.} = set(m, n)
proc set2_33*(m: var Matrix33, m00, m01, m02, m10, m11, m12, m20, m21, m22: cdouble): var Matrix33 {.cdecl, exportc, noinit, dynlib.} = set(m, m00, m01, m02, m10, m11, m12, m20, m21, m22)
proc copy_33*(m: Matrix33): Matrix33 {.cdecl, exportc, dynlib.} = copy(m)
proc clear_33*(m: var Matrix33): var Matrix33 {.cdecl, exportc, noinit, dynlib.} = clear(m)
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


