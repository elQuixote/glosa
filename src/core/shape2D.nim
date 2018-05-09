from ./concepts import
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

from ./Vector import Vector2

type
  Circle* = object
    center*: Vector2
    radius*: float
  Polygon* = object
    vertices*: seq[Vector]
  Sphere* = object
    center*: Vector2
    radius*: float

# Polygon
# Constuctors
proc polygon*(points: seq[Vector]): Polygon =
  result.vertices = @[]
  result.vertices = points

proc polygon*(): Polygon =
  result.vertices = @[]
