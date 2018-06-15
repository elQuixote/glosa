import ../../core/vector
import ../../core/shape
import json
from ../../core/matrix import Matrix44, Matrix33

# ***************************************
#     Circle Proc Wrappers
# ***************************************
# Constructors
proc circle_v2*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(circle2FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc circle_v3*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(circle3FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc circle_v4*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(circle4FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Contains
proc contains_v2_circle*(s: cstring, v: Vector2): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = containsPoint(circle2FromJson($s), v)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc contains_v3_circle*(s: cstring, v: Vector3): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = containsPoint(circle3FromJson($s), v)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc contains_v4_circle*(s: cstring, v: Vector4): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = containsPoint(circle4FromJson($s), v)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Area
proc area_v2_circle*(s: cstring): cdouble {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = area(circle2FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc area_v3_circle*(s: cstring): cdouble {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = area(circle3FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc area_v4_circle*(s: cstring): cdouble {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = area(circle4FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Perimeter
proc perimeter_v2_circle*(s: cstring): cdouble {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = perimeter(circle2FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc perimeter_v3_circle*(s: cstring): cdouble {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = perimeter(circle3FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc perimeter_v4_circle*(s: cstring): cdouble {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = perimeter(circle4FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Circumference
proc circumference_v2_circle*(s: cstring): cdouble {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = circumference(circle2FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc circumference_v3_circle*(s: cstring): cdouble {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = circumference(circle3FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc circumference_v4_circle*(s: cstring): cdouble {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = circumference(circle4FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Centroid
proc centroid_v2_circle*(s: cstring): Vector2 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = centroid(circle2FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc centroid_v3_circle*(s: cstring): Vector3 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = centroid(circle3FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc centroid_v4_circle*(s: cstring): Vector4 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = centroid(circle4FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Average
proc average_v2_circle*(s: cstring): Vector2 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = average(circle2FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc average_v3_circle*(s: cstring): Vector3 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = average(circle3FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc average_v4_circle*(s: cstring): Vector4 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = average(circle4FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# ClosestPoint
proc closestPoint_v2_circle*(s: cstring, v: Vector2): Vector2 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = closestPoint(circle2FromJson($s), v)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc closestPoint_v3_circle*(s: cstring, v: Vector3): Vector3 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = closestPoint(circle3FromJson($s), v)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc closestPoint_v4_circle*(s: cstring, v: Vector4): Vector4 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = closestPoint(circle4FromJson($s), v)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Equality
proc equals_v2_circle*(s1, s2: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = circle2FromJson($s1) == circle2FromJson($s2)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc equals_v3_circle*(s1, s2: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = circle3FromJson($s1) == circle3FromJson($s2)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc equals_v4_circle*(s1, s2: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = circle4FromJson($s1) == circle4FromJson($s2)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Hash
proc hash_v2_circle*(s: cstring): int {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = hash(circle2FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc hash_v3_circle*(s: cstring): int {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = hash(circle3FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc hash_v4_circle*(s: cstring): int {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = hash(circle4FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Dimension
proc dimension_v2_circle*(s: cstring): int {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = dimension(circle2FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc dimension_v3_circle*(s: cstring): int {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = dimension(circle3FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc dimension_v4_circle*(s: cstring): int {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = dimension(circle4FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Copy
proc copy_v2_circle*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(copy(circle2FromJson($s)))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc copy_v3_circle*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(copy(circle3FromJson($s)))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc copy_v4_circle*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(copy(circle4FromJson($s)))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Clear
proc clear_v2_circle*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = circle2FromJson($s)
  result = toJson(clear(p))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc clear_v3_circle*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = circle3FromJson($s)
  result = toJson(clear3(p))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc clear_v4_circle*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = circle4FromJson($s)
  result = toJson(clear4(p))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Stringify
proc stringify_v2_circle*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = $circle2FromJson($s)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc stringify_v3_circle*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = $circle3FromJson($s)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc stringify_v4_circle*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = $circle4FromJson($s)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Transforms
# Rotate
proc rotate_v2_circle*(s: cstring, theta: cdouble): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = circle2FromJson($s)
  result = toJson(rotate(p, theta))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Scale
proc scale_v2_circle*(s: cstring, f: cdouble): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = circle2FromJson($s)
  result = toJson(scale(p, f))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc scale_v3_circle*(s: cstring, f: cdouble): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = circle3FromJson($s)
  result = toJson(scale(p, f))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc scale_v4_circle*(s: cstring, f: cdouble): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = circle4FromJson($s)
  result = toJson(scale(p, f))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Translate
proc translate_v2_circle*(s: cstring, t: cdouble): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = circle2FromJson($s)
  result = toJson(translate(p, t))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc translate_v3_circle*(s: cstring, t: cdouble): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = circle3FromJson($s)
  result = toJson(translate(p, t))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc translate_v4_circle*(s: cstring, t: cdouble): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = circle4FromJson($s)
  result = toJson(translate(p, t))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Transform
proc transform_v2_circle*(s: cstring, m: Matrix33): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = circle2FromJson($s)
  result = toJson(transform(p, m))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc transform_v3_circle*(s: cstring, m: Matrix44): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = circle3FromJson($s)
  result = toJson(transform(p, m))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc transform_v4_circle*(s: cstring, m: Matrix44): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = circle4FromJson($s)
  result = toJson(transform(p, m))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()
