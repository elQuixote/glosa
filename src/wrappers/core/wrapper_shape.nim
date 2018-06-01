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
  result = toJson(circle2FromJson($s))
  tearDownForeignThreadGc()

proc circle_v3*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(circle3FromJson($s))
  tearDownForeignThreadGc()

proc circle_v4*(s: cstring): cstring {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = toJson(circle4FromJson($s))
  tearDownForeignThreadGc()

# Contains
proc contains_v2_circle*(s: cstring, v: Vector2): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = containsPoint(circle2FromJson($s), v)
  tearDownForeignThreadGc()

proc contains_v3_circle*(s: cstring, v: Vector3): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = containsPoint(circle3FromJson($s), v)
  tearDownForeignThreadGc()

proc contains_v4_circle*(s: cstring, v: Vector4): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = containsPoint(circle4FromJson($s), v)
  tearDownForeignThreadGc()

# Area
proc area_v2_circle*(s: cstring): cdouble {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = area(circle2FromJson($s))
  tearDownForeignThreadGc()

proc area_v3_circle*(s: cstring): cdouble {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = area(circle3FromJson($s))
  tearDownForeignThreadGc()

proc area_v4_circle*(s: cstring): cdouble {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = area(circle4FromJson($s))
  tearDownForeignThreadGc()

# Perimeter
proc perimeter_v2_circle*(s: cstring): cdouble {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = perimeter(circle2FromJson($s))
  tearDownForeignThreadGc()

proc perimeter_v3_circle*(s: cstring): cdouble {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = perimeter(circle3FromJson($s))
  tearDownForeignThreadGc()

proc perimeter_v4_circle*(s: cstring): cdouble {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = perimeter(circle4FromJson($s))
  tearDownForeignThreadGc()

# Circumference
proc circumference_v2_circle*(s: cstring): cdouble {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = circumference(circle2FromJson($s))
  tearDownForeignThreadGc()

proc circumference_v3_circle*(s: cstring): cdouble {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = circumference(circle3FromJson($s))
  tearDownForeignThreadGc()

proc circumference_v4_circle*(s: cstring): cdouble {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = circumference(circle4FromJson($s))
  tearDownForeignThreadGc()

# Centroid
proc centroid_v2_circle*(s: cstring): Vector2 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = centroid(circle2FromJson($s))
  tearDownForeignThreadGc()

proc centroid_v3_circle*(s: cstring): Vector3 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = centroid(circle3FromJson($s))
  tearDownForeignThreadGc()

proc centroid_v4_circle*(s: cstring): Vector4 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = centroid(circle4FromJson($s))
  tearDownForeignThreadGc()

# Average
proc average_v2_circle*(s: cstring): Vector2 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = average(circle2FromJson($s))
  tearDownForeignThreadGc()

proc average_v3_circle*(s: cstring): Vector3 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = average(circle3FromJson($s))
  tearDownForeignThreadGc()

proc average_v4_circle*(s: cstring): Vector4 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = average(circle4FromJson($s))
  tearDownForeignThreadGc()

# ClosestPoint
proc closestPoint_v2_circle*(s: cstring, v: Vector2): Vector2 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = closestPoint(circle2FromJson($s), v)
  tearDownForeignThreadGc()

proc closestPoint_v3_circle*(s: cstring, v: Vector3): Vector3 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = closestPoint(circle3FromJson($s), v)
  tearDownForeignThreadGc()

proc closestPoint_v4_circle*(s: cstring, v: Vector4): Vector4 {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = closestPoint(circle4FromJson($s), v)
  tearDownForeignThreadGc()

# Equality
proc equals_v2_circle*(s1, s2: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = circle2FromJson($s1) == circle2FromJson($s2)
  tearDownForeignThreadGc()

proc equals_v3_circle*(s1, s2: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = circle3FromJson($s1) == circle3FromJson($s2)
  tearDownForeignThreadGc()

proc equals_v4_circle*(s1, s2: cstring): bool {.cdecl, exportc, dynlib.} = 
  setupForeignThreadGc()
  result = circle4FromJson($s1) == circle4FromJson($s2)
  tearDownForeignThreadGc()