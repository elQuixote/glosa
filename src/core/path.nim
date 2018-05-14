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

from ./types import
  Vector1,
  Vector2,
  Vector3,
  Vector4,
  Matrix33,
  Matrix44, 
  Polyline,
  LineSegment

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
  Vertices,
  Polyline,
  LineSegment

from math import arctan2, arccos, sqrt, TAU, PI
from strformat import `&`
import hashes

import ./vector
import ./matrix

# Constuctors
proc polyline*[Vector](points: seq[Vector]): Polyline[Vector] =
    result.vertices = @[]
    result.vertices = points
  
proc polyline*[Vector](): Polyline[Vector] =
result.vertices = @[]