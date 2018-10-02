from ./concepts import
  Equals,
  Hash,
  Transform,
  Dimension,
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
  Matrix33,
  Matrix44,
  Polyline,
  LineSegment,
  Polygon

from ./errors import
  InvalidSegmentsError,
  InvalidJsonError

export
  Equals,
  Hash,
  Transform,
  Dimension,
  Copy,
  String,
  Centroid,
  Shape2,
  Closest,
  Vertices,
  Polyline,
  LineSegment,
  InvalidSegmentsError

from math import arctan2, arccos, sqrt, TAU, PI
from strformat import `&`
from algorithm import reverse
from sequtils import apply, map
import hashes
import json

from ./vector import
  vector1,
  vector2,
  vector3,
  vector4,
  clear,
  #copy,
  dimension,
  dot,
  addNew,
  subtractNew,
  multiplyNew,
  multiplySelf,
  divideNew,
  magnitude,
  magnitudeSquared,
  rotate,
  scale,
  translate,
  transform,
  distanceToSquared,
  vector1FromJsonNode,
  vector2FromJsonNode,
  vector3FromJsonNode,
  vector4FromJsonNode,
  toJson

# Constuctors
# NOTE: This is added from design doc
proc lineSegment*[N: static[int], T](v1, v2: Vector[N, T]): LineSegment[N, T] =
  result.startVertex = v1
  result.endVertex = v2

proc areClosed*[N: static[int], T](vertices: openArray[Vector[N, T]]): bool =
  result = len(vertices) > 1 and vertices[0] == vertices[^1]

proc areClosed*[N: static[int], T](segments: openArray[LineSegment[N, T]]): bool =
  result = len(segments) > 1 and segments[0].startVertex == segments[^1].endVertex

proc getSegments*[N: static[int], T](vertices: openArray[Vector[N, T]], closed: bool): seq[LineSegment[N, T]] =
  result = @[]
  let l = len(vertices)
  if l > 1:
    for i in 0..<(len(vertices) - 1):
      add(result, lineSegment(vertices[i], vertices[(i + 1)]))
    if closed:
      add(result, lineSegment(vertices[l - 1], vertices[0]))

proc getVertices*[N: static[int], T](segments: openArray[LineSegment[N, T]], closed: bool): seq[Vector[N, T]] =
  result = @[]
  if len(segments) > 0:
    for s in segments:
      add(result, s.startVertex)
    if not closed:
      add(result, segments[^1].endVertex)

proc collapseVertices[N: static[int], T](vertices: openArray[Vector[N, T]]): seq[Vector[N, T]] =
  result = @[]
  let l = len(vertices)
  for i, v in pairs(vertices):
    if v != vertices[(i + 1) mod l]:
      add(result, v)

proc areSegmentsValid[N: static[int], T](segments: openArray[LineSegment[N, T]]): bool =
  result = true
  for i in 0..<(len(segments) - 1):
    if segments[i].endVertex != segments[i + 1].startVertex:
      result = false
      break

proc polyline*[N: static[int], T](vertices: openArray[Vector[N, T]], closed: bool = false): Polyline[N, T] =
  let
    c = closed or areClosed(vertices)
    vs = collapseVertices(vertices)
  result.vertices = @vs
  result.segments = getSegments(vs, c)

proc polyline*[N: static[int], T](segments: openArray[LineSegment[N, T]]): Polyline[N, T] =
  if not areSegmentsValid(segments):
    raise newException(InvalidSegmentsError,
      "Segments are disjoint")
  result.vertices = getVertices(segments, areClosed(segments))
  result.segments = @segments

# NOTE: This is added from design doc
# NOTE: Move all segment operations into a new file
proc closestPoint*[N: static[int], T](startVertex, endVertex, v: Vector[N, T]): Vector[N, T] =
  let
    sub = subtractNew(endVertex, startVertex)
    mag = magnitude(sub)
  if mag == 0.0:
    return startVertex
  let t = dot(subtractNew(v, startVertex), sub) / mag
  if t < 0.0:
    result = startVertex
  elif t > mag:
    result = endVertex
  else:
    result = addNew(startVertex, multiplyNew(divideNew(sub, mag), t))

proc closestPoint*[N: static[int], T](l: LineSegment[N, T], v: Vector[N, T]): Vector[N, T] =
  result = closestPoint(l.startVertex, l.endVertex, v)

# NOTE: This is added from design doc
# proc addVertex*[Vector](p: var Polyline[Vector], x, y: float): var Polyline[Vector] {.noinit.} =
#   if not p.contains(vector2(x,y)):
#     p.vertices.add(vector2(x, y))
#   else: raise newException(AccessViolationError, "Attempting to add a vertex which alreaday exists")
#   result = p

# proc addVertex*[Vector](p: var Polyline[Vector], x, y, z: float): var Polyline[Vector] {.noinit.} =
#   if not p.contains(vector3(x,y,z)):
#     p.vertices.add(vector3(x, y, z))
#   else: raise newException(AccessViolationError, "Attempting to add a vertex which alreaday exists")
#   result = p

# proc addVertex*[Vector](p: var Polyline[Vector], v: Vector): var Polyline[Vector] {.noinit.} =
#   if not p.contains(v):
#     p.vertices.add(v)
#   else: raise newException(AccessViolationError, "Attempting to add a vertex which alreaday exists")
#   result = p

# # NOTE: This is added from design doc
# # NOTE: Using Nim paradigm (items, fields, pairs, etc)
iterator vertices*[N: static[int], T](p: Polyline[N, T]): Vector[N, T] =
  for v in p.vertices:
    yield v

iterator segments*[N: static[int], T](p: Polyline[N, T]): LineSegment[N, T] =
  for s in p.segments:
    yield s

# NOTE: This is added from design doc
proc isClosed*[N: static[int], T](p: Polyline[N, T]): bool =
  result = p.segments[0].startVertex == p.segments[^1].endVertex

# NOTE: This is added from design doc
# NOTE: Remove returns for all in place operations
proc reverse*[N: static[int], T](p: var Polyline[N, T]): var Polyline[N, T] =
  apply(p.segments, proc(s: var LineSegment[Vector]) = swap(s.startVertex, s.endVertex))
  reverse(p.segments)
  reverse(p.vertices)
  result = p

# NOTE: This is added from design doc
proc contains*[N: static[int], T](p: Polyline[N, T], v: Vector[N, T]): bool =
  result = contains(p.vertices, v)

proc contains*[N: static[int], T](p: Polyline[N, T], s: LineSegment[N, T]): bool =
  result = contains(p.segments, s)

# NOTE: This is added from design doc
proc containsPoint*[N: static[int], T](p: Polyline[N, T], v: Vector[N, T]): bool =
  # Checks if a point is contained within the Polyline
  let l = len(p.vertices)
  var
    j = l - 1
    nodes = false
  for i in 0..<l:
    let
      vi = p.vertices[i]
      vj = p.vertices[j]
    if ((vi.y < v.y) and (vj.y >= v.y)) or ((vj.y < v.y) and (vi.y >= v.y)):
      if (vi.x + (v.y - vi.y) / (vj.y - vi.y) * (vj.x - vi.x)) < v.x:
        nodes = not nodes
    j = i
  result = nodes

# Equals (compares points in Polyline)
proc `==`*[N: static[int], T](p1, p2: Polyline[N, T]): bool =
  let
    l1 = len(p1.vertices)
    l2 = len(p2.vertices)
  if l1 != l2:
    return false
  for i in 0..<l1:
    if p1.vertices[i] != p2.vertices[i]:
      return false
  result = true

# Non Equals
proc `!=`*[N: static[int], T](p1,p2: Polyline[N, T]): bool =
  result = not (p1 == p2)

# Hash
proc hash*[N: static[int], T](p: Polyline[N, T]): hashes.Hash =
  for v in p.vertices:
    result = !$(result !& hash(v))

# # Clear
# proc clear*[Vector](p: var Polyline[Vector]): var Polyline[Vector] {.noinit.} =
#   p.vertices = @[]
#   result = p

# Dimension
proc dimension*[N: static[int], T](p: Polyline[N, T]): int =
  if len(p.vertices) != 0:
    result = dimension(p.vertices[0])

# Copy
proc copy*[N: static[int], T](p: Polyline[N, T]): Polyline[N, T] =
  result = Polyline[Vector](vertices: p.vertices, segments: p.segments)

# String
proc `$`*[N: static[int], T](p: Polyline[N, T]): string =
  result = ""
  if len(p.vertices) > 0:
    result &= "[" & $p.vertices[0]
    for v in p.vertices[1..^1]:
      result &= ", " & $v
    result &= "]"

# NOTE: This is added from design doc
proc average*[N: static[int], T](p: Polyline[N, T]): Vector[N, T] =
  if len(p.vertices) > 0:
    var v1 = copy(p.vertices[0])
    result = v1.clear()
    # chaining below was triggering type mismatch: got <Vector2> error
    #result = clear(copy(p.vertices[0]))
    for i in 0..<len(p.vertices):
      result += p.vertices[i]
    result /= (float) len(p.vertices)

# Closest Vertex
proc closestVertex*[N: static[int], T](p: Polyline[N, T], v: Vector[N, T]): Vector[N, T] =
  if len(p.vertices) > 0:
    var v1 = copy(p.vertices[0])
    result = v1.clear()
    var minDist = high(float)
    for vertex in p.vertices:
      var dist = distanceToSquared(vertex, v)
      if (dist < minDist):
        result = vertex
        minDist = dist

# To Polyline
proc toPolyline*[N: static[int], T](p: Polyline[N, T]): Polyline[N, T] =
  result = p

# To Polygon
proc toPolygon*[N: static[int], T](p: Polyline[N, T]): Polygon[N, T] =
  result = Polygon[Vector](polyline: p)

# Closest Point
proc closestPoint*[N: static[int], T](p: Polyline[N, T], v: Vector[N, T]): Vector[N, T] =
  if len(p.vertices) > 0:
    var v1 = copy(p.vertices[0])
    result = v1.clear()
    var minDist = high(float)
    for s in p.segments:
      var
        closestVec = closestPoint(s, v)
        dist = distanceToSquared(closestVec, v)
      if (dist < minDist):
        result = closestVec
        minDist = dist

# Transforms
# Rotate
proc rotate*[T](p: var Polyline[2, T], theta: float): var Polyline[2, T] {.noinit.} =
  for i in 0..<len(p.vertices):
    p.vertices[i] = rotate(p.vertices[i], theta)
  for i in 0..<len(p.segments):
    p.segments[i].startVertex = rotate(p.segments[i].startVertex, theta)
    p.segments[i].endVertex = rotate(p.segments[i].endVertex, theta)
  result = p

proc rotate*[T](p: var Polyline[3, T], axis: Vector[3, T], theta: float): var Polyline[3, T] {.noinit.} =
  for i in 0..<len(p.vertices):
    p.vertices[i] = rotate(p.vertices[i], axis, theta)
  for i in 0..<len(p.segments):
    p.segments[i].startVertex = rotate(p.segments[i].startVertex, axis, theta)
    p.segments[i].endVertex = rotate(p.segments[i].endVertex, axis, theta)
  result = p

proc rotate*[T](p: var Polyline[4, T], b1, b2: Vector[4, T], theta: float, b3, b4: Vector[4, T], phi: float): var Polyline[4, T] {.noinit.} =
  for i in 0..<len(p.vertices):
    p.vertices[i] = rotate(p.vertices[i], b1, b2, theta, b3, b4, phi)
  for i in 0..<len(p.segments):
    p.segments[i].startVertex = rotate(p.segments[i].startVertex, b1, b2, theta, b3, b4, phi)
    p.segments[i].endVertex = rotate(p.segments[i].endVertex, b1, b2, theta, b3, b4, phi)
  result = p
# Scale
proc scale*[N: static[int], T](p: var Polyline[N, T], s: float): var Polyline[N, T] {.noinit.} =
  for i in 0..<len(p.vertices):
    p.vertices[i] = scale(p.vertices[i], s)
  for i in 0..<len(p.segments):
    p.segments[i].startVertex = scale(p.segments[i].startVertex, s)
    p.segments[i].endVertex = scale(p.segments[i].endVertex, s)
  result = p

proc scale*[T](p: var Polyline[2, T], sx, sy: float): var Polyline[2, T] {.noinit.} =
  for i in 0..<len(p.vertices):
    p.vertices[i] = scale(p.vertices[i], sx, sy)
  for i in 0..<len(p.segments):
    p.segments[i].startVertex = scale(p.segments[i].startVertex, sx, sy)
    p.segments[i].endVertex = scale(p.segments[i].endVertex, sx, sy)
  result = p

proc scale*[T](p: var Polyline[3, T], sx, sy, sz: float): var Polyline[3, T] {.noinit.} =
  for i in 0..<len(p.vertices):
    p.vertices[i] = scale(p.vertices[i], sx, sy, sz)
  for i in 0..<len(p.segments):
    p.segments[i].startVertex = scale(p.segments[i].startVertex, sx, sy, sz)
    p.segments[i].endVertex = scale(p.segments[i].endVertex, sx, sy, sz)
  result = p

proc scale*[T](p: var Polyline[4, T], sx, sy, sz, sw: float): var Polyline[4, T] {.noinit.} =
  for i in 0..<len(p.vertices):
    p.vertices[i] = scale(p.vertices[i], sx, sy, sz, sw)
  for i in 0..<len(p.segments):
    p.segments[i].startVertex = scale(p.segments[i].startVertex, sx, sy, sz, sw)
    p.segments[i].endVertex = scale(p.segments[i].endVertex, sx, sy, sz, sw)
  result = p

# Translate
proc translate*[N: static[int], T](p: var Polyline[N, T], v: Vector[N, T]): var Polyline[N, T] {.noinit.} =
  for i in 0..<len(p.vertices):
    p.vertices[i] = translate(p.vertices[i], v)
  for i in 0..<len(p.segments):
    p.segments[i].startVertex = translate(p.segments[i].startVertex, v)
    p.segments[i].endVertex = translate(p.segments[i].endVertex, v)
  result = p

# Transform(Matrix)
proc transform*[N, M: static[int], T](p: var Polyline[N, T], m: Matrix[N, M, T]): var Polyline[N, T] {.noinit.} =
  for i in 0..<len(p.vertices):
    p.vertices[i] = transform(p.vertices[i], m)
  for i in 0..<len(p.segments):
    p.segments[i].startVertex = transform(p.segments[i].startVertex, m)
    p.segments[i].endVertex = transform(p.segments[i].endVertex, m)
  result = p
