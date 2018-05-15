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
  Polyline,
  LineSegment,
  Polygon

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

from ./vector import vector2, vector3, clear, copy, dimension

# Constuctors
proc polyline*[Vector](points: seq[Vector]): Polyline[Vector] =
  if len(points) < 3:
    raise newException(AccessViolationError, "Need more than 2 points to create a polyline")
  result.vertices = @[]
  result.vertices = points

proc polyline*[Vector](): Polyline[Vector] =
  result.vertices = @[]

# NOTE: This is added from design doc
proc lineSegment*[Vector](v1, v2: Vector): LineSegment[Vector] =
  result.startPoint = v1
  result.endPoint = v2

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
#     Polyline implementation
# ***************************************
# NOTE: This is added from design doc
proc addVertex*[Vector](p: var Polyline[Vector], x, y: float): var Polyline[Vector] {.noinit.} =
  if not p.contains(vector2(x,y)):
    p.vertices.add(vector2(x, y))
  else: raise newException(AccessViolationError, "Attempting to add a vertex which alreaday exists")
  result = p

proc addVertex*[Vector](p: var Polyline[Vector], x, y, z: float): var Polyline[Vector] {.noinit.} =
  if not p.contains(vector3(x,y,z)):
    p.vertices.add(vector3(x, y, z))
  else: raise newException(AccessViolationError, "Attempting to add a vertex which alreaday exists")
  result = p

proc addVertex*[Vector](p: var Polyline[Vector], v: Vector): var Polyline[Vector] {.noinit.} =
  if not p.contains(v):
    p.vertices.add(v)
  else: raise newException(AccessViolationError, "Attempting to add a vertex which alreaday exists")
  result = p

# NOTE: This is added from design doc
proc pointCount*[Vector](p: Polyline[Vector]): int =
  result = len(p.vertices)

# Get Lines
# NOTE: This is added from design doc
proc segment*[Vector](p: Polyline[Vector]): seq[LineSegment[Vector]] =
  # closes polyline and returns edges
  var list : seq[LineSegment[Vector]] = @[]
  for i in 0..<p.pointCount():
    list.add(lineSegment(p.vertices[i],p.vertices[(i+1) mod p.pointCount()]))
  result = list

# NOTE: This is added from design doc
# NOTE: Using Nim paradigm (items, fields, pairs, etc)
iterator verts*[Vector](p: Polyline[Vector]): Vector =
  for i in 0..<p.pointCount():
    yield p.vertices[i]

iterator segments*[Vector](p: Polyline[Vector]): LineSegment[Vector] =
  for i in segment(p):
    yield i

# NOTE: This is added from design doc
proc reverseOrder*[Vector](p: var Polyline[Vector]): var Polyline[Vector] {.noinit.} =
  var list = newSeq[Vector](p.pointCount())
  for i, x in p.vertices:
    list[p.vertices.high-i] = x
  p.vertices = list
  result = p

# NOTE: This is added from design doc
proc contains*[Vector](p: Polyline[Vector], v: Vector): bool =
  # Checks to see if point we are adding to vertices already exists
  var hit : bool
  for vert in p.vertices:
    if vert == v:
      hit = true
      break
    else: hit = false
  result = hit

# NOTE: This is added from design doc
proc containsPoint*[Vector](p: Polyline[Vector], v: Vector): bool =
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
proc `==`*[Vector](p1,p2: Polyline[Vector]): bool =
  if p1.pointCount() != p2.pointCount(): return false
  var hit : bool
  for i in 0..<p1.pointCount():
    if p1.vertices[i] != p2.vertices[i]: return false
    else: hit = true
  result = hit

# Non Equals
proc `!=`*[Vector](p1,p2: Polyline[Vector]): bool =
  result = not (p1 == p2)

# Hash
proc hash*[Vector](p: Polyline[Vector]): hashes.Hash =
  for vert in p.vertices:
    result = !$(result !& hash(vert))

# Clear
proc clear*[Vector](p: var Polyline[Vector]): var Polyline[Vector] {.noinit.} =
  p.vertices = @[]
  result = p

# Dimension
proc dimension*[Vector](p: Polyline[Vector]): int =
  if p.pointCount() == 0: raise newException(AccessViolationError, "Polyline has no vertices")
  result = p.vertices[0].dimension()

# Copy
proc copy*[Vector](p: Polyline[Vector]): Polyline[Vector] =
  result = Polyline(vertices: p.vertices)

# String
proc `$`*[Vector](p: Polyline[Vector]): string =
  result = ""
  for vert in p.vertices:
    result.add($vert & ",")

# Length

# NOTE: This is added from design doc
proc average*[Vector](p: Polyline[Vector]): Vector =
  var vecZ : Vector = p.vertices[0]
  var vecY = vecZ.copy()
  var vec = vecY.clear()
  for i in 0..<p.pointCount():
    vec += p.vertices[i]
  vec /= (float)p.pointCount()
  result = vec

# Predication Vertices
# Closest Vertex
proc closestVertex*[Vector](p: Polyline[Vector], v: Vector): Vector =
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

# To Polyline
proc toPolyline*[Vector](p: var Polyline[Vector]): var Polyline[Vector] {.noinit.} =
  result = p

# To Polygon
proc toPolygon*[Vector](p: Polyline[Vector]): Polygon[Vector] =
  result = Polygon(vertices: p.vertices)

# Predicate Closest
# Closest Point
proc closestPoint*[Vector](p: Polyline[Vector], v: Vector): Vector =
  var minDist : float = 1000000000000.0
  var vecRef : Vector = p.vertices[0]
  var vecRef2 = vecRef.copy()
  var vec = vecRef2.clear()
  for edges in p.segment():
    var closestVec = edges.closestPointTo(v)
    var dist = closestVec.distanceToSquared(v)
    if(dist < minDist):
      vec = closestVec
      minDist = dist
  result = vec

# Predicate Transforms
# Rotate
proc rotate*[Vector](p: var Polyline[Vector], theta: float): var Polyline[Vector] {.noinit.} =
  for i, x in p.vertices:
    p.vertices[i] = x.rotateNew(theta)
  result = p

# Scale
proc scale*[Vector](p: var Polyline[Vector], s: float): var Polyline[Vector] {.noinit.} =
  for i, x in p.vertices:
    p.vertices[i] = x.scaleNew(s)
  result = p

proc scale*[Vector](p: var Polyline[Vector], sx, sy: float): var Polyline[Vector] {.noinit.} =
  for i, x in p.vertices:
    p.vertices[i] = x.scaleNew(sx, sy)
  result = p

proc scale*[Vector](p: var Polyline[Vector], sx, sy, sz: float): var Polyline[Vector] {.noinit.} =
  for i, x in p.vertices:
    p.vertices[i] = x.scaleNew(sx, sy, sz)
  result = p

# Translate
proc translate*[Vector](p: var Polyline[Vector], t: float): var Polyline[Vector] {.noinit.} =
  for i, x in p.vertices:
    p.vertices[i] = x.addNew(t)
  result = p

proc translate*[Vector](p: var Polyline[Vector], v: Vector): var Polyline[Vector] {.noinit.} =
  for i, x in p.vertices:
    p.vertices[i] = x.addNew(v)
  result = p

# Transform(Matrix)
proc transform*[Vector](p: var Polyline[Vector], m : Matrix): var Polyline[Vector] {.noinit.} =
  for i, x in p.vertices:
    p.vertices[i] = x.transformNew(m)
  result = p
