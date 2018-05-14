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
import ./matrix

type
  
  Circle*[Vector] = object
    center*: Vector
    radius*: float 
  
  Polygon*[Vector] = object
    vertices*: seq[Vector]
  
  Sphere*[Vector] = object
    center*: Vector
    radius*: float
    
# NOTE: This is added from design doc
  LineSegment*[Vector] = object
    startPoint*: Vector
    endPoint*: Vector
  
# Constuctors
proc polygon*[Vector](points: seq[Vector]): Polygon[Vector] =
  result.vertices = @[]
  result.vertices = points

proc polygon*[Vector](): Polygon[Vector] =
  result.vertices = @[]

# NOTE: This is added from design doc
proc lineSegment*[Vector](v1, v2: Vector): LineSegment[Vector] =
  result.startPoint = v1
  result.endPoint = v2

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

# ***************************************
#     LineSegment implementation
# ***************************************
# NOTE: This is added from design doc
proc closestPointTo*[Vector](l: LineSegment[Vector], v: Vector2): Vector2 = 
  var sub = l.endPoint.subtractNew(l.startPoint)
  var t = v.subtractNew(l.startPoint).dot(sub) / sub.magnitudeSquared()
  if t < 0.0:
    return l.startPoint
  elif t > 1.0:
    return l.endPoint
  result = l.startPoint.addNew(sub.multiplySelf(t))

# ***************************************
#     Polygon implementation
# ***************************************
# NOTE: This is added from design doc
proc addVertex*[Vector](p: var Polygon[Vector], x, y: float): var Polygon[Vector] {.noinit.} = 
  if not p.contains(vector2(x,y)):
    p.vertices.add(vector2(x, y))
  else: raise newException(AccessViolationError, "Attempting to add a vertex which alreaday exists")
  result = p

proc addVertex*[Vector](p: var Polygon[Vector], x, y, z: float): var Polygon[Vector] {.noinit.} = 
  if not p.contains(vector3(x,y,z)):
    p.vertices.add(vector3(x, y, z))
  else: raise newException(AccessViolationError, "Attempting to add a vertex which alreaday exists")
  result = p

proc addVertex*[Vector](p: var Polygon[Vector], v: Vector): var Polygon[Vector] {.noinit.} =
  if not p.contains(v):
    p.vertices.add(v)
  else: raise newException(AccessViolationError, "Attempting to add a vertex which alreaday exists")
  result = p

# NOTE: This is added from design doc
proc pointCount*[Vector](p: Polygon[Vector]): int = 
  result = len(p.vertices)

# Get Lines
# NOTE: This is added from design doc
proc edges*[Vector](p: Polygon[Vector]): seq[LineSegment[Vector]] =
  var list : seq[LineSegment[Vector]] = @[]
  for i in 0..<p.pointCount():
    list.add(lineSegment(p.vertices[i],p.vertices[(i+1) mod p.pointCount()]))
  result = list

# NOTE: This is added from design doc
# NOTE: Using Nim paradigm (items, fields, pairs, etc)
iterator verts*[Vector](p: Polygon[Vector]): Vector =
  for i in 0..<p.pointCount():
    yield p.vertices[i]

iterator segments*[Vector](p: Polygon[Vector]): LineSegment[Vector] =
  for i in edges(p):
    yield i

# NOTE: This is added from design doc
proc reverseOrder*[Vector](p: var Polygon[Vector]): var Polygon[Vector] {.noinit.} =
  var list = newSeq[Vector](p.pointCount())
  for i, x in p.vertices:
    list[p.vertices.high-i] = x
  p.vertices = list 
  result = p

# NOTE: This is added from design doc
proc contains*[Vector](p: Polygon[Vector], v: Vector): bool =
  # Checks to see if point we are adding to vertices already exists
  var hit : bool
  for vert in p.vertices:
    if vert == v:
      hit = true
      break
    else: hit = false
  result = hit

# NOTE: This is added from design doc
proc containsPoint*[Vector](p: Polygon[Vector], v: Vector): bool =
  # Checks if a point is contained within the polygon
  var j = p.pointCount()-1
  var nodes : bool
  var px = v.x
  var py = v.y
  for i in 0..<p.pointCount():
    var vi = p.vertices[i]
    var vj = p.vertices[j]
    if vi.y < py and vj.y >= py or vj.y < py and vi.y >= py:
      if vi.x + (py - vi.y) / (vj.y - vi.y) * (vj.x - vi.x) < px:
        nodes = not nodes
    j = i
  result = nodes

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
proc clear*[Vector](p: var Polygon[Vector]): var Polygon[Vector] {.noinit.} =
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

# NOTE: This is added from design doc
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
proc toPolygon*[Vector](p: var Polygon[Vector]): var Polygon {.noinit.} =
  result = p

# To Polyline

# Predicate Closest
# Closest Point
proc closestPoint*[Vector](p: Polygon[Vector], v: Vector): Vector =
  var minDist : float = 1000000000000.0
  var vecRef : Vector = p.vertices[0]
  var vecRef2 = vecRef.copy()
  var vec = vecRef2.clear()
  for edges in p.edges():
    var closestVec = edges.closestPointTo(v)
    var dist = closestVec.distanceToSquared(v)
    if(dist < minDist):
      vec = closestVec
      minDist = dist
  result = vec

# NOTE: This is added from design doc
proc isClockwise*[Vector](p: Polygon[Vector]): bool =
  result = area(p) > 0

# Predicate Transforms
# Rotate
proc rotate*[Vector](p: var Polygon[Vector], theta: float): var Polygon[Vector] {.noinit.} =
  for i, x in p.vertices:
    p.vertices[i] = x.rotateNew(theta)
  result = p

# Scale
proc scale*[Vector](p: var Polygon[Vector], s: float): var Polygon[Vector] {.noinit.} =
  for i, x in p.vertices:
    p.vertices[i] = x.scaleNew(s)
  result = p

proc scale*[Vector](p: var Polygon[Vector], sx, sy: float): var Polygon[Vector] {.noinit.} =
  for i, x in p.vertices:
    p.vertices[i] = x.scaleNew(sx, sy)
  result = p

proc scale*[Vector](p: var Polygon[Vector], sx, sy, sz: float): var Polygon[Vector] {.noinit.} =
  for i, x in p.vertices:
    p.vertices[i] = x.scaleNew(sx, sy, sz)
  result = p

# Translate
proc translate*[Vector](p: var Polygon[Vector], t: float): var Polygon[Vector] {.noinit.} =
  for i, x in p.vertices:
    p.vertices[i] = x.addNew(t)
  result = p

proc translate*[Vector](p: var Polygon[Vector], v: Vector): var Polygon[Vector] {.noinit.} =
  for i, x in p.vertices:
    p.vertices[i] = x.addNew(v)
  result = p

# Transform(Matrix)
proc transform*[Vector](p: var Polygon[Vector], m : Matrix): var Polygon[Vector] {.noinit.} = 
  for i, x in p.vertices:
    p.vertices[i] = x.transformNew(m)
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





  

  