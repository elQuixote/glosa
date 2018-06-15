from ../../core/matrix import Matrix44
import ../../core/quaternion
from ../../core/vector import Vector3
from ./wrapper_matrix import matrix44_Net, Matrix44_Net

# ***************************************
#     Quaternion Proc Wrappers
# ***************************************
proc copy_quat*(q: Quaternion): Quaternion {.cdecl, exportc, dynlib.} = copy(q)
proc set_quat*(q: var Quaternion, n: cdouble): Quaternion {.cdecl, exportc, noinit, dynlib.} = set(q, n)
proc clear_quat*(q: var Quaternion): Quaternion {.cdecl, exportc, noinit, dynlib.} = clear(q)
proc inverseNew_quat*(q: Quaternion): Quaternion {.cdecl, exportc, dynlib.} = inverseNew(q)
proc inverseSelf_quat*(q: var Quaternion): Quaternion {.cdecl, exportc, noinit, dynlib.} = inverseSelf(q)
proc invertNew_quat*(q: Quaternion): Quaternion {.cdecl, exportc, dynlib.} = invertNew(q)
proc invertSelf_quat*(q: var Quaternion): Quaternion {.cdecl, exportc, noinit, dynlib.} = invertSelf(q)
proc equals_quat*(q1, q2: Quaternion): bool {.cdecl, exportc, dynlib.} = q1 == q2
proc hash_quat*(q: Quaternion): int {.cdecl, exportc, dynlib.} = hash(q)
proc stringify_quat*(q: Quaternion): cstring {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  result = $q
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()
proc magnitudeSquared_quat*(q: Quaternion): cdouble {.cdecl, exportc, dynlib.} = length(q)
proc length_quat*(q: Quaternion): cdouble {.cdecl, exportc, dynlib.} = length(q)
proc addNew_quat*(q1, q2: Quaternion): Quaternion {.cdecl, exportc, dynlib.} = addNew(q1, q2)
proc addNew2_quat*(q: Quaternion, f: cdouble): Quaternion {.cdecl, exportc, dynlib.} = addNew(q, f)
proc addSelf_quat*(q1: var Quaternion, q2: Quaternion): Quaternion {.cdecl, exportc, noinit, dynlib.} = addSelf(q1, q2)
proc addSelf2_quat*(q: var Quaternion, f: cdouble): Quaternion {.cdecl, exportc, noinit, dynlib.} = addSelf(q, f)
proc subtractNew_quat*(q1, q2: Quaternion): Quaternion {.cdecl, exportc, dynlib.} = subtractNew(q1, q2)
proc subtractNew2_quat*(q: Quaternion, f: cdouble): Quaternion {.cdecl, exportc, dynlib.} = subtractNew(q, f)
proc subtractSelf_quat*(q1: var Quaternion, q2: Quaternion): Quaternion {.cdecl, exportc, noinit, dynlib.} = subtractSelf(q1, q2)
proc subtractSelf2_quat*(q: var Quaternion, f: cdouble): Quaternion {.cdecl, exportc, noinit, dynlib.} = subtractSelf(q, f)
proc divideNew_quat*(q1, q2: Quaternion): Quaternion {.cdecl, exportc, dynlib.} = divideNew(q1, q2)
proc divideNew2_quat*(q: Quaternion, f: cdouble): Quaternion {.cdecl, exportc, dynlib.} = divideNew(q, f)
proc divideSelf_quat*(q1: var Quaternion, q2: Quaternion): Quaternion {.cdecl, exportc, noinit, dynlib.} = divideSelf(q1, q2)
proc divideSelf2_quat*(q: var Quaternion, f: cdouble): Quaternion {.cdecl, exportc, noinit, dynlib.} = divideSelf(q, f)
proc multiplyNew_quat*(q1, q2: Quaternion): Quaternion {.cdecl, exportc, dynlib.} = multiplyNew(q1, q2)
proc multiplyNew2_quat*(q: Quaternion, f: cdouble): Quaternion {.cdecl, exportc, dynlib.} = multiplyNew(q, f)
proc mulitplySelf_quat*(q1: var Quaternion, q2: Quaternion): Quaternion {.cdecl, exportc, noinit, dynlib.} = multiplySelf(q1, q2)
proc mulitplySelf2_quat*(q: var Quaternion, f: cdouble): Quaternion {.cdecl, exportc, noinit, dynlib.} = multiplySelf(q, f)
proc normalizeNew_quat*(q: Quaternion, m: cdouble = 1.0): Quaternion {.cdecl, exportc, dynlib.} = normalizeNew(q, m)
proc normalizeSelf_quat*(q: var Quaternion, m: cdouble = 1.0): Quaternion {.cdecl, exportc, noinit, dynlib.} = normalizeSelf(q, m)
proc dot_quat*(q1, q2: Quaternion): cdouble {.cdecl, exportc, dynlib.} = dot(q1, q2)
proc conjugateSelf_quat*(q: var Quaternion): Quaternion {.cdecl, exportc, noinit, dynlib.} = conjugate(q)
proc conjugateNew_quat*(q: Quaternion): Quaternion {.cdecl, exportc, noinit, dynlib.} = conjugate(q)
proc fromMatrix_quat*(m: Matrix44_Net): Quaternion {.cdecl, exportc, noinit, dynlib.} = 
  fromMatrix(matrix44_Net(m))
proc fromAxisAngle_quat*(v: Vector3, a: float): Quaternion {.cdecl, exportc, noinit, dynlib.} = fromAxisAngle(v, a)
proc toArray_quat*(q: Quaternion, a: var array[4, cdouble]): void {.cdecl, exportc, dynlib.} =
  a[0] = q.x
  a[1] = q.y
  a[2] = q.z
  a[3] = q.w
proc fromVector3_quat*(w: cdouble, v: Vector3): Quaternion {.cdecl, exportc, dynlib.} = quaternion(w, v)