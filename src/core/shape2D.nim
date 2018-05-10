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
proc addVertex*(polygon: var Polygon, x, y: float): Polygon = 
  if not poly.contains(vector2(x,y)):
    polygon.vertices.add(vector2(x, y))
  else: raise newException(AccessViolationError, "Attempting to add a vertex which alreaday exists")
  result = polygon

proc addVertex*(polygon: var Polygon, x, y, z: float): Polygon = 
  if not poly.contains(vector3(x,y,z)):
    polygon.vertices.add(vector3(x, y, z))
  else: raise newException(AccessViolationError, "Attempting to add a vertex which alreaday exists")
  result = polygon

proc addVertex*(polygon: var Polygon, v: Vector): Polygon =
  if not poly.contains(v):
    polygon.vertices.add(v)
  else: raise newException(AccessViolationError, "Attempting to add a vertex which alreaday exists")
  result = polygon

# NOTE: This is added from design doc
proc contains*(polygon: var Polygon, v: Vector): bool =
  var hit : bool
  for vert in polygon.vertices:
    if vert == v:
      hit = true
      break
    else: hit = false
  result = hit

  