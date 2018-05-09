from ./concepts import
Compare,
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
Compare,
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

from ./Vector import Vector2,Vector3

type
  Circle* = object
    center*: Vector2
    radius*: float
  Polygon* = object
    vertices*: seq[Vector2]
  Sphere* = object
    center*: Vector2
    radius*: float
    
    