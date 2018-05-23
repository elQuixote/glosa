import ../../core/vector
import ../../core/matrix

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
proc refractNew_v2*(v: Vector2, n: Vector2, eta: cdouble): Vector2 {.cdecl, exportc, dynlib.} = refractNew(v, n, eta)
proc refractSelf_v2*(v: var Vector2, n: Vector2, eta: cdouble): Vector2 {.cdecl, exportc, noinit, dynlib.} = refractSelf(v, n, eta)
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
proc stringify_v2*(v: Vector2): cstring {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  $v
proc toVector3_v2*(v1: Vector2, z: cdouble = 0.0): Vector3 {.cdecl, exportc, dynlib.} = vector3(v1, z)
proc toVector4_v2*(v1: Vector2, z, w: cdouble = 0.0): Vector4 {.cdecl, exportc, dynlib.} = vector4(v1, z, w)
proc fromArray_v2*(a: array[2, cdouble]): Vector2 {.cdecl, exportc, dynlib.} = vector2(a)
proc fromPolar_v2*(r, theta: cdouble): Vector2 {.cdecl, exportc, dynlib.} = fromPolar(r, theta)
proc randomize_v2*(v: var Vector2, maxX, maxY: cdouble): Vector2 {.cdecl, exportc, noinit, dynlib.} = randomize(v, maxX, maxY)
proc magnitudeSquared_v2*(v: Vector2): cdouble {.cdecl, exportc, dynlib.} = magnitudeSquared(v)
proc distanceTo_v2*(v1, v2: Vector2): cdouble {.cdecl, exportc, dynlib.} = distanceTo(v1, v2)
proc distanceToSquared_v2*(v1, v2: Vector2): cdouble {.cdecl, exportc, dynlib.} = distanceToSquared(v1, v2)
proc interpolateTo_v2*(v1, v2: Vector2, f: cdouble): Vector2 {.cdecl, exportc, dynlib.} = interpolateTo(v1, v2, f)
proc transformSelf_v2*(v: var Vector2, m: Matrix33): Vector2 {.cdecl, exportc, noinit, dynlib.} = transform(v, m)
proc transformNew_v2*(v: Vector2, m: Matrix33): Vector2 {.cdecl, exportc, dynlib.} = transformNew(v, m)
proc rotateSelf_v2*(v: var Vector2, theta: cdouble): Vector2 {.cdecl, exportc, noinit, dynlib.} = rotateSelf(v, theta)
proc rotateNew_v2*(v: Vector2, theta: cdouble): Vector2 {.cdecl, exportc, dynlib.} = rotateNew(v, theta)
proc scaleSelf_v2*(v: var Vector2, s: cdouble): Vector2 {.cdecl, exportc, noinit, dynlib.} = scaleSelf(v, s)
proc scaleNew_v2*(v: Vector2, s: cdouble): Vector2 {.cdecl, exportc, dynlib.} = scaleNew(v, s)
proc scaleSelfComponent_v2*(v: var Vector2, sx, sy: cdouble): Vector2 {.cdecl, exportc, noinit, dynlib.} = scaleSelf(v, sx, sy)
proc scaleNewComponent_v2*(v: Vector2, sx, sy: cdouble): Vector2 {.cdecl, exportc, dynlib.} = scaleNew(v, sx, sy)
proc translate_v2*(v1: var Vector2, v2: Vector2): Vector2 {.cdecl, exportc, noinit, dynlib.} = translate(v1, v2)
proc min_v2*(a: openArray[Vector2]): Vector2 {.cdecl, exportc, dynlib.} = min(a)
proc max_v2*(a: openArray[Vector2]): Vector2 {.cdecl, exportc, dynlib.} = max(a)

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
proc refractNew_v3*(v: Vector3, n: Vector3, eta: cdouble): Vector3 {.cdecl, exportc, dynlib.} = refractNew(v, n, eta)
proc refractSelf_v3*(v: var Vector3, n: Vector3, eta: cdouble): Vector3 {.cdecl, exportc, noinit, dynlib.} = refractSelf(v, n, eta)
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
proc stringify_v3*(v: Vector3): cstring {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  $v
proc toVector2_v3*(v: Vector3): Vector2 {.cdecl, exportc, dynlib.} = vector2(v)
proc toVector4_v3*(v: Vector3, w: cdouble = 0.0): Vector4 {.cdecl, exportc, dynlib.} = vector4(v, w)
proc fromArray_v3*(a: array[3, cdouble]): Vector3 {.cdecl, exportc, dynlib.} = vector3(a)
proc fromSpherical_v3*(r, theta, phi: cdouble): Vector3 {.cdecl, exportc, dynlib.} = fromSpherical(r, theta, phi)
proc randomize_v3*(v: var Vector3, maxX, maxY, maxZ: cdouble): Vector3 {.cdecl, exportc, noinit, dynlib.} = randomize(v, maxX, maxY, maxZ)
proc magnitudeSquared_v3*(v: Vector3): cdouble {.cdecl, exportc, dynlib.} = magnitudeSquared(v)
proc distanceTo_v3*(v1, v2: Vector3): cdouble {.cdecl, exportc, dynlib.} = distanceTo(v1, v2)
proc distanceToSquared_v3*(v1, v2: Vector3): cdouble {.cdecl, exportc, dynlib.} = distanceToSquared(v1, v2)
proc interpolateTo_v3*(v1, v2: Vector3, f: cdouble): Vector3 {.cdecl, exportc, dynlib.} = interpolateTo(v1, v2, f)
proc transformSelf_v3*(v: var Vector3, m: Matrix44): Vector3 {.cdecl, exportc, noinit, dynlib.} = transform(v, m)
proc transformNew_v3*(v: Vector3, m: Matrix44): Vector3 {.cdecl, exportc, dynlib.} = transformNew(v, m)
proc rotateXSelf_v3*(v: var Vector3, theta: cdouble): Vector3 {.cdecl, exportc, noinit, dynlib.} = rotateXSelf(v, theta)
proc rotateXNew_v3*(v: Vector3, theta: cdouble): Vector3 {.cdecl, exportc, dynlib.} = rotateXNew(v, theta)
proc rotateYSelf_v3*(v: var Vector3, theta: cdouble): Vector3 {.cdecl, exportc, noinit, dynlib.} = rotateYSelf(v, theta)
proc rotateYNew_v3*(v: Vector3, theta: cdouble): Vector3 {.cdecl, exportc, dynlib.} = rotateYNew(v, theta)
proc rotateZSelf_v3*(v: var Vector3, theta: cdouble): Vector3 {.cdecl, exportc, noinit, dynlib.} = rotateZSelf(v, theta)
proc rotateZNew_v3*(v: Vector3, theta: cdouble): Vector3 {.cdecl, exportc, dynlib.} = rotateZNew(v, theta)
proc rotateAxis_v3*(v: var Vector3, axis: Vector3, theta: cdouble): Vector3 {.cdecl, exportc, noinit, dynlib.} = rotate(v, axis, theta)
proc scaleSelf_v3*(v: var Vector3, s: cdouble): Vector3 {.cdecl, exportc, noinit, dynlib.} = scaleSelf(v, s)
proc scaleNew_v3*(v: Vector3, s: cdouble): Vector3 {.cdecl, exportc, dynlib.} = scaleNew(v, s)
proc scaleSelfComponent_v3*(v: var Vector3, sx, sy, sz: cdouble): Vector3 {.cdecl, exportc, noinit, dynlib.} = scaleSelf(v, sx, sy, sz)
proc scaleNewComponent_v3*(v: Vector3, sx, sy, sz: cdouble): Vector3 {.cdecl, exportc, dynlib.} = scaleNew(v, sx, sy, sz)
proc translate_v3*(v1: var Vector3, v2: Vector3): Vector3 {.cdecl, exportc, noinit, dynlib.} = translate(v1, v2)
proc min_v3*(a: openArray[Vector3]): Vector3 {.cdecl, exportc, dynlib.} = min(a)
proc max_v3*(a: openArray[Vector3]): Vector3 {.cdecl, exportc, dynlib.} = max(a)

# Vector4 Proc Wraps
proc copy_v4*(v1: Vector4): Vector4 {.cdecl, exportc, dynlib.} = copy(v1)
proc set_v4*(v: var Vector4, n: cdouble): Vector4 {.cdecl, exportc, noinit, dynlib.} = set(v, n)
proc set2_v4*(v: var Vector4, x, y, z, w: cdouble): Vector4 {.cdecl, exportc, noinit, dynlib.} = set(v, x, y, z, w)
proc clear_v4*(v: var Vector4): Vector4 {.cdecl, exportc, dynlib.} = set(v, 0.0)
proc addNew_v4*(v1, v2: Vector4): Vector4 {.cdecl, exportc, dynlib.} = addNew(v1, v2)
proc addSelf_v4*(v1: var Vector4, v2: Vector4): Vector4 {.cdecl, exportc, noinit, dynlib.} = addSelf(v1, v2)
proc subtractNew_v4*(v1, v2: Vector4): Vector4 {.cdecl, exportc, dynlib.} = subtractNew(v1, v2)
proc subtractSelf_v4*(v1: var Vector4, v2: Vector4): Vector4 {.cdecl, exportc, noinit, dynlib.} = subtractSelf(v1, v2)
proc divideNew_v4*(v: Vector4, f: cdouble): Vector4 {.cdecl, exportc, dynlib.} = divideNew(v, f)
proc divideSelf_v4*(v: var Vector4, f: cdouble): Vector4 {.cdecl, exportc, noinit, dynlib.} = divideSelf(v, f)
proc multiplyNew_v4*(v: Vector4, f: cdouble): Vector4 {.cdecl, exportc, dynlib.} = multiplyNew(v, f)
proc multiplySelf_v4*(v: var Vector4, f: cdouble): Vector4 {.cdecl, exportc, noinit, dynlib.} = multiplySelf(v, f)
proc dot_v4*(v1, v2: Vector4): cdouble {.cdecl, exportc, dynlib.} = dot(v1, v2)
proc inverseNew_v4*(v: Vector4): Vector4 {.cdecl, exportc, dynlib.} = inverseNew(v)
proc inverseSelf_v4*(v: var Vector4): Vector4 {.cdecl, exportc, noinit, dynlib.} = inverseSelf(v)
proc headingXY_v4*(v: Vector4): cdouble {.cdecl, exportc, dynlib.} = headingXY(v)
proc headingXZ_v4*(v: Vector4): cdouble {.cdecl, exportc, dynlib.} = headingXZ(v)
proc headingXW_v4*(v: Vector4): cdouble {.cdecl, exportc, dynlib.} = headingXW(v)
proc headingYZ_v4*(v: Vector4): cdouble {.cdecl, exportc, dynlib.} = headingYZ(v)
proc headingYW_v4*(v: Vector4): cdouble {.cdecl, exportc, dynlib.} = headingYW(v)
proc headingZW_v4*(v: Vector4): cdouble {.cdecl, exportc, dynlib.} = headingZW(v)
proc reflectNew_v4*(v1, v2: Vector4): Vector4 {.cdecl, exportc, dynlib.} = reflectNew(v1, v2)
proc reflectSelf_v4*(v1: var Vector4, v2: Vector4): Vector4 {.cdecl, exportc, noinit, dynlib.} = reflectSelf(v1, v2)
proc refractNew_v4*(v: Vector4, n: Vector4, eta: cdouble): Vector4 {.cdecl, exportc, dynlib.} = refractNew(v, n, eta)
proc refractSelf_v4*(v: var Vector4, n: Vector4, eta: cdouble): Vector4 {.cdecl, exportc, noinit, dynlib.} = refractSelf(v, n, eta)
proc normalizeNew_v4*(v: Vector4, m: cdouble = 1.0): Vector4 {.cdecl, exportc, dynlib.} = normalizeNew(v, m)
proc normalizeSelf_v4*(v: var Vector4, m: cdouble = 1.0): Vector4 {.cdecl, exportc, noinit, dynlib.} = normalizeSelf(v, m)
proc angleBetween_v4*(v1, v2: Vector4): cdouble {.cdecl, exportc, dynlib.} = angleBetween(v1,v2)
proc dimension_v4*(v: Vector4): int {.cdecl, exportc, dynlib.} = dimension(v)
proc magnitude_v4*(v: Vector4): cdouble {.cdecl, exportc, dynlib.} = length(v)
proc greaterThan_v4*(v1, v2: Vector4): bool {.cdecl, exportc, dynlib.} = v1 > v2
proc greaterThanEqual_v4*(v1, v2: Vector4): bool {.cdecl, exportc, dynlib.} = v1 >= v2
proc lessThan_v4*(v1, v2: Vector4): bool {.cdecl, exportc, dynlib.} = v1 < v2
proc lessThanEqual_v4*(v1, v2: Vector4): bool {.cdecl, exportc, dynlib.} = v1 <= v2
proc equals_v4*(v1, v2: Vector4): bool {.cdecl, exportc, dynlib.} = v1 == v2
proc notEqual_v4*(v1, v2: Vector4): bool {.cdecl, exportc, dynlib.} = v1 != v2
proc hash_v4*(v: Vector4): int {.cdecl, exportc, dynlib.} = hash(v)
proc toArray_v4*(v: Vector4, a: var array[4, cdouble]): void {.cdecl, exportc, dynlib.} =
  let a2 = toArray(v)
  a[0] = a2[0]
  a[1] = a2[1]
  a[2] = a2[2]
  a[3] = a2[3]
proc stringify_v4*(v: Vector4): cstring {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  $v
proc toVector2*(v: Vector4): Vector2 {.cdecl, exportc, dynlib.} = vector2(v)
proc toVector3*(v: Vector4): Vector3 {.cdecl, exportc, dynlib.} = vector3(v)
proc fromArray_v4*(a: array[4, cdouble]): Vector4 {.cdecl, exportc, dynlib.} = vector4(a)
proc fromSpherical_v4*(r, theta, phi, psi: cdouble): Vector4 {.cdecl, exportc, dynlib.} = from3Spherical(r, theta, phi, psi)
proc randomize_v4*(v: var Vector4, maxX, maxY, maxZ, maxW: cdouble): Vector4 {.cdecl, exportc, noinit, dynlib.} = randomize(v, maxX, maxY, maxZ, maxW)
proc magnitudeSquared_v4*(v: Vector4): cdouble {.cdecl, exportc, dynlib.} = magnitudeSquared(v)
proc distanceTo_v4*(v1, v2: Vector4): cdouble {.cdecl, exportc, dynlib.} = distanceTo(v1, v2)
proc distanceToSquared_v4*(v1, v2: Vector4): cdouble {.cdecl, exportc, dynlib.} = distanceToSquared(v1, v2)
proc interpolateTo_v4*(v1, v2: Vector4, f: cdouble): Vector4 {.cdecl, exportc, dynlib.} = interpolateTo(v1, v2, f)
proc transformSelf_v4*(v: var Vector4, m: Matrix44): Vector4 {.cdecl, exportc, noinit, dynlib.} = transform(v, m)
proc transformNew_v4*(v: Vector4, m: Matrix44): Vector4 {.cdecl, exportc, dynlib.} = transformNew(v, m)
proc rotateXYSelf_v4*(v: var Vector4, theta: cdouble): Vector4 {.cdecl, exportc, noinit, dynlib.} = rotateXYSelf(v, theta)
proc rotateXYNew_v4*(v: Vector4, theta: cdouble): Vector4 {.cdecl, exportc, dynlib.} = rotateXYNew(v, theta)
proc rotateXZSelf_v4*(v: var Vector4, theta: cdouble): Vector4 {.cdecl, exportc, noinit, dynlib.} = rotateXZSelf(v, theta)
proc rotateXZNew_v4*(v: Vector4, theta: cdouble): Vector4 {.cdecl, exportc, dynlib.} = rotateXZNew(v, theta)
proc rotateXWSelf_v4*(v: var Vector4, theta: cdouble): Vector4 {.cdecl, exportc, noinit, dynlib.} = rotateXWSelf(v, theta)
proc rotateXWNew_v4*(v: Vector4, theta: cdouble): Vector4 {.cdecl, exportc, dynlib.} = rotateXWNew(v, theta)
proc rotateYZSelf_v4*(v: var Vector4, theta: cdouble): Vector4 {.cdecl, exportc, noinit, dynlib.} = rotateYZSelf(v, theta)
proc rotateYZNew_v4*(v: Vector4, theta: cdouble): Vector4 {.cdecl, exportc, dynlib.} = rotateYZNew(v, theta)
proc rotateYWSelf_v4*(v: var Vector4, theta: cdouble): Vector4 {.cdecl, exportc, noinit, dynlib.} = rotateYWSelf(v, theta)
proc rotateYWNew_v4*(v: Vector4, theta: cdouble): Vector4 {.cdecl, exportc, dynlib.} = rotateYWNew(v, theta)
proc rotateZWSelf_v4*(v: var Vector4, theta: cdouble): Vector4 {.cdecl, exportc, noinit, dynlib.} = rotateZWSelf(v, theta)
proc rotateZWNew_v4*(v: Vector4, theta: cdouble): Vector4 {.cdecl, exportc, dynlib.} = rotateZWNew(v, theta)
proc rotateAxis_v4*(v: var Vector4, b1, b2: Vector4, theta: cdouble, b3, b4: Vector4, phi: float): Vector4 {.cdecl, exportc, noinit, dynlib.} = 
  rotate(v, b1, b2, theta, b3, b4, phi)
proc scaleSelf_v4*(v: var Vector4, s: cdouble): Vector4 {.cdecl, exportc, noinit, dynlib.} = scaleSelf(v, s)
proc scaleNew_v4*(v: Vector4, s: cdouble): Vector4 {.cdecl, exportc, dynlib.} = scaleNew(v, s)
proc scaleSelfComponent_v4*(v: var Vector4, sx, sy, sz, sw: cdouble): Vector4 {.cdecl, exportc, noinit, dynlib.} = scaleSelf(v, sx, sy, sz, sw)
proc scaleNewComponent_v4*(v: Vector4, sx, sy, sz, sw: cdouble): Vector4 {.cdecl, exportc, dynlib.} = scaleNew(v, sx, sy, sz, sw)
proc translate_v4*(v1: var Vector4, v2: Vector4): Vector4 {.cdecl, exportc, noinit, dynlib.} = translate(v1, v2)
proc min_v4*(a: openArray[Vector4]): Vector4 {.cdecl, exportc, dynlib.} = min(a)
proc max_v4*(a: openArray[Vector4]): Vector4 {.cdecl, exportc, dynlib.} = max(a)
proc calculatePlane_v4*(v1, v2, v3: Vector3): Vector4 {.cdecl, exportc, dynlib.} = calculatePlane(v1, v2, v3)

proc areCollinear_v*(v1, v2, v3: Vector3): bool {.cdecl, exportc, dynlib.} = areCollinear(v1, v2, v3)
proc arePlanar_v*(a: openArray[Vector3]): bool {.cdecl, exportc, dynlib.} = arePlanar(a)