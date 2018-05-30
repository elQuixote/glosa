import ../../core/path
import ../../core/vector
import json
import ../../core/polygon

type
  LineSegment_Net* = object
    startPoint*: Vector3
    endPoint*: Vector3

proc lineSegment_Net*(s: LineSegment_Net): LineSegment[Vector3] = 
  result = LineSegment[Vector3](startVertex: s.startPoint, endVertex: s.endPoint)

proc lineSegment_Net*(s: LineSegment[Vector3]): LineSegment_Net = 
  result = LineSegment_Net(startPoint: s.startVertex, endPoint: s.endVertex)

# ***************************************
#     LineSegment Proc Wrappers
# ***************************************
proc areClosed_v2_segment*(s: cstring): bool {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  result = areClosed(polyline2FromJson($s).segments)
  tearDownForeignThreadGc()

proc areClosed_v3_segment*(s: cstring): bool {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  result = areClosed(polyline3FromJson($s).segments)
  tearDownForeignThreadGc()

proc areClosed_v4_segment*(s: cstring): bool {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  result = areClosed(polyline4FromJson($s).segments)
  tearDownForeignThreadGc()

# ***************************************
#     Polyline Proc Wrappers
# ***************************************
proc areClosed_v2_vertices*(s: cstring): bool {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  result = areClosed(polyline2FromJson($s).vertices)
  tearDownForeignThreadGc()

proc areClosed_v3_vertices*(s: cstring): bool {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  result = areClosed(polyline3FromJson($s).vertices)
  tearDownForeignThreadGc()

proc areClosed_v4_vertices*(s: cstring): bool {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  result = areClosed(polyline4FromJson($s).vertices)
  tearDownForeignThreadGc()

# Constructors
proc polyline_v1*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(polyline1FromJson($s))
  tearDownForeignThreadGc()

proc polyline_v2*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(polyline2FromJson($s))
  tearDownForeignThreadGc()

proc polyline_v3*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(polyline3FromJson($s))
  tearDownForeignThreadGc()

proc polyline_v4*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(polyline4FromJson($s))
  tearDownForeignThreadGc()

# Operations
proc isClosed_v2_polyline*(s: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = isClosed(polyline2FromJson($s))
  tearDownForeignThreadGc()

proc isClosed_v3_polyline*(s: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = isClosed(polyline3FromJson($s))
  tearDownForeignThreadGc()

proc isClosed_v4_polyline*(s: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = isClosed(polyline4FromJson($s))
  tearDownForeignThreadGc()

proc reverse_v2_polyline*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  var p = polyline2FromJson($s)
  result = toJson(reverse(p))
  tearDownForeignThreadGc()

proc reverse_v3_polyline*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  var p = polyline3FromJson($s)
  result = toJson(reverse(p))
  tearDownForeignThreadGc()

proc reverse_v4_polyline*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  var p = polyline4FromJson($s)
  result = toJson(reverse(p))
  tearDownForeignThreadGc()

# NOTE: Contains is causing a segfault when chained with other wrapper procs in .net
proc contains_v2_polyline*(s: cstring, v: Vector2): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = contains(polyline2FromJson($s), v)
  tearDownForeignThreadGc()

proc contains_v3_polyline*(s: cstring, v: Vector3): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = contains(polyline3FromJson($s), v)
  tearDownForeignThreadGc()

proc contains_v4_polyline*(s: cstring, v: Vector4): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = contains(polyline4FromJson($s), v)
  tearDownForeignThreadGc()

proc containsPoint_v2_polyline*(s: cstring, v: Vector2): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = containsPoint(polyline2FromJson($s), v)
  tearDownForeignThreadGc()

proc containsPoint_v3_polyline*(s: cstring, v: Vector3): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = containsPoint(polyline3FromJson($s), v)
  tearDownForeignThreadGc()

proc containsPoint_v4_polyline*(s: cstring, v: Vector4): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = containsPoint(polyline4FromJson($s), v)
  tearDownForeignThreadGc()

proc equals_v2_polyline*(s1, s2: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = polyline2FromJson($s1) == polyline2FromJson($s2)
  tearDownForeignThreadGc()

proc equals_v3_polyline*(s1, s2: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = polyline3FromJson($s1) == polyline3FromJson($s2)
  tearDownForeignThreadGc()

proc equals_v4_polyline*(s1, s2: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = polyline4FromJson($s1) == polyline4FromJson($s2)
  tearDownForeignThreadGc()

proc hash_v2_polyline*(s: cstring): int {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = hash(polyline2FromJson($s))
  tearDownForeignThreadGc()

proc hash_v3_polyline*(s: cstring): int {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = hash(polyline3FromJson($s))
  tearDownForeignThreadGc()

proc hash_v4_polyline*(s: cstring): int {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = hash(polyline4FromJson($s))
  tearDownForeignThreadGc()

proc dimension_v2_polyline*(s: cstring): int {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = dimension(polyline2FromJson($s))
  tearDownForeignThreadGc()

proc dimension_v3_polyline*(s: cstring): int {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = dimension(polyline3FromJson($s))
  tearDownForeignThreadGc()

proc dimension_v4_polyline*(s: cstring): int {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = dimension(polyline4FromJson($s))
  tearDownForeignThreadGc()

proc copy_v2_polyline*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(copy(polyline2FromJson($s)))
  tearDownForeignThreadGc()

proc copy_v3_polyline*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(copy(polyline3FromJson($s)))
  tearDownForeignThreadGc()

proc copy_v4_polyline*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(copy(polyline4FromJson($s)))
  tearDownForeignThreadGc()

proc stringify_v2_polyline*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = $polyline2FromJson($s)
  tearDownForeignThreadGc()

proc stringify_v3_polyline*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = $polyline3FromJson($s)
  tearDownForeignThreadGc()

proc stringify_v4_polyline*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = $polyline4FromJson($s)
  tearDownForeignThreadGc()

proc average_v2_polyline*(s: cstring): Vector2 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = average(polyline2FromJson($s))
  tearDownForeignThreadGc()

proc average_v3_polyline*(s: cstring): Vector3 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = average(polyline3FromJson($s))
  tearDownForeignThreadGc()

proc average_v4_polyline*(s: cstring): Vector4 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = average(polyline4FromJson($s))
  tearDownForeignThreadGc()

proc closestVertex_v2_polyline*(s: cstring, v: Vector2): Vector2 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = closestVertex(polyline2FromJson($s), v)
  tearDownForeignThreadGc()

proc closestVertex_v3_polyline*(s: cstring, v: Vector3): Vector3 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = closestVertex(polyline3FromJson($s), v)
  tearDownForeignThreadGc()

proc closestVertex_v4_polyline*(s: cstring, v: Vector4): Vector4 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = closestVertex(polyline4FromJson($s), v)
  tearDownForeignThreadGc()

proc toPolygon_v2_polyline*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(toPolygon(polyline2FromJson($s)))
  tearDownForeignThreadGc()

proc toPolygon_v3_polyline*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(toPolygon(polyline3FromJson($s)))
  tearDownForeignThreadGc()

proc toPolygon_v4_polyline*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(toPolygon(polyline4FromJson($s)))
  tearDownForeignThreadGc()

proc closestPoint_v2_polyline*(s: cstring, v: Vector2): Vector2 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = closestPoint(polyline2FromJson($s), v)
  tearDownForeignThreadGc()

proc closestPoint_v3_polyline*(s: cstring, v: Vector3): Vector3 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = closestPoint(polyline3FromJson($s), v)
  tearDownForeignThreadGc()

proc closestPoint_v4_polyline*(s: cstring, v: Vector4): Vector4 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = closestPoint(polyline4FromJson($s), v)
  tearDownForeignThreadGc()
  
# Transforms
proc rotate_v2_polyline*(s: cstring, theta: cdouble): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  var p = polyline2FromJson($s)
  result = toJson(rotate(p, theta))
  tearDownForeignThreadGc()

proc rotate_v3_polyline*(s: cstring, theta: cdouble): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  var p = polyline3FromJson($s)
  result = toJson(rotate(p, theta))
  tearDownForeignThreadGc()

proc rotate_v4_polyline*(s: cstring, theta: cdouble): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  var p = polyline4FromJson($s)
  result = toJson(rotate(p, theta))
  tearDownForeignThreadGc()

proc scale_v2_polyline*(s: cstring, sx, sy: cdouble): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  var p = polyline2FromJson($s)
  result = toJson(scale(p, sx, sy))
  tearDownForeignThreadGc()

proc scale_v3_polyline*(s: cstring, sx, sy, sz: cdouble): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  var p = polyline3FromJson($s)
  result = toJson(scale(p, sx, sy, sz))
  tearDownForeignThreadGc()

proc scale_v4_polyline*(s: cstring, sx, sy, sz, sw: cdouble): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  var p = polyline4FromJson($s)
  result = toJson(scale(p, sx, sy, sz, sw))
  tearDownForeignThreadGc()

proc translate_v2_polyline*(s: cstring, v: Vector2): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  var p = polyline2FromJson($s)
  result = toJson(translate(p, v))
  tearDownForeignThreadGc()

proc translate_v3_polyline*(s: cstring, v: Vector3): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  var p = polyline3FromJson($s)
  result = toJson(translate(p, v))
  tearDownForeignThreadGc()

proc translate_v4_polyline*(s: cstring, v: Vector4): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  var p = polyline4FromJson($s)
  result = toJson(translate(p, v))
  tearDownForeignThreadGc()

proc transform_v2_polyline*(s: cstring, m: Matrix33): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  var p = polyline2FromJson($s)
  result = toJson(transform(p, m))
  tearDownForeignThreadGc()

proc transform_v3_polyline*(s: cstring, m: Matrix44): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  var p = polyline3FromJson($s)
  result = toJson(transform(p, m))
  tearDownForeignThreadGc()

proc transform_v4_polyline*(s: cstring, m: Matrix44): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  var p = polyline4FromJson($s)
  result = toJson(transform(p, m))
  tearDownForeignThreadGc()
