import ../../core/path
import ../../core/vector
import json
import ../../core/polygon
from ../../core/matrix import Matrix44, Matrix33

# ***************************************
#     Polygon Proc Wrappers
# ***************************************
# Constructors
proc polygon_v1*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(polygon1FromJson($s))
  tearDownForeignThreadGc()

proc polygon_v2*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(polygon2FromJson($s))
  tearDownForeignThreadGc()

proc polygon_v3*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(polygon3FromJson($s))
  tearDownForeignThreadGc()

proc polygon_v4*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(polygon4FromJson($s))
  tearDownForeignThreadGc()

# Reverse
proc reverse_v2_polygon*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  var p = polygon2FromJson($s)
  result = toJson(reverse(p))
  tearDownForeignThreadGc()

proc reverse_v3_polygon*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  var p = polygon3FromJson($s)
  result = toJson(reverse(p))
  tearDownForeignThreadGc()

proc reverse_v4_polygon*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  var p = polygon4FromJson($s)
  result = toJson(reverse(p))
  tearDownForeignThreadGc()

# Contains
proc contains_v2_polygon*(s: cstring, v: Vector2): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = contains(polygon2FromJson($s), v)
  tearDownForeignThreadGc()

proc contains_v3_polygon*(s: cstring, v: Vector3): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = contains(polygon3FromJson($s), v)
  tearDownForeignThreadGc()

proc contains_v4_polygon*(s: cstring, v: Vector4): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = contains(polygon4FromJson($s), v)
  tearDownForeignThreadGc()

# ContainsPoint
proc containsPoint_v2_polygon*(s: cstring, v: Vector2): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = containsPoint(polygon2FromJson($s), v)
  tearDownForeignThreadGc()

proc containsPoint_v3_polygon*(s: cstring, v: Vector3): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = containsPoint(polygon3FromJson($s), v)
  tearDownForeignThreadGc()

proc containsPoint_v4_polygon*(s: cstring, v: Vector4): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = containsPoint(polygon4FromJson($s), v)
  tearDownForeignThreadGc()

# Equality
proc equals_v2_polygon*(s1, s2: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = polygon2FromJson($s1) == polygon2FromJson($s2)
  tearDownForeignThreadGc()

proc equals_v3_polygon*(s1, s2: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = polygon3FromJson($s1) == polygon3FromJson($s2)
  tearDownForeignThreadGc()

proc equals_v4_polygon*(s1, s2: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = polygon4FromJson($s1) == polygon4FromJson($s2)
  tearDownForeignThreadGc()

# Hash
proc hash_v2_polygon*(s: cstring): int {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = hash(polygon2FromJson($s))
  tearDownForeignThreadGc()

proc hash_v3_polygon*(s: cstring): int {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = hash(polygon3FromJson($s))
  tearDownForeignThreadGc()

proc hash_v4_polygon*(s: cstring): int {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = hash(polygon4FromJson($s))
  tearDownForeignThreadGc()

# Dimension
proc dimension_v2_polygon*(s: cstring): int {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = dimension(polygon2FromJson($s))
  tearDownForeignThreadGc()

proc dimension_v3_polygon*(s: cstring): int {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = dimension(polygon3FromJson($s))
  tearDownForeignThreadGc()

proc dimension_v4_polygon*(s: cstring): int {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = dimension(polygon4FromJson($s))
  tearDownForeignThreadGc()

# Copy
proc copy_v2_polygon*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(copy(polygon2FromJson($s)))
  tearDownForeignThreadGc()

proc copy_v3_polygon*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(copy(polygon3FromJson($s)))
  tearDownForeignThreadGc()

proc copy_v4_polygon*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(copy(polygon4FromJson($s)))
  tearDownForeignThreadGc()

# Stringify
proc stringify_v2_polygon*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = $polygon2FromJson($s)
  tearDownForeignThreadGc()

proc stringify_v3_polygon*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = $polygon3FromJson($s)
  tearDownForeignThreadGc()

proc stringify_v4_polygon*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = $polygon4FromJson($s)
  tearDownForeignThreadGc()

#Area
proc area_v2_polygon*(s: cstring): cdouble {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  result = area(polygon2FromJson($s))
  tearDownForeignThreadGc()

proc area_v3_polygon*(s: cstring): cdouble {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  result = area(polygon3FromJson($s))
  tearDownForeignThreadGc()

proc area_v4_polygon*(s: cstring): cdouble {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  result = area(polygon4FromJson($s))
  tearDownForeignThreadGc()

#Perimeter
proc perimeter_v2_polygon*(s: cstring): cdouble {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  result = perimeter(polygon2FromJson($s))
  tearDownForeignThreadGc()

proc perimeter_v3_polygon*(s: cstring): cdouble {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  result = perimeter(polygon3FromJson($s))
  tearDownForeignThreadGc()

proc perimeter_v4_polygon*(s: cstring): cdouble {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  result = perimeter(polygon4FromJson($s))
  tearDownForeignThreadGc()

# Centroid
proc centroid_v2_polygon*(s: cstring): Vector2 {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  result = centroid(polygon2FromJson($s))
  tearDownForeignThreadGc()

# proc centroid_v3_polygon*(s: cstring): Vector3 {.cdecl, exportc, dynlib.} =
#   setupForeignThreadGc()
#   result = centroid(polygon3FromJson($s))
#   tearDownForeignThreadGc()

# proc centroid_v4_polygon*(s: cstring): Vector4 {.cdecl, exportc, dynlib.} =
#   setupForeignThreadGc()
#   result = centroid(polygon4FromJson($s))
#   tearDownForeignThreadGc()

# ClosestVertex
proc closestVertex_v2_polygon*(s: cstring, v: Vector2): Vector2 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = closestVertex(polygon2FromJson($s), v)
  tearDownForeignThreadGc()

proc closestVertex_v3_polygon*(s: cstring, v: Vector3): Vector3 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = closestVertex(polygon3FromJson($s), v)
  tearDownForeignThreadGc()

proc closestVertex_v4_polygon*(s: cstring, v: Vector4): Vector4 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = closestVertex(polygon4FromJson($s), v)
  tearDownForeignThreadGc()

# ToPolyline
proc toPolyline_v2_polygon*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(toPolyline(polygon2FromJson($s)))
  tearDownForeignThreadGc()

proc toPolyline_v3_polygon*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(toPolyline(polygon3FromJson($s)))
  tearDownForeignThreadGc()

proc toPolyline_v4_polygon*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(toPolyline(polygon4FromJson($s)))
  tearDownForeignThreadGc()

# ClosestPoint
proc closestPoint_v2_polygon*(s: cstring, v: Vector2): Vector2 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = closestPoint(polygon2FromJson($s), v)
  tearDownForeignThreadGc()

proc closestPoint_v3_polygon*(s: cstring, v: Vector3): Vector3 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = closestPoint(polygon3FromJson($s), v)
  tearDownForeignThreadGc()

proc closestPoint_v4_polygon*(s: cstring, v: Vector4): Vector4 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = closestPoint(polygon4FromJson($s), v)
  tearDownForeignThreadGc()

# Clockwise
proc isClockwise_v2_polygon*(s: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = isClockwise(polygon2FromJson($s))
  tearDownForeignThreadGc()

proc isClockwise_v3_polygon*(s: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = isClockwise(polygon3FromJson($s))
  tearDownForeignThreadGc()

proc isClockwise_v4_polygon*(s: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = isClockwise(polygon4FromJson($s))
  tearDownForeignThreadGc()
  
# Transforms
# Rotate
proc rotate_v2_polygon*(s: cstring, theta: cdouble): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  var p = polygon2FromJson($s)
  result = toJson(rotate(p, theta))
  tearDownForeignThreadGc()

proc rotate_v3_polygon*(s: cstring, axis: Vector3, theta: cdouble): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  var p = polygon3FromJson($s)
  result = toJson(rotate(p, axis, theta))
  tearDownForeignThreadGc()

proc rotate_v4_polygon*(s: cstring, b1, b2: Vector4, theta: cdouble, b3, b4: Vector4, phi: cdouble): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  var p = polygon4FromJson($s)
  result = toJson(rotate(p, b1, b2, theta, b3, b4, phi))
  tearDownForeignThreadGc()

# Scale
proc scale_v2_polygon*(s: cstring, sx, sy: cdouble): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  var p = polygon2FromJson($s)
  result = toJson(scale(p, sx, sy))
  tearDownForeignThreadGc()

proc scale_v3_polygon*(s: cstring, sx, sy, sz: cdouble): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  var p = polygon3FromJson($s)
  result = toJson(scale(p, sx, sy, sz))
  tearDownForeignThreadGc()

proc scale_v4_polygon*(s: cstring, sx, sy, sz, sw: cdouble): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  var p = polygon4FromJson($s)
  result = toJson(scale(p, sx, sy, sz, sw))
  tearDownForeignThreadGc()

# Translate
proc translate_v2_polygon*(s: cstring, v: Vector2): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  var p = polygon2FromJson($s)
  result = toJson(translate(p, v))
  tearDownForeignThreadGc()

proc translate_v3_polygon*(s: cstring, v: Vector3): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  var p = polygon3FromJson($s)
  result = toJson(translate(p, v))
  tearDownForeignThreadGc()

proc translate_v4_polygon*(s: cstring, v: Vector4): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  var p = polygon4FromJson($s)
  result = toJson(translate(p, v))
  tearDownForeignThreadGc()

# Transform
proc transform_v2_polygon*(s: cstring, m: Matrix33): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  var p = polygon2FromJson($s)
  result = toJson(transform(p, m))
  tearDownForeignThreadGc()

proc transform_v3_polygon*(s: cstring, m: Matrix44): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  var p = polygon3FromJson($s)
  result = toJson(transform(p, m))
  tearDownForeignThreadGc()

proc transform_v4_polygon*(s: cstring, m: Matrix44): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  var p = polygon4FromJson($s)
  result = toJson(transform(p, m))
  tearDownForeignThreadGc()
