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
  Vertices,
  Matrix

from ./types import
  Vector1,
  Vector2,
  Vector3,
  Vector4,
  Matrix33,
  Matrix44, 
  Circle,
  Polygon,
  LineSegment,
  Polyline

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
  Circle,
  Polygon

from math import arctan2, arccos, sqrt, TAU, PI
from strformat import `&`
import hashes

from ./vector import vector2, vector3, cross, dimension, clear, copy

# Constuctors
proc polygon*[Vector](polyline: Polyline[Vector]): Polygon[Vector] =
  result.polyline = polyline

proc circle*[Vector](): Circle[Vector] =
  result.center = vector2(0,0)
  result.radius = 1

proc circle*[Vector](c: Circle): Circle[Vector] =
  result.center = c.center
  result.radius = c.radius 

proc circle*[Vector](v: Vector, r: float): Circle = 
  result.center = v
  result.radius = r

proc circle*[Vector](x, y, r: float): Circle = 
  result.center = vector2(x,y)
  result.radius = r

proc circle*[Vector](x, y, z, r: float): Circle = 
  result.center = vector3(x,y,z)
  result.radius = r

from ./path import closestVertex, closestPoint, containsPoint, rotate, scale, translate, transform
# ***************************************
#     Polygon implementation
# ***************************************
# NOTE: This is added from design doc
proc addVertex*[Vector](p: var Polygon[Vector], x, y: float): var Polygon[Vector] {.noinit.} = 
  discard p.polyline.addVertex(x,y)
  result = p

proc addVertex*[Vector](p: var Polygon[Vector], x, y, z: float): var Polygon[Vector] {.noinit.} = 
  discard p.polyline.addVertex(x,y,z)
  result = p

proc addVertex*[Vector](p: var Polygon[Vector], v: Vector): var Polygon[Vector] {.noinit.} =
  discard p.polyline.addVertex(v)
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
  if p1.polyline == p2.polyline:
    result = true
  else:
    result = false

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

# ***************************************
#     Circle implementation
# ***************************************
# NOTE: This is added from design doc
# other constructors
proc circlefrom2Points*[Vector](v1, v2: Vector): Circle[Vector] =
  var vec = v1.interpolateTo(v2, 0.5)
  result.center = vec
  result.radius = vec.distanceTo(v2)

proc containsPoint*[Vector](c: Circle[Vector], v: Vector): bool =
  result = c.center.distanceToSquared(v) <= c.radius * c.radius

# Predicate Shape2 
# Area
proc area*[Vector](c: Circle[Vector]): float =
  result = PI*(c.radius * c.radius)
# Perimeter (the circumference)
proc perimeter*[Vector](c: Circle[Vector]): float =
  result = TAU * c.radius

# Predicate Centroid
# Centroid
proc centroid*[Vector](c: Circle[Vector]): Vector =
  result = c.center

# Average
proc average*[Vector](c: Circle[Vector]): Vector =
  result = c.centroid()

# Predicate Closest
# ClosestPoint to circle in 2D
proc closestPoint*[Vector](c: Circle[Vector], v: Vector): Vector =
  var vX = v.x - c.center.x
  var vY = v.y - c.center.y
  var magV = vX*vX - vY*vY 
  result.x = c.center.x + vX / magV * c.radius
  result.y = c.center.y + vY / magv * c.radius

# Equals (compares center and radius for circle)
proc `==`*[Vector](c1,c2: Circle[Vector]): bool =
  if (c1.center != c2.center) and (c1.radius != c2.radius): 
    result = false
  else:
    result = true

# Non Equals
proc `!=`*[Vector](c1,c2: Circle[Vector]): bool = 
  result = not (c1 == c2)
  
# Hash
proc hash*[Vector](c: Circle[Vector]): hashes.Hash =
  result = !$(result !& hash(c.center.x) !& hash(c.center.y) !& hash(c.radius))

# Clear
proc clear*[Vector](c: var Circle[Vector]): var Circle[Vector] {.noinit.} =
  c.center = vector2(0,0)
  c.radius = 1
  result = c

# Dimension
proc dimension*[Vector](c: Circle[Vector]): int =
  result = c.center.dimension()

# Copy
proc copy*[Vector](c: Circle[Vector]): Circle[Vector] = 
  result = Circle[Vector](center: c.center, radius: c.radius)

# String
proc `$`*[Vector](c: Circle[Vector]): string =
  result = &"[{c.center.x}, {c.center.y}, {c.radius}]"

# Predicate Transforms
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

proc translate*[Vector](c: var Circle[Vector], v: Vector): var Circle[Vector] {.noinit.} =
  c.center += v
  result = c

# Transform(Matrix)
proc transform*[Vector](c: var Circle[Vector], m : Matrix): var Circle[Vector] {.noinit.} = 
  c.center = c.center.transformNew(m)
  result = c



  

