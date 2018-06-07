import ../../core/path
import ../../core/vector
import ../../core/curve
import json
import ../../core/polygon
from ../../core/matrix import Matrix44, Matrix33

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

# IsClosed
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

# Reverse
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

# Contains
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

# ContainsPoint
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

# Equality
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

# Hash
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

# Dimension
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

# Copy
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

# Stringify
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

# Average
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

# ClosestVertex
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

# ToPolygon
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

# ClosestPoint
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
# Rotate
proc rotate_v2_polyline*(s: cstring, theta: cdouble): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  var p = polyline2FromJson($s)
  result = toJson(rotate(p, theta))
  tearDownForeignThreadGc()

proc rotate_v3_polyline*(s: cstring, axis: Vector3, theta: cdouble): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  var p = polyline3FromJson($s)
  result = toJson(rotate(p, axis, theta))
  tearDownForeignThreadGc()

proc rotate_v4_polyline*(s: cstring, b1, b2: Vector4, theta: cdouble, b3, b4: Vector4, phi: cdouble): cstring {.cdecl, exportc, noinit, dynlib.} = 
  setupForeignThreadGc()
  var p = polyline4FromJson($s)
  result = toJson(rotate(p, b1, b2, theta, b3, b4, phi))
  tearDownForeignThreadGc()

# Scale
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

# Translate
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

# Transform
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

# ***************************************
#     Nurbs Proc Wrappers
# ***************************************

# Constructors
# NOTE: In stable build cannot succesfuly interpolate curve!
proc interpolateCurve_v2_curve*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(nurbsCurve2InterpolationFromJson($s))
  tearDownForeignThreadGc()

# NOTE: In stable build cannot succesfuly interpolate curve!
proc interpolateCurve_v3_curve*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(nurbsCurve3InterpolationFromJson($s))
  tearDownForeignThreadGc()

proc nurbsCurve_v2_curve*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(nurbsCurve2FromJson($s))
  tearDownForeignThreadGc()

proc nurbsCurve_v3_curve*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(nurbsCurve3FromJson($s))
  tearDownForeignThreadGc()

# Homogenize
proc homogenize_v1_curve*(p: Vector1, weight: cdouble): Vector2 {.cdecl, exportc, dynlib.} = homogenize(p, weight)
proc homogenize_v2_curve*(p: Vector2, weight: cdouble): Vector3 {.cdecl, exportc, dynlib.} = homogenize(p, weight)
proc homogenize_v3_curve*(p: Vector3, weight: cdouble): Vector4 {.cdecl, exportc, dynlib.} = homogenize(p, weight)

proc homogenizeArray_v1_curve*(s1: cstring, s2: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(homogenize(mapVector1Seq($s1),mapFloatSeq($s2)))
  tearDownForeignThreadGc()

proc homogenizeArray_v2_curve*(s1: cstring, s2: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(homogenize(mapVector2Seq($s1),mapFloatSeq($s2)))
  tearDownForeignThreadGc()

proc homogenizeArray_v3_curve*(s1: cstring, s2: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(homogenize(mapVector3Seq($s1),mapFloatSeq($s2)))
  tearDownForeignThreadGc()

proc dehomogenize_v1_curve*(p: Vector2): Vector1 {.cdecl, exportc, dynlib.} = dehomogenize(p)
proc dehomogenize_v2_curve*(p: Vector3): Vector2 {.cdecl, exportc, dynlib.} = dehomogenize(p)
proc dehomogenize_v3_curve*(p: Vector4): Vector3 {.cdecl, exportc, dynlib.} = dehomogenize(p)

proc dehomogenizeArray_v2_curve*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(dehomogenize(mapVector2Seq($s)))
  tearDownForeignThreadGc()

proc dehomogenizeArray_v3_curve*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(dehomogenize(mapVector3Seq($s)))
  tearDownForeignThreadGc()

proc dehomogenizeArray_v4_curve*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(dehomogenize(mapVector4Seq($s)))
  tearDownForeignThreadGc()

# Weights
proc weight_v2_curve*(p: Vector2): cdouble {.cdecl, exportc, dynlib.} = weight(p)
proc weight_v3_curve*(p: Vector3): cdouble {.cdecl, exportc, dynlib.} = weight(p)
proc weight_v4_curve*(p: Vector4): cdouble {.cdecl, exportc, dynlib.} = weight(p)

proc weights_v2_curve*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(weights(mapVector2Seq($s)))
  tearDownForeignThreadGc()

proc weights_v3_curve*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(weights(mapVector3Seq($s)))
  tearDownForeignThreadGc()

proc weights_v4_curve*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(weights(mapVector4Seq($s)))
  tearDownForeignThreadGc()

# Equality
proc interpEquals_v2_curve*(s1, s2: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = nurbsCurve2InterpolationFromJson($s1) == nurbsCurve2InterpolationFromJson($s2)
  tearDownForeignThreadGc()

proc interpEquals_v3_curve*(s1, s2: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = nurbsCurve3InterpolationFromJson($s1) == nurbsCurve3InterpolationFromJson($s2)
  tearDownForeignThreadGc()

proc equals_v2_curve*(s1, s2: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = nurbsCurve2FromJson($s1) == nurbsCurve2FromJson($s2)
  tearDownForeignThreadGc()

proc equals_v3_curve*(s1, s2: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = nurbsCurve3FromJson($s1) == nurbsCurve3FromJson($s2)
  tearDownForeignThreadGc()

# Weighted CPs
proc weightedControlPoints_v2_curve*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(weightedControlPoints(nurbsCurve2FromJson($s)))
  tearDownForeignThreadGc()

proc weightedControlPoints_v3_curve*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(weightedControlPoints(nurbsCurve3FromJson($s)))
  tearDownForeignThreadGc()

# Sample
proc rationalSample_v2_curve*(s: cstring, u: cdouble): Vector3 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = rationalSample(nurbsCurve2FromJson($s), u)
  tearDownForeignThreadGc()

proc rationalSample_v3_curve*(s: cstring, u: cdouble): Vector4 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = rationalSample(nurbsCurve3FromJson($s), u)
  tearDownForeignThreadGc()

# NOTE: wrapping rationalRegularSampleWithParameter requires a mapping for seq[tuple[]]
# TODO: Add JsonMappings
proc rationalRegularSample_v2_curve*(s: cstring, n: int): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(rationalRegularSample(nurbsCurve2FromJson($s), n))
  tearDownForeignThreadGc()

proc rationalRegularSample_v3_curve*(s: cstring, n: int): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(rationalRegularSample(nurbsCurve3FromJson($s), n))
  tearDownForeignThreadGc()

proc rationalSampleDerrivatives_v2_curve*(s: cstring, u: cdouble, n: int): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(rationalSampleDerivatives(nurbsCurve2FromJson($s), u, n))
  tearDownForeignThreadGc()

proc rationalSampleDerrivatives_v3_curve*(s: cstring, u: cdouble, n: int): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(rationalSampleDerivatives(nurbsCurve3FromJson($s), u, n))
  tearDownForeignThreadGc()

proc sample_v2_curve*(s: cstring, u: cdouble): Vector2 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = sample(nurbsCurve2FromJson($s), u)
  tearDownForeignThreadGc()

proc sample_v3_curve*(s: cstring, u: cdouble): Vector3 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = sample(nurbsCurve3FromJson($s), u)
  tearDownForeignThreadGc()

# NOTE: Do we want a nurbscurve4fromJson??
# proc sample_v4_curve*(s: cstring, u: cdouble): Vector4 {.cdecl, exportc, dynlib.} = 
#   setupForeignThreadGc()
#   result = sample(nurbsCurve4FromJson($s), u)
#   tearDownForeignThreadGc()

proc regularSample_v2_curve*(s: cstring, ustart, uend: cdouble, n: int): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(regularSample(nurbsCurve2FromJson($s), ustart, uend, n))
  tearDownForeignThreadGc()

proc regularSample_v3_curve*(s: cstring, ustart, uend: cdouble, n: int): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(regularSample(nurbsCurve3FromJson($s), ustart, uend, n))
  tearDownForeignThreadGc()

proc regularSample2_v2_curve*(s: cstring, n: int): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(regularSample(nurbsCurve2FromJson($s), n))
  tearDownForeignThreadGc()

proc regularSample2_v3_curve*(s: cstring, n: int): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(regularSample(nurbsCurve3FromJson($s), n))
  tearDownForeignThreadGc()
