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
  GC_disable()
  result = toJson(polygon1FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc polygon_v2*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(polygon2FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc polygon_v3*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(polygon3FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc polygon_v4*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(polygon4FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Reverse
proc reverse_v2_polygon*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = polygon2FromJson($s)
  result = toJson(reverse(p))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc reverse_v3_polygon*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = polygon3FromJson($s)
  result = toJson(reverse(p))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc reverse_v4_polygon*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = polygon4FromJson($s)
  result = toJson(reverse(p))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Contains
proc contains_v2_polygon*(s: cstring, v: Vector2): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = contains(polygon2FromJson($s), v)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc contains_v3_polygon*(s: cstring, v: Vector3): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = contains(polygon3FromJson($s), v)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc contains_v4_polygon*(s: cstring, v: Vector4): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = contains(polygon4FromJson($s), v)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# ContainsPoint
proc containsPoint_v2_polygon*(s: cstring, v: Vector2): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = containsPoint(polygon2FromJson($s), v)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc containsPoint_v3_polygon*(s: cstring, v: Vector3): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = containsPoint(polygon3FromJson($s), v)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc containsPoint_v4_polygon*(s: cstring, v: Vector4): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = containsPoint(polygon4FromJson($s), v)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Equality
proc equals_v2_polygon*(s1, s2: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = polygon2FromJson($s1) == polygon2FromJson($s2)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc equals_v3_polygon*(s1, s2: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = polygon3FromJson($s1) == polygon3FromJson($s2)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc equals_v4_polygon*(s1, s2: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = polygon4FromJson($s1) == polygon4FromJson($s2)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Hash
proc hash_v2_polygon*(s: cstring): int {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = hash(polygon2FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc hash_v3_polygon*(s: cstring): int {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = hash(polygon3FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc hash_v4_polygon*(s: cstring): int {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = hash(polygon4FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Dimension
proc dimension_v2_polygon*(s: cstring): int {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = dimension(polygon2FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc dimension_v3_polygon*(s: cstring): int {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = dimension(polygon3FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc dimension_v4_polygon*(s: cstring): int {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = dimension(polygon4FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Copy
proc copy_v2_polygon*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(copy(polygon2FromJson($s)))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc copy_v3_polygon*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(copy(polygon3FromJson($s)))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc copy_v4_polygon*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(copy(polygon4FromJson($s)))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Stringify
proc stringify_v2_polygon*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = $polygon2FromJson($s)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc stringify_v3_polygon*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = $polygon3FromJson($s)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc stringify_v4_polygon*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = $polygon4FromJson($s)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

#Area
proc area_v2_polygon*(s: cstring): cdouble {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  result = area(polygon2FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc area_v3_polygon*(s: cstring): cdouble {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  result = area(polygon3FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc area_v4_polygon*(s: cstring): cdouble {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  result = area(polygon4FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

#Perimeter
proc perimeter_v2_polygon*(s: cstring): cdouble {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  result = perimeter(polygon2FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc perimeter_v3_polygon*(s: cstring): cdouble {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  result = perimeter(polygon3FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc perimeter_v4_polygon*(s: cstring): cdouble {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  result = perimeter(polygon4FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Centroid
proc centroid_v2_polygon*(s: cstring): Vector2 {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  result = centroid(polygon2FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# proc centroid_v3_polygon*(s: cstring): Vector3 {.cdecl, exportc, dynlib.} =
#   setupForeignThreadGc()
  GC_disable()
#   result = centroid(polygon3FromJson($s))
#   GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# proc centroid_v4_polygon*(s: cstring): Vector4 {.cdecl, exportc, dynlib.} =
#   setupForeignThreadGc()
  GC_disable()
#   result = centroid(polygon4FromJson($s))
#   GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# ClosestVertex
proc closestVertex_v2_polygon*(s: cstring, v: Vector2): Vector2 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = closestVertex(polygon2FromJson($s), v)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc closestVertex_v3_polygon*(s: cstring, v: Vector3): Vector3 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = closestVertex(polygon3FromJson($s), v)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc closestVertex_v4_polygon*(s: cstring, v: Vector4): Vector4 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = closestVertex(polygon4FromJson($s), v)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# ToPolyline
proc toPolyline_v2_polygon*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(toPolyline(polygon2FromJson($s)))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc toPolyline_v3_polygon*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(toPolyline(polygon3FromJson($s)))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc toPolyline_v4_polygon*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(toPolyline(polygon4FromJson($s)))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# ClosestPoint
proc closestPoint_v2_polygon*(s: cstring, v: Vector2): Vector2 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = closestPoint(polygon2FromJson($s), v)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc closestPoint_v3_polygon*(s: cstring, v: Vector3): Vector3 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = closestPoint(polygon3FromJson($s), v)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc closestPoint_v4_polygon*(s: cstring, v: Vector4): Vector4 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = closestPoint(polygon4FromJson($s), v)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Clockwise
proc isClockwise_v2_polygon*(s: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = isClockwise(polygon2FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc isClockwise_v3_polygon*(s: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = isClockwise(polygon3FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc isClockwise_v4_polygon*(s: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = isClockwise(polygon4FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()
  
# Transforms
# Rotate
proc rotate_v2_polygon*(s: cstring, theta: cdouble): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = polygon2FromJson($s)
  result = toJson(rotate(p, theta))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc rotate_v3_polygon*(s: cstring, axis: Vector3, theta: cdouble): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = polygon3FromJson($s)
  result = toJson(rotate(p, axis, theta))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc rotate_v4_polygon*(s: cstring, b1, b2: Vector4, theta: cdouble, b3, b4: Vector4, phi: cdouble): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = polygon4FromJson($s)
  result = toJson(rotate(p, b1, b2, theta, b3, b4, phi))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Scale
proc scale_v2_polygon*(s: cstring, sx, sy: cdouble): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = polygon2FromJson($s)
  result = toJson(scale(p, sx, sy))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc scale_v3_polygon*(s: cstring, sx, sy, sz: cdouble): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = polygon3FromJson($s)
  result = toJson(scale(p, sx, sy, sz))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc scale_v4_polygon*(s: cstring, sx, sy, sz, sw: cdouble): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = polygon4FromJson($s)
  result = toJson(scale(p, sx, sy, sz, sw))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Translate
proc translate_v2_polygon*(s: cstring, v: Vector2): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = polygon2FromJson($s)
  result = toJson(translate(p, v))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc translate_v3_polygon*(s: cstring, v: Vector3): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = polygon3FromJson($s)
  result = toJson(translate(p, v))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc translate_v4_polygon*(s: cstring, v: Vector4): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = polygon4FromJson($s)
  result = toJson(translate(p, v))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Transform
proc transform_v2_polygon*(s: cstring, m: Matrix33): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = polygon2FromJson($s)
  result = toJson(transform(p, m))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc transform_v3_polygon*(s: cstring, m: Matrix44): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = polygon3FromJson($s)
  result = toJson(transform(p, m))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc transform_v4_polygon*(s: cstring, m: Matrix44): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = polygon4FromJson($s)
  result = toJson(transform(p, m))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# ArePlanar
proc isPlanarVertices_v2_polygon*(s: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = polygon2FromJson($s)
  result = arePlanar(p.polyline.vertices)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc isPlanarVertices_v3_polygon*(s: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = arePlanar(polygon3FromJson($s).polyline.vertices)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc isPlanarVertices_v4_polygon*(s: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = polygon4FromJson($s)
  result = arePlanar(p.polyline.vertices)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc() 

proc isSegmentsClosed_v2_polygon*(s: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = polygon2FromJson($s)
  result = areClosed(p.polyline.segments)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc isSegmentsClosed_v3_polygon*(s: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = areClosed(polygon3FromJson($s).polyline.segments)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc isSegmentsClosed_v4_polygon*(s: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = polygon4FromJson($s)
  result = areClosed(p.polyline.segments)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc() 
