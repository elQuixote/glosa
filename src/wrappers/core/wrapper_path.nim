import ../../core/path
import ../../core/vector
import ../../core/curve
import json
import ../../core/polygon
from ../../core/matrix import Matrix44, Matrix33, IDMATRIX44
from random import rand

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
  GC_disable()
  result = areClosed(polyline2FromJson($s).segments)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc areClosed_v3_segment*(s: cstring): bool {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  result = areClosed(polyline3FromJson($s).segments)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc areClosed_v4_segment*(s: cstring): bool {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  result = areClosed(polyline4FromJson($s).segments)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# ***************************************
#     Polyline Proc Wrappers
# ***************************************
proc areClosed_v2_vertices*(s: cstring): bool {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  result = areClosed(polyline2FromJson($s).vertices)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc areClosed_v3_vertices*(s: cstring): bool {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  result = areClosed(polyline3FromJson($s).vertices)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc areClosed_v4_vertices*(s: cstring): bool {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  result = areClosed(polyline4FromJson($s).vertices)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Constructors
proc polyline_v1*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(polyline1FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc polyline_v2*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(polyline2FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc polyline_v3*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(polyline3FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc polyline_v4*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(polyline4FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# IsClosed
proc isClosed_v2_polyline*(s: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = isClosed(polyline2FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc isClosed_v3_polyline*(s: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = isClosed(polyline3FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc isClosed_v4_polyline*(s: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = isClosed(polyline4FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Reverse
proc reverse_v2_polyline*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = polyline2FromJson($s)
  result = toJson(reverse(p))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc reverse_v3_polyline*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = polyline3FromJson($s)
  result = toJson(reverse(p))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc reverse_v4_polyline*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = polyline4FromJson($s)
  result = toJson(reverse(p))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Contains
# NOTE: Contains is causing a segfault when chained with other wrapper procs in .net
proc contains_v2_polyline*(s: cstring, v: Vector2): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = contains(polyline2FromJson($s), v)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc contains_v3_polyline*(s: cstring, v: Vector3): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = contains(polyline3FromJson($s), v)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc contains_v4_polyline*(s: cstring, v: Vector4): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = contains(polyline4FromJson($s), v)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# ContainsPoint
proc containsPoint_v2_polyline*(s: cstring, v: Vector2): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = containsPoint(polyline2FromJson($s), v)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc containsPoint_v3_polyline*(s: cstring, v: Vector3): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = containsPoint(polyline3FromJson($s), v)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc containsPoint_v4_polyline*(s: cstring, v: Vector4): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = containsPoint(polyline4FromJson($s), v)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Equality
proc equals_v2_polyline*(s1, s2: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = polyline2FromJson($s1) == polyline2FromJson($s2)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc equals_v3_polyline*(s1, s2: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = polyline3FromJson($s1) == polyline3FromJson($s2)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc equals_v4_polyline*(s1, s2: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = polyline4FromJson($s1) == polyline4FromJson($s2)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Hash
proc hash_v2_polyline*(s: cstring): int {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = hash(polyline2FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc hash_v3_polyline*(s: cstring): int {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = hash(polyline3FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc hash_v4_polyline*(s: cstring): int {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = hash(polyline4FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Dimension
proc dimension_v2_polyline*(s: cstring): int {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = dimension(polyline2FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc dimension_v3_polyline*(s: cstring): int {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = dimension(polyline3FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc dimension_v4_polyline*(s: cstring): int {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = dimension(polyline4FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Copy
proc copy_v2_polyline*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(copy(polyline2FromJson($s)))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc copy_v3_polyline*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(copy(polyline3FromJson($s)))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc copy_v4_polyline*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(copy(polyline4FromJson($s)))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Stringify
proc stringify_v2_polyline*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = $polyline2FromJson($s)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc stringify_v3_polyline*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = $polyline3FromJson($s)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc stringify_v4_polyline*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = $polyline4FromJson($s)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Average
proc average_v2_polyline*(s: cstring): Vector2 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = average(polyline2FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc average_v3_polyline*(s: cstring): Vector3 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = average(polyline3FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc average_v4_polyline*(s: cstring): Vector4 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = average(polyline4FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# ClosestVertex
proc closestVertex_v2_polyline*(s: cstring, v: Vector2): Vector2 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = closestVertex(polyline2FromJson($s), v)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc closestVertex_v3_polyline*(s: cstring, v: Vector3): Vector3 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = closestVertex(polyline3FromJson($s), v)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc closestVertex_v4_polyline*(s: cstring, v: Vector4): Vector4 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = closestVertex(polyline4FromJson($s), v)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# ToPolygon
proc toPolygon_v2_polyline*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(toPolygon(polyline2FromJson($s)))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc toPolygon_v3_polyline*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(toPolygon(polyline3FromJson($s)))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc toPolygon_v4_polyline*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(toPolygon(polyline4FromJson($s)))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# ClosestPoint
proc closestPoint_v2_polyline*(s: cstring, v: Vector2): Vector2 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = closestPoint(polyline2FromJson($s), v)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc closestPoint_v3_polyline*(s: cstring, v: Vector3): Vector3 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = closestPoint(polyline3FromJson($s), v)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc closestPoint_v4_polyline*(s: cstring, v: Vector4): Vector4 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = closestPoint(polyline4FromJson($s), v)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()
  
# Transforms
# Rotate
proc rotate_v2_polyline*(s: cstring, theta: cdouble): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = polyline2FromJson($s)
  result = toJson(rotate(p, theta))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc rotate_v3_polyline*(s: cstring, axis: Vector3, theta: cdouble): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = polyline3FromJson($s)
  result = toJson(rotate(p, axis, theta))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc rotate_v4_polyline*(s: cstring, b1, b2: Vector4, theta: cdouble, b3, b4: Vector4, phi: cdouble): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = polyline4FromJson($s)
  result = toJson(rotate(p, b1, b2, theta, b3, b4, phi))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Scale
proc scale_v2_polyline*(s: cstring, sx, sy: cdouble): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = polyline2FromJson($s)
  result = toJson(scale(p, sx, sy))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc scale_v3_polyline*(s: cstring, sx, sy, sz: cdouble): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = polyline3FromJson($s)
  result = toJson(scale(p, sx, sy, sz))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc scale_v4_polyline*(s: cstring, sx, sy, sz, sw: cdouble): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = polyline4FromJson($s)
  result = toJson(scale(p, sx, sy, sz, sw))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Translate
proc translate_v2_polyline*(s: cstring, v: Vector2): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = polyline2FromJson($s)
  result = toJson(translate(p, v))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc translate_v3_polyline*(s: cstring, v: Vector3): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = polyline3FromJson($s)
  result = toJson(translate(p, v))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc translate_v4_polyline*(s: cstring, v: Vector4): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = polyline4FromJson($s)
  result = toJson(translate(p, v))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Transform
proc transform_v2_polyline*(s: cstring, m: Matrix33): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = polyline2FromJson($s)
  result = toJson(transform(p, m))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc transform_v3_polyline*(s: cstring, m: Matrix44): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = polyline3FromJson($s)
  result = toJson(transform(p, m))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc transform_v4_polyline*(s: cstring, m: Matrix44): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  var p = polyline4FromJson($s)
  result = toJson(transform(p, m))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# ***************************************
#     Nurbs Proc Wrappers
# ***************************************

# Constructors
# NOTE: In stable build cannot succesfuly interpolate curve!
proc interpolateCurve_v2_curve*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(nurbsCurve2InterpolationFromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# NOTE: In stable build cannot succesfuly interpolate curve!
proc interpolateCurve_v3_curve*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(nurbsCurve3InterpolationFromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc nurbsCurve_v2_curve*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(nurbsCurve2FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc nurbsCurve_v3_curve*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(nurbsCurve3FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Homogenize
proc homogenize_v1_curve*(p: Vector1, weight: cdouble): Vector2 {.cdecl, exportc, dynlib.} = homogenize(p, weight)
proc homogenize_v2_curve*(p: Vector2, weight: cdouble): Vector3 {.cdecl, exportc, dynlib.} = homogenize(p, weight)
proc homogenize_v3_curve*(p: Vector3, weight: cdouble): Vector4 {.cdecl, exportc, dynlib.} = homogenize(p, weight)

proc homogenizeArray_v1_curve*(s1: cstring, s2: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(homogenize(mapVector1Seq($s1),mapFloatSeq($s2)))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc homogenizeArray_v2_curve*(s1: cstring, s2: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(homogenize(mapVector2Seq($s1),mapFloatSeq($s2)))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc homogenizeArray_v3_curve*(s1: cstring, s2: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(homogenize(mapVector3Seq($s1),mapFloatSeq($s2)))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc dehomogenize_v1_curve*(p: Vector2): Vector1 {.cdecl, exportc, dynlib.} = dehomogenize(p)
proc dehomogenize_v2_curve*(p: Vector3): Vector2 {.cdecl, exportc, dynlib.} = dehomogenize(p)
proc dehomogenize_v3_curve*(p: Vector4): Vector3 {.cdecl, exportc, dynlib.} = dehomogenize(p)

proc dehomogenizeArray_v2_curve*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(dehomogenize(mapVector2Seq($s)))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc dehomogenizeArray_v3_curve*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(dehomogenize(mapVector3Seq($s)))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc dehomogenizeArray_v4_curve*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(dehomogenize(mapVector4Seq($s)))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Weights
proc weight_v2_curve*(p: Vector2): cdouble {.cdecl, exportc, dynlib.} = weight(p)
proc weight_v3_curve*(p: Vector3): cdouble {.cdecl, exportc, dynlib.} = weight(p)
proc weight_v4_curve*(p: Vector4): cdouble {.cdecl, exportc, dynlib.} = weight(p)

proc weights_v2_curve*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(weights(mapVector2Seq($s)))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc weights_v3_curve*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(weights(mapVector3Seq($s)))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc weights_v4_curve*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(weights(mapVector4Seq($s)))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Equality
proc interpEquals_v2_curve*(s1, s2: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = nurbsCurve2InterpolationFromJson($s1) == nurbsCurve2InterpolationFromJson($s2)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc interpEquals_v3_curve*(s1, s2: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = nurbsCurve3InterpolationFromJson($s1) == nurbsCurve3InterpolationFromJson($s2)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc equals_v2_curve*(s1, s2: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = nurbsCurve2FromJson($s1) == nurbsCurve2FromJson($s2)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc equals_v3_curve*(s1, s2: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = nurbsCurve3FromJson($s1) == nurbsCurve3FromJson($s2)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Weighted CPs
proc weightedControlPoints_v2_curve*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(weightedControlPoints(nurbsCurve2FromJson($s)))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc weightedControlPoints_v3_curve*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(weightedControlPoints(nurbsCurve3FromJson($s)))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Sample
proc rationalSample_v2_curve*(s: cstring, u: cdouble): Vector3 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = rationalSample(nurbsCurve2FromJson($s), u)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc rationalSample_v3_curve*(s: cstring, u: cdouble): Vector4 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = rationalSample(nurbsCurve3FromJson($s), u)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# NOTE: wrapping rationalRegularSampleWithParameter requires a mapping for seq[tuple[]]
# TODO: Add JsonMappings
proc rationalRegularSample_v2_curve*(s: cstring, n: int): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(rationalRegularSample(nurbsCurve2FromJson($s), n))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc rationalRegularSample_v3_curve*(s: cstring, n: int): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(rationalRegularSample(nurbsCurve3FromJson($s), n))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc rationalSampleDerrivatives_v2_curve*(s: cstring, u: cdouble, n: int): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(rationalSampleDerivatives(nurbsCurve2FromJson($s), u, n))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc rationalSampleDerrivatives_v3_curve*(s: cstring, u: cdouble, n: int): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(rationalSampleDerivatives(nurbsCurve3FromJson($s), u, n))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc sample_v2_curve*(s: cstring, u: cdouble): Vector2 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = sample(nurbsCurve2FromJson($s), u)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc sample_v3_curve*(s: cstring, u: cdouble): Vector3 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = sample(nurbsCurve3FromJson($s), u)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# NOTE: Do we want a nurbscurve4fromJson??
# proc sample_v4_curve*(s: cstring, u: cdouble): Vector4 {.cdecl, exportc, dynlib.} = 
#   setupForeignThreadGc()
  GC_disable()
#   result = sample(nurbsCurve4FromJson($s), u)
#   GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc regularSample_v2_curve*(s: cstring, ustart, uend: cdouble, n: int): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(regularSample(nurbsCurve2FromJson($s), ustart, uend, n))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc regularSample_v3_curve*(s: cstring, ustart, uend: cdouble, n: int): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(regularSample(nurbsCurve3FromJson($s), ustart, uend, n))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc regularSample2_v2_curve*(s: cstring, n: int): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(regularSample(nurbsCurve2FromJson($s), n))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc regularSample2_v3_curve*(s: cstring, n: int): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(regularSample(nurbsCurve3FromJson($s), n))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc sampleDerivatives_v2_curve*(s: cstring, u: cdouble, n: int): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(sampleDerivatives(nurbsCurve2FromJson($s), u, n))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc sampleDerivatives_v3_curve*(s: cstring, u: cdouble, n: int): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  GC_disable()
  result = toJson(sampleDerivatives(nurbsCurve3FromJson($s), u, n))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Closest Parameter
proc rationalClosestParameter_v2_curve*(s: cstring, v: Vector2): cdouble {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  result = rationalClosestParameter(nurbsCurve2FromJson($s), v)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc rationalClosestParameter_v3_curve*(s: cstring, v: Vector3): cdouble {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  result = rationalClosestParameter(nurbsCurve3FromJson($s), v)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc closestParameter_v2_curve*(s: cstring, v: Vector2): cdouble {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  result = closestParameter(nurbsCurve2FromJson($s), v)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc closestParameter_v3_curve*(s: cstring, v: Vector3): cdouble {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  result = closestParameter(nurbsCurve3FromJson($s), v)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# ClosestPoint
proc closestPoint_v2_curve*(s: cstring, v: Vector2): Vector2 {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  result = closestPoint(nurbsCurve2FromJson($s), v)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc closestPoint_v3_curve*(s: cstring, v: Vector3): Vector3 {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  result = closestPoint(nurbsCurve3FromJson($s), v)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Transform
proc transform_v2_curve*(s: cstring, m: Matrix33): cstring {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  result = toJson(transform(nurbsCurve2FromJson($s), m))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc transform_v3_curve*(s: cstring, m: Matrix44): cstring {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  result = toJson(transform(nurbsCurve3FromJson($s), m))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Rotate
proc rotate_v2_curve*(s: cstring, theta: cdouble): cstring {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  result = toJson(rotate(nurbsCurve2FromJson($s), theta))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc rotate_v3_curve*(s: cstring, axis: Vector3, theta: cdouble): cstring {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  result = toJson(rotate(nurbsCurve3FromJson($s), axis, theta))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Scale
proc scale_v2_curve*(s: cstring, sx, sy: cdouble): cstring {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  result = toJson(scale(nurbsCurve2FromJson($s), sx, sy))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc scale_v3_curve*(s: cstring, sx, sy, sz: cdouble): cstring {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  result = toJson(scale(nurbsCurve3FromJson($s), sx, sy, sz))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Translate
proc translate_v2_curve*(s: cstring, v: Vector2): cstring {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  result = toJson(translate(nurbsCurve2FromJson($s), v))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc translate_v3_curve*(s: cstring, v: Vector3): cstring {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  result = toJson(translate(nurbsCurve3FromJson($s), v))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Hash
proc hash_v2_curve*(s: cstring): int {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  result = hash(nurbsCurve2FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc hash_v3_curve*(s: cstring): int {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  result = hash(nurbsCurve3FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Dimension
proc dimension_v2_curve*(s: cstring): int {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  result = dimension(nurbsCurve2FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc dimension_v3_curve*(s: cstring): int {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  result = dimension(nurbsCurve3FromJson($s))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Copy
proc copy_v2_curve*(s: cstring): cstring {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  result = toJson(copy(nurbsCurve2FromJson($s)))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc copy_v3_curve*(s: cstring): cstring {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  result = toJson(copy(nurbsCurve3FromJson($s)))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

# Stringify
proc stringify_v2_curve*(s: cstring): cstring {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  result = $nurbsCurve2FromJson($s)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc stringify_v3_curve*(s: cstring): cstring {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  result = $nurbsCurve3FromJson($s)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc SampleCurve*(s: cstring, c: int): cstring {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  var 
    list : seq[Vector3] = @[]
    curve = nurbsCurve3FromJson($s)
  for i in 0..c:
    var vec2 = vector3((float)rand(10), (float)rand(10), (float)rand(10))   
    list.add(closestPoint(curve, vec2))
  result = toJson(list)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc SampleCurve_Base*(s: cstring, c: int) {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  var 
    list : seq[Vector3] = @[]
    curve = nurbsCurve3FromJson($s)
  for i in 0..c:
    var vec2 = vector3((float)rand(10), (float)rand(10), (float)rand(10))   
    list.add(closestPoint(curve, vec2))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc SamplePolyline*(s: cstring, c: int): cstring {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  var 
    list : seq[Vector3] = @[]
    pline = polyline3FromJson($s)
  for i in 0..c:
    var vec2 = vector3((float)rand(10), (float)rand(10), (float)rand(10))   
    list.add(closestPoint(pline, vec2))
  result = toJson(list)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc SamplePolyline_Base*(s: cstring, c: int) {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  var 
    list : seq[Vector3] = @[]
    pline = polyline3FromJson($s)
  for i in 0..c:
    var vec2 = vector3((float)rand(10), (float)rand(10), (float)rand(10))   
    list.add(closestPoint(pline, vec2))
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc MultiTransform*(s: cstring, c: int): cstring {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  var pline = polyline3FromJson($s)
  for i in 0..<c:
    discard pline.transform(IDMATRIX44)
  result = toJson(pline)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()

proc MultiTransform_Base*(s: cstring, c: int) {.cdecl, exportc, dynlib.} =
  setupForeignThreadGc()
  GC_disable()
  var pline = polyline3FromJson($s)
  for i in 0..<c:
    discard pline.transform(IDMATRIX44)
  GC_enable()
  GC_fullCollect()
  tearDownForeignThreadGc()
