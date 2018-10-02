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
  #Matrix

from ./types import
  Vector,
  Matrix,
  Circle

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
  Circle

from math import arctan2, arccos, sqrt, TAU, PI
from strformat import `&`
import hashes
import json

from ./vector import
  vector2,
  vector3,
  vector4,
  cross,
  dimension,
  distanceTo,
  distanceToSquared,
  clear,
  #copy,
  interpolateTo,
  magnitude,
  transform

# const
#   UNIT_CIRCLE_2D = Circle(center: Vector2(x: 0.0, y: 0.0), radius: 1.0)
#   UNIT_CIRCLE_3D = Circle(center: Vector3(x: 0.0, y: 0.0, z: 0.0), radius: 1.0)

# Constructors
proc circle*[N: static[int], T](v: Vector[N, T], r: float): Circle[N, T] =
  result.center = v
  result.radius = r

# From individual coordinates
proc circle*[N: static[int], T](x, y, r: float): Circle[N, T] =
  result.center = vector2(x, y)
  result.radius = r

proc circle*[N: static[int], T](x, y, z, r: float): Circle[N, T] =
  result.center = vector3(x, y, z)
  result.radius = r

# From 2 Points (interpolated)
proc circle*[N: static[int], T](v1, v2: Vector[N, T]): Circle[N, T] =
  let v = interpolateTo(v1, v2, 0.5)
  result.center = v
  result.radius = distanceTo(v, v2)

proc containsPoint*[N: static[int], T](c: Circle[N, T], v: Vector[N, T]): bool =
  result = distanceToSquared(c.center, v) <= c.radius * c.radius

# Shape2
proc area*[N: static[int], T](c: Circle[N, T]): float =
  result = PI * (c.radius * c.radius)

proc circumference*[N: static[int], T](c: Circle[N, T]): float =
  result = TAU * c.radius

proc perimeter*[N: static[int], T](c: Circle[N, T]): float = circumference(c)

# Centroid
proc centroid*[N: static[int], T](c: Circle[N, T]): Vector[N, T] =
  result = c.center

# Average
proc average*[N: static[int], T](c: Circle[N, T]): Vector[N, T] =
  result = centroid(c)

# Closest Point
# Closest point to circle in 2D
proc closestPoint*[N: static[int], T](c: Circle[N, T], v: Vector[N, T]): Vector[N, T] =
  let
    d = v - c.center
    m = magnitude(d)
  result = c.center + c.radius * d / m

# Equals
proc `==`*[N: static[int], T](c1,c2: Circle[N, T]): bool =
  result = (c1.radius == c2.radius) and (c1.center == c2.center)

# Non Equals
proc `!=`*[N: static[int], T](c1, c2: Circle[N, T]): bool =
  result = not (c1 == c2)

# Hash
proc hash*[N: static[int], T](c: Circle[N, T]): hashes.Hash =
  result = !$(result !& hash(c.center.x) !& hash(c.center.y) !& hash(c.radius))

# Clear
proc clear*[T](c: var Circle[2, T]): var Circle[2, T] {.noinit.} =
  c.center = vector2(0, 0)
  c.radius = 1
  result = c

proc clear3*[T](c: var Circle[3, T]): var Circle[3, T] {.noinit.} =
  c.center = vector3(0, 0, 0)
  c.radius = 1
  result = c

proc clear4*[T](c: var Circle[4, T]): var Circle[4, T] {.noinit.} =
  c.center = vector4(0, 0, 0, 0)
  c.radius = 1
  result = c

# Dimension
proc dimension*[N: static[int], T](c: Circle[N, T]): int =
  result = dimension(c.center)

# Copy
proc copy*[N: static[int], T](c: Circle[N, T]): Circle[N, T] =
  result = Circle[Vector](center: copy(c.center), radius: c.radius)

# String
proc `$`*[N: static[int], T](c: Circle[N, T]): string =
  result = &"[center: [{$c.center}], radius: {c.radius}]"

# Transforms
# Rotate
proc rotate*[N: static[int], T](c: var Circle[N, T], theta: float): var Circle[N, T] {.noinit.} =
  result = c

# Scale
proc scale*[N: static[int], T](c: var Circle[N, T], s: float): var Circle[N, T] {.noinit.} =
  c.radius *= s
  result = c

# Translate
proc translate*[N: static[int], T](c: var Circle[N, T], t: float): var Circle[N, T] {.noinit.} =
  c.center += t
  result = c

# Transform
proc transform*[N, M: static[int], T](c: var Circle[N, T], m : Matrix[N, M, T]): var Circle[N, T] {.noinit.} =
  c.center = transform(c.center, m)
  result = c