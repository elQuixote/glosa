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
  Vertices,
  Matrix

from ./types import
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

from ./vector import
  vector2,
  vector3,
  cross,
  dimension,
  distanceTo,
  distanceToSquared,
  clear,
  copy,
  interpolateTo,
  magnitude

# const
#   UNIT_CIRCLE_2D = Circle(center: Vector2(x: 0.0, y: 0.0), radius: 1.0)
#   UNIT_CIRCLE_3D = Circle(center: Vector3(x: 0.0, y: 0.0, z: 0.0), radius: 1.0)

# Constructors
proc circle*[Vector](v: Vector, r: float): Circle =
  result.center = v
  result.radius = r

# From individual coordinates
proc circle*[Vector](x, y, r: float): Circle =
  result.center = vector2(x, y)
  result.radius = r

proc circle*[Vector](x, y, z, r: float): Circle =
  result.center = vector3(x, y, z)
  result.radius = r

# From 2 Points (interpolated)
proc circle*[Vector](v1, v2: Vector): Circle[Vector] =
  let v = interpolateTo(v1, v2, 0.5)
  result.center = v
  result.radius = distanceTo(v, v2)

proc containsPoint*[Vector](c: Circle[Vector], v: Vector): bool =
  result = distanceToSquared(c.center, v) <= c.radius * c.radius

# Shape2
proc area*[Vector](c: Circle[Vector]): float =
  result = PI * (c.radius * c.radius)

proc circumference*[Vector](c: Circle[Vector]): float =
  result = TAU * c.radius

proc perimeter*[Vector](c: Circle[Vector]): float = circumference(c)

# Centroid
proc centroid*[Vector](c: Circle[Vector]): Vector =
  result = c.center

# Average
proc average*[Vector](c: Circle[Vector]): Vector =
  result = centroid(c)

# Closest Point
# Closest point to circle in 2D
proc closestPoint*[Vector](c: Circle[Vector], v: Vector): Vector =
  let
    d = v - c.center
    m = magnitude(d)
  result = c.center + c.radius * d / m

# Equals
proc `==`*[Vector](c1,c2: Circle[Vector]): bool =
  result = (c1.radius == c2.radius) and (c1.center == c2.center)

# Non Equals
proc `!=`*[Vector](c1, c2: Circle[Vector]): bool =
  result = not (c1 == c2)

# Hash
proc hash*[Vector](c: Circle[Vector]): hashes.Hash =
  result = !$(result !& hash(c.center.x) !& hash(c.center.y) !& hash(c.radius))

# Clear
proc clear*[Vector](c: var Circle[Vector]): var Circle[Vector] {.noinit.} =
  c.center = vector2(0, 0)
  c.radius = 1
  result = c

# Dimension
proc dimension*[Vector](c: Circle[Vector]): int =
  result = dimension(c.center)

# Copy
proc copy*[Vector](c: Circle[Vector]): Circle[Vector] =
  result = Circle[Vector](center: copy(c.center), radius: c.radius)

# String
proc `$`*[Vector](c: Circle[Vector]): string =
  result = &"[center: [{$c.center}], radius: {c.radius}]"

# Transforms
# Rotate
proc rotate*[Vector](c: var Circle[Vector], theta: float): var Circle[Vector] {.noinit.} =
  result = c

# Scale
proc scale*[Vector](c: var Circle[Vector], s: float): var Circle[Vector] {.noinit.} =
  c.radius *= s
  result = c

# Translate
proc translate*[Vector](c: var Circle[Vector], t: float): var Circle[Vector] {.noinit.} =
  c.center += t
  result = c

# Transform
proc transform*[Vector](c: var Circle[Vector], m : Matrix): var Circle[Vector] {.noinit.} =
  c.center = transform(c.center, m)
  result = c



