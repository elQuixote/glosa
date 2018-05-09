import ../../src/core/vector

# Vector2 Proc Wraps
proc copy_v2*(v1: Vector2): Vector2 {.cdecl, exportc, dynlib.} = copy(v1)
proc set_v2*(v: var Vector2, n: cdouble): Vector2 {.cdecl, exportc, noinit, dynlib.} = set(v, n)
proc set2_v2*(v: var Vector2, x, y: cdouble): Vector2 {.cdecl, exportc, noinit, dynlib.} = set(v, x, y)
proc clear_v2*(v: var Vector2): Vector2 {.cdecl, exportc, dynlib.} = set(v, 0.0)
proc addNew_v2*(v1, v2: Vector2): Vector2 {.cdecl, exportc, dynlib.} = addNew(v1, v2)
proc addSelf_v2*(v1: var Vector2, v2: Vector2): Vector2 {.cdecl, exportc, noinit, dynlib.} = addSelf(v1, v2)
proc subtractNew_v2*(v1, v2: Vector2): Vector2 {.cdecl, exportc, dynlib.} = subtractNew(v1, v2)
proc subtractSelf_v2*(v1: var Vector2, v2: Vector2): Vector2 {.cdecl, exportc, noinit, dynlib.} = subtractSelf(v1, v2)
proc divideNew_v2*(v: Vector2, f: cdouble): Vector2 {.cdecl, exportc, dynlib.} = divideNew(v, f)
proc divideSelf_v2*(v: var Vector2, f: cdouble): Vector2 {.cdecl, exportc, noinit, dynlib.} = divideSelf(v, f)
proc multiplyNew_v2*(v: Vector2, f: cdouble): Vector2 {.cdecl, exportc, dynlib.} = multiplyNew(v, f)
proc mulitplySelf_v2*(v: var Vector2, f: cdouble): Vector2 {.cdecl, exportc, noinit, dynlib.} = multiplySelf(v, f)
proc dot_v2*(v1, v2: Vector2): cdouble {.cdecl, exportc, dynlib.} = dot(v1, v2)
proc cross_v2*(v1, v2: Vector2): cdouble {.cdecl, exportc, dynlib.} = cross(v1, v2)
proc inverseNew_v2*(v: Vector2): Vector2 {.cdecl, exportc, dynlib.} = inverseNew(v)
proc inverseSelf_v2*(v: var Vector2): Vector2 {.cdecl, exportc, noinit, dynlib.} = inverseSelf(v)
proc heading_v2*(v: Vector2): cdouble {.cdecl, exportc, dynlib.} = headingXY(v)
proc reflectNew_v2*(v1, v2: Vector2): Vector2 {.cdecl, exportc, dynlib.} = reflectNew(v1, v2)
proc reflectSelf_v2*(v1: var Vector2, v2: Vector2): Vector2 {.cdecl, exportc, noinit, dynlib.} = reflectSelf(v1, v2)
proc refractNew_v2*(v: Vector2, n: Vector2, eta: float): Vector2 {.cdecl, exportc, dynlib.} = refractNew(v, n, eta)
proc refractSelf_v2*(v: var Vector2, n: Vector2, eta: float): Vector2 {.cdecl, exportc, noinit, dynlib.} = refractSelf(v, n, eta)
proc normalizeNew_v2*(v: Vector2, m: cdouble = 1.0): Vector2 {.cdecl, exportc, dynlib.} = normalizeNew(v, m)
proc normalizeSelf_v2*(v: var Vector2, m: cdouble = 1.0): Vector2 {.cdecl, exportc, noinit, dynlib.} = normalizeSelf(v, m)
proc angleBetween_v2*(v1, v2: Vector2): cdouble {.cdecl, exportc, dynlib.} = angleBetween(v1,v2)
proc dimension_v2*(v: Vector2): int {.cdecl, exportc, dynlib.} = dimension(v)
proc magnitude_v2*(v: Vector2): cdouble {.cdecl, exportc, dynlib.} = length(v)
proc greaterThan_v2*(v1, v2: Vector2): bool {.cdecl, exportc, dynlib.} = v1 > v2
proc greaterThanEqual_v2*(v1, v2: Vector2): bool {.cdecl, exportc, dynlib.} = v1 >= v2
proc lessThan_v2*(v1, v2: Vector2): bool {.cdecl, exportc, dynlib.} = v1 < v2
proc lessThanEqual_v2*(v1, v2: Vector2): bool {.cdecl, exportc, dynlib.} = v1 <= v2
proc equals_v2*(v1, v2: Vector2): bool {.cdecl, exportc, dynlib.} = v1 == v2
proc notEqual_v2*(v1, v2: Vector2): bool {.cdecl, exportc, dynlib.} = v1 != v2
proc hash_v2*(v: Vector2): int {.cdecl, exportc, dynlib.} = hash(v)
proc toArray_v2*(v: Vector2, a: var array[2, cdouble]): void {.cdecl, exportc, dynlib.} = 
    let a2 = toArray(v)
    a[0] = a2[0]
    a[1] = a2[1]
proc compareTo_v2*(v1, v2: Vector2): int {.cdecl, exportc, dynlib.} = compareTo(v1, v2)
proc stringify_v2*(v: Vector2): cstring {.cdecl, exportc, dynlib.} =
    setupForeignThreadGc() 
    $v

# Vector3 Proc Wraps
proc copy_v3*(v1: Vector3): Vector3 {.cdecl, exportc, dynlib.} = copy(v1)
proc set_v3*(v: var Vector3, n: cdouble): Vector3 {.cdecl, exportc, noinit, dynlib.} = set(v, n)
proc set2_v3*(v: var Vector3, x, y, z: cdouble): Vector3 {.cdecl, exportc, noinit, dynlib.} = set(v, x, y, z)
proc clear_v3*(v: var Vector3): Vector3 {.cdecl, exportc, dynlib.} = set(v, 0.0)
proc addNew_v3*(v1, v2: Vector3): Vector3 {.cdecl, exportc, dynlib.} = addNew(v1, v2)
proc addSelf_v3*(v1: var Vector3, v2: Vector3): Vector3 {.cdecl, exportc, noinit, dynlib.} = addSelf(v1, v2)
proc subtractNew_v3*(v1, v2: Vector3): Vector3 {.cdecl, exportc, dynlib.} = subtractNew(v1, v2)
proc subtractSelf_v3*(v1: var Vector3, v2: Vector3): Vector3 {.cdecl, exportc, noinit, dynlib.} = subtractSelf(v1, v2)
proc divideNew_v3*(v: Vector3, f: cdouble): Vector3 {.cdecl, exportc, dynlib.} = divideNew(v, f)
proc divideSelf_v3*(v: var Vector3, f: cdouble): Vector3 {.cdecl, exportc, noinit, dynlib.} = divideSelf(v, f)
proc multiplyNew_v3*(v: Vector3, f: cdouble): Vector3 {.cdecl, exportc, dynlib.} = multiplyNew(v, f)
proc multiplySelf_v3*(v: var Vector3, f: cdouble): Vector3 {.cdecl, exportc, noinit, dynlib.} = multiplySelf(v, f)
proc dot_v3*(v1, v2: Vector3): cdouble {.cdecl, exportc, dynlib.} = dot(v1, v2)
proc cross_v3*(v1, v2: Vector3): Vector3 {.cdecl, exportc, dynlib.} = cross(v1, v2)
proc inverseNew_v3*(v: Vector3): Vector3 {.cdecl, exportc, dynlib.} = inverseNew(v)
proc inverseSelf_v3*(v: var Vector3): Vector3 {.cdecl, exportc, noinit, dynlib.} = inverseSelf(v)
proc headingXY_v3*(v: Vector3): cdouble {.cdecl, exportc, dynlib.} = headingXY(v)
proc headingXZ_v3*(v: Vector3): cdouble {.cdecl, exportc, dynlib.} = headingXZ(v)
proc headingYZ_v3*(v: Vector3): cdouble {.cdecl, exportc, dynlib.} = headingYZ(v)
proc reflectNew_v3*(v1, v2: Vector3): Vector3 {.cdecl, exportc, dynlib.} = reflectNew(v1, v2)
proc reflectSelf_v3*(v1: var Vector3, v2: Vector3): Vector3 {.cdecl, exportc, noinit, dynlib.} = reflectSelf(v1, v2)
proc refractNew_v3*(v: Vector3, n: Vector3, eta: float): Vector3 {.cdecl, exportc, dynlib.} = refractNew(v, n, eta)
proc refractSelf_v3*(v: var Vector3, n: Vector3, eta: float): Vector3 {.cdecl, exportc, noinit, dynlib.} = refractSelf(v, n, eta)
proc normalizeNew_v3*(v: Vector3, m: cdouble = 1.0): Vector3 {.cdecl, exportc, dynlib.} = normalizeNew(v, m)
proc normalizeSelf_v3*(v: var Vector3, m: cdouble = 1.0): Vector3 {.cdecl, exportc, noinit, dynlib.} = normalizeSelf(v, m)
proc angleBetween_v3*(v1, v2: Vector3): cdouble {.cdecl, exportc, dynlib.} = angleBetween(v1,v2)
proc dimension_v3*(v: Vector3): int {.cdecl, exportc, dynlib.} = dimension(v)
proc magnitude_v3*(v: Vector3): cdouble {.cdecl, exportc, dynlib.} = length(v)
proc greaterThan_v3*(v1, v2: Vector3): bool {.cdecl, exportc, dynlib.} = v1 > v2
proc greaterThanEqual_v3*(v1, v2: Vector3): bool {.cdecl, exportc, dynlib.} = v1 >= v2
proc lessThan_v3*(v1, v2: Vector3): bool {.cdecl, exportc, dynlib.} = v1 < v2
proc lessThanEqual_v3*(v1, v2: Vector3): bool {.cdecl, exportc, dynlib.} = v1 <= v2
proc equals_v3*(v1, v2: Vector3): bool {.cdecl, exportc, dynlib.} = v1 == v2
proc notEqual_v3*(v1, v2: Vector3): bool {.cdecl, exportc, dynlib.} = v1 != v2
proc hash_v3*(v: Vector3): int {.cdecl, exportc, dynlib.} = hash(v)
proc toArray_v3*(v: Vector3, a: var array[3, cdouble]): void {.cdecl, exportc, dynlib.} = 
    let a2 = toArray(v)
    a[0] = a2[0]
    a[1] = a2[1]
    a[2] = a2[2]
proc compareTo_v3*(v1, v2: Vector3): int {.cdecl, exportc, dynlib.} = compareTo(v1, v2)
proc stringify_v3*(v: Vector3): cstring {.cdecl, exportc, dynlib.} =
    setupForeignThreadGc() 
    $v
proc stringify_v3_2*(v: Vector3, s: var string): void {.cdecl, exportc, dynlib.} =
    setupForeignThreadGc()
    let st = $v
    s = st
