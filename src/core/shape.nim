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

import ./vector

type
  
  Circle*[Vector] = object
    center*: Vector
    radius*: float
  
  Polygon*[Vector] = object
    vertices*: seq[Vector]
  
  Sphere*[Vector] = object
    center*: Vector
    radius*: float
  
# Polygon
# Constuctors
proc polygon*[Vector](points: seq[Vector]): Polygon[Vector] =
  result.vertices = @[]
  result.vertices = points

proc polygon*[Vector](): Polygon[Vector] =
  result.vertices = @[]

# ***************************************
#     Polygon implementation
# ***************************************
# NOTE: This is added from design doc
proc addVertex*[Vector](p: var Polygon[Vector], x, y: float): Polygon[Vector] = 
  if not p.contains(vector2(x,y)):
    p.vertices.add(vector2(x, y))
  else: raise newException(AccessViolationError, "Attempting to add a vertex which alreaday exists")
  result = p

proc addVertex*[Vector](p: var Polygon[Vector], x, y, z: float): Polygon[Vector] = 
  if not p.contains(vector3(x,y,z)):
    p.vertices.add(vector3(x, y, z))
  else: raise newException(AccessViolationError, "Attempting to add a vertex which alreaday exists")
  result = p

proc addVertex*[Vector](p: var Polygon[Vector], v: Vector): Polygon[Vector] =
  if not p.contains(v):
    p.vertices.add(v)
  else: raise newException(AccessViolationError, "Attempting to add a vertex which alreaday exists")
  result = p

# NOTE: This is added from design doc
proc pointCount*[Vector](p: Polygon[Vector]): int = 
  result = len(p.vertices)

# NOTE: This is added from design doc
proc contains*[Vector](p: var Polygon[Vector], v: Vector): bool =
  var hit : bool
  for vert in p.vertices:
    if vert == v:
      hit = true
      break
    else: hit = false
  result = hit

# Equals (compares points in polygon)
proc `==`*[Vector](p1,p2: Polygon[Vector]): bool =
  if p1.pointCount() != p2.pointCount(): return false
  var hit : bool
  for i in 0..<p1.pointCount():
    if p1.vertices[i] != p2.vertices[i]: return false
    else: hit = true
  result = hit

# Non Equals
proc `!=`*[Vector](p1,p2: Polygon[Vector]): bool = 
  result = not (p1 == p2)

# Hash
proc hash*[Vector](p: Polygon[Vector]): hashes.Hash =
  for vert in p.vertices:
    result = !$(result !& hash(vert))

# Clear
proc clear*[Vector](p: var Polygon[Vector]): var Polygon[Vector] =
  p.vertices = @[]
  result = p

# Dimension
proc dimension*[Vector](p: Polygon[Vector]): int =
  if p.pointCount() == 0: raise newException(AccessViolationError, "Polygon has no vertices")
  result = p.vertices[0].dimension()

# Copy
proc copy*[Vector](p: Polygon[Vector]): Polygon[Vector] = 
  result = Polygon(vertices: p.vertices)

# String
proc `$`*[Vector](p: Polygon[Vector]): string =
  result = ""
  for vert in p.vertices:
    result.add($vert & ",")

# Predicate Shape2 
# Area
proc area*[Vector](p: Polygon[Vector]): float =
  for i in 0..<p.pointCount():
    var a = p.vertices[i]
    var b = p.vertices[(i + 1) mod p.pointCount()]
    echo (i + 1) mod p.pointCount()
    result += (a.x * b.y)
    result -= (a.y * b.x)
  result *= 0.5

# Perimeter (the circumference)
proc perimeter*[Vector](p: Polygon[Vector]): float =
  for i in 0..<p.pointCount():
    result += p.vertices[i].distanceTo(p.vertices[(i + 1) mod p.pointCount()])

# Centroid
proc centroid*[Vector](p: Polygon[Vector]): Vector =
  var vecRef : Vector = p.vertices[0]
  var vecRef2 = vecRef.copy()
  var vec = vecRef2.clear()
  for i in 0..<p.pointCount():
    var a = p.vertices[i]
    var b = p.vertices[(i + 1) mod p.pointCount()]
    vec += (a + b) * cross(a, b)
  result = vec.multiplySelf(1.0 / (6 * p.area()))

proc average*[Vector](p: Polygon[Vector]): Vector =
  var vecZ : Vector = p.vertices[0]
  var vecY = vecZ.copy()
  var vec = vecY.clear()
  for i in 0..<p.pointCount():
    vec += p.vertices[i]
  vec /= (float)p.pointCount()
  result = vec

# Predication Vertices
# Closest Vertex
proc closestVertex*[Vector](p: Polygon[Vector], v: Vector): Vector =
  var minDist : float = 1000000000000.0
  var vecRef : Vector = p.vertices[0]
  var vecRef2 = vecRef.copy()
  var vec = vecRef2.clear()
  for vert in p.vertices:
    var dist = vert.distanceToSquared(v)
    if(dist < minDist):
      vec = vert
      minDist = dist
  result = vec

# To Polygon
proc toPolygon*[Vector](p: var Polygon[Vector]): var Polygon =
  result = p

# To Polyline



  

  