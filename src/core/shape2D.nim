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

# NOTE: This is added from design doc
proc addVertex*(polygon: var Polygon, x, y: float): Polygon = 
  polygon.vertices.add(vector2(x, y))
  result = polygon

proc addVertex*(polygon: var Polygon, x, y, z: float): Polygon = 
  polygon.vertices.add(vector3(x, y, z))
  result = polygon

proc addVertex*(polygon: var Polygon, v: Vector): Polygon =
  polygon.vertices.add(v)
  result = polygon
  