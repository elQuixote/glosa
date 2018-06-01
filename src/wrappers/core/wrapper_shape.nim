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