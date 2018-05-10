from ./concepts import
Vector,
Equals,
Hash,
Transform,
Dimension,
Set,
Clear,
Copy,
String,
Centroid,
Shape2,
Closest,
Vertices

export
Vector,
Equals,
Hash,
Transform,
Dimension,
Set,
Clear,
Copy,
String,
Centroid,
Shape2,
Closest,
Vertices

from math import arctan2, arccos, sqrt
from strformat import `&`
import hashes

import ../../src/core/vector

type
  Circle* = object
    center*: Vector
    radius*: float
  Polygon* = object
    vertices*: seq[Vector]
  Sphere* = object
    center*: Vector
    radius*: float

# Polygon
# Constuctors
proc polygon*(points: seq[Vector]): Polygon =
  result.vertices = @[]
  result.vertices = points

proc polygon*(): Polygon =
  result.vertices = @[]

# ***************************************
#     Polygon implementation
# ***************************************
# NOTE: This is added from design doc
proc addVertex*(p: var Polygon, x, y: float): Polygon = 
  if not p.contains(vector2(x,y)):
    p.vertices.add(vector2(x, y))
  else: raise newException(AccessViolationError, "Attempting to add a vertex which alreaday exists")
  result = p

proc addVertex*(p: var Polygon, x, y, z: float): Polygon = 
  if not p.contains(vector3(x,y,z)):
    p.vertices.add(vector3(x, y, z))
  else: raise newException(AccessViolationError, "Attempting to add a vertex which alreaday exists")
  result = p

proc addVertex*(p: var Polygon, v: Vector): Polygon =
  if not p.contains(v):
    p.vertices.add(v)
  else: raise newException(AccessViolationError, "Attempting to add a vertex which alreaday exists")
  result = p

# NOTE: This is added from design doc
proc contains*(p: var Polygon, v: Vector): bool =
  var hit : bool
  for vert in p.vertices:
    if vert == v:
      hit = true
      break
    else: hit = false
  result = hit

# Equals (compares points in polygon)
proc `==`*(p1,p2: Polygon): bool =
  if len(p1.vertices) != len(p2.vertices): return false
  var hit : bool
  for i in 0..len(p1.vertices)-1:
    if p1.vertices[i] != p2.vertices[i]: return false
    else: hit = true
  result = hit

# Non Equals
proc `!=`*(p1,p2: Polygon): bool = 
result = not (p1 == p2)

# Hash
proc hash*(p: Polygon): hashes.Hash =
  for vert in p.vertices:
    result = !$(result !& hash(vert))


  