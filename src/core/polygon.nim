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
  Polygon,
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
  Polygon

from math import arctan2, arccos, sqrt, TAU, PI
from strformat import `&`
import hashes

from ./vector import
  vector2,
  vector3,
  cross,
  dimension,
  clear,
  copy

from ./path import
  closestVertex,
  closestPoint,
  containsPoint,
  rotate,
  scale,
  translate,
  transform

# Constuctors
proc polygon*[Vector](polyline: Polyline[Vector]): Polygon[Vector] =
  result.polyline = polyline

# NOTE: This is added from design doc
proc addVertex*[Vector2](p: var Polygon[Vector2], x, y: float): var Polygon[Vector2] {.noinit.} =
  p.polyline = addVertex(p.polyline, x, y)
  result = p

proc addVertex*[Vector3](p: var Polygon[Vector3], x, y, z: float): var Polygon[Vector3] {.noinit.} =
  p.polyline = addVertex(p.polyline, x, y, z)
  result = p

proc addVertex*[Vector](p: var Polygon[Vector], v: Vector): var Polygon[Vector] {.noinit.} =
  p.polyline = addVertex(p.polyline, v)
  result = p

# NOTE: This is added from design doc
proc pointCount*[Vector](p: Polygon[Vector]): int =
  result = len(p.polyline.vertices)

# Get Lines
# NOTE: This is added from design doc
proc faces*[Vector](p: Polygon[Vector]): seq[LineSegment[Vector]] =
  result = p.polyline.segment()

# NOTE: This is added from design doc
proc reverseOrder*[Vector](p: var Polygon[Vector]): var Polygon[Vector] {.noinit.} =
  result = p.polyline.reverseOrder()

# NOTE: This is added from design doc
proc contains*[Vector](p: Polygon[Vector], v: Vector): bool =
  result = p.polyline.contains(v)

# NOTE: This is added from design doc
proc containsPoint*[Vector](p: Polygon[Vector], v: Vector): bool =
  result = p.polyline.containsPoint(v)

# Equals (compares points in polygon)
proc `==`*[Vector](p1,p2: Polygon[Vector]): bool =
  result = p1.polyline == p2.polyline

# Non Equals
proc `!=`*[Vector](p1,p2: Polygon[Vector]): bool =
  result = not (p1 == p2)

# Hash
proc hash*[Vector](p: Polygon[Vector]): hashes.Hash =
  result = p.polyline.hash()

# Clear
proc clear*[Vector](p: var Polygon[Vector]): var Polygon[Vector] {.noinit.} =
  result = p.polyline.clear()

# Dimension
proc dimension*[Vector](p: Polygon[Vector]): int =
  result = p.polyline.dimension()

# Copy
proc copy*[Vector](p: Polygon[Vector]): Polygon[Vector] =
  result = Polygon(polyline: p.polyline)

# String
proc `$`*[Vector](p: Polygon[Vector]): string =
  result = $p.polyline

# Predicate Shape2
# Area
proc area*[Vector](p: Polygon[Vector]): float =
  for i in 0..<p.pointCount():
    var a = p.polyline.vertices[i]
    var b = p.polyline.vertices[(i + 1) mod p.pointCount()]
    result += (a.x * b.y)
    result -= (a.y * b.x)
  result *= 0.5

# Perimeter (the circumference)
proc perimeter*[Vector](p: Polygon[Vector]): float =
  for i in 0..<p.pointCount():
    result += p.polyline.vertices[i].distanceTo(p.polyline.vertices[(i + 1) mod p.pointCount()])

# Centroid
proc centroid*[Vector](p: Polygon[Vector]): Vector =
  var vecRef : Vector = p.polyline.vertices[0]
  var vecRef2 = vecRef.copy()
  var vec = vecRef2.clear()
  for i in 0..<p.pointCount():
    var a = p.polyline.vertices[i]
    var b = p.polyline.vertices[(i + 1) mod p.pointCount()]
    vec += (a + b) * cross(a, b)
  result = vec.multiplySelf(1.0 / (6 * p.area()))

# Predication Vertices
# Closest Vertex
proc closestVertex*[Vector](p: Polygon[Vector], v: Vector): Vector =
  result = p.polyline.closestVertex(v)

# To Polygon
proc toPolygon*[Vector](p: var Polygon[Vector]): var Polygon[Vector] {.noinit.} =
  result = p

# To Polyline
proc toPolyline*[Vector](p: Polygon[Vector]): Polyline[Vector] =
  result = p.polyline

# Predicate Closest
# Closest Point
proc closestPoint*[Vector](p: Polygon[Vector], v: Vector): Vector =
  result = p.polyline.closestPoint(v)

# NOTE: This is added from design doc
proc isClockwise*[Vector](p: Polygon[Vector]): bool =
  result = area(p) > 0

# Predicate Transforms
# Rotate
proc rotate*[Vector](p: var Polygon[Vector], theta: float): var Polygon[Vector] {.noinit.} =
  discard p.polyline.rotate(theta)
  result = p

# Scale
proc scale*[Vector](p: var Polygon[Vector], s: float): var Polygon[Vector] {.noinit.} =
  discard p.polyline.scale(s)
  result = p

proc scale*[Vector](p: var Polygon[Vector], sx, sy: float): var Polygon[Vector] {.noinit.} =
  discard p.polyline.scale(sx, sy)
  result = p

proc scale*[Vector](p: var Polygon[Vector], sx, sy, sz: float): var Polygon[Vector] {.noinit.} =
  discard p.polyline.scale(sx, sy, sz)
  result = p

# Translate
proc translate*[Vector](p: var Polygon[Vector], t: float): var Polygon[Vector] {.noinit.} =
  discard p.polyline.translate(t)
  result = p

proc translate*[Vector](p: var Polygon[Vector], v: Vector): var Polygon[Vector] {.noinit.} =
  discard p.polyline.translate(v)
  result = p

# Transform(Matrix)
proc transform*[Vector](p: var Polygon[Vector], m : Matrix): var Polygon[Vector] {.noinit.} =
  discard p.polyline.transform(m)
  result = p