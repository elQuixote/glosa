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