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
  Polygon,
  Polyline,
  LineSegment

from ./errors import
  InvalidPolylineError,
  InvalidSegmentsError,
  InvalidVerticesError,
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
  Polygon,
  LineSegment,
  InvalidPolylineError,
  InvalidSegmentsError,
  InvalidVerticesError

from math import arctan2, arccos, sqrt, TAU, PI
from strformat import `&`
import hashes
import json

from ./vector import
  vector2,
  vector3,
  cross,
  dimension,
  clear,
  #copy,
  distanceTo,
  arePlanar,
  multiplySelf

from ./path import
  polyline,
  areClosed,
  reverse,
  closestVertex,
  closestPoint,
  containsPoint,
  rotate,
  scale,
  translate,
  transform

# Constuctors
proc polygon*[N: static[int], T](polyline: Polyline[N, T]): Polygon[N, T] =
  if not (areClosed(polyline.segments)):
    raise newException(InvalidPolylineError,
      "Polyline is not closed")
  if not (arePlanar(polyline.vertices)):
    raise newException(InvalidPolylineError,
      "Polyline is not planar")
  result.polyline = polyline

proc polygon*[N: static[int], T](segments: openArray[LineSegment[N, T]]): Polygon[N, T] =
  if not areClosed(segments):
    raise newException(InvalidSegmentsError,
      "Segments are not closed")
  result.polyline = polyline(segments)
  if not arePlanar(result.polyline.vertices):
    raise newException(InvalidSegmentsError,
      "Segments are not planar")

proc polygon*[N: static[int], T](vertices: openArray[Vector[N, T]]): Polygon[N, T] =
  if not arePlanar(vertices):
    raise newException(InvalidVerticesError,
      "Vertices are not planar")
  result.polyline = polyline(vertices, true)

# NOTE: This is added from design doc
# proc addVertex*[Vector2](p: var Polygon[Vector2], x, y: float): var Polygon[Vector2] {.noinit.} =
#   p.polyline = addVertex(p.polyline, x, y)
#   result = p

# proc addVertex*[Vector3](p: var Polygon[Vector3], x, y, z: float): var Polygon[Vector3] {.noinit.} =
#   p.polyline = addVertex(p.polyline, x, y, z)
#   result = p

# proc addVertex*[Vector](p: var Polygon[Vector], v: Vector): var Polygon[Vector] {.noinit.} =
#   p.polyline = addVertex(p.polyline, v)
#   result = p

# Accessors
# proc vertices*[Vector](p: Polygon[Vector]): seq[Vector] {.inline.} =
#   result = p.polyline.vertices

# proc segments*[Vector](p: Polygon[Vector]): seq[LineSegment[Vector]] {.inline.} =
#   result = p.polyline.segments

# proc faces*[Vector](p: Polygon[Vector]): seq[LineSegment[Vector]] {.inline.} = p.segments

# Iterators
iterator vertices*[N: static[int], T](p: Polygon[N, T]): Vector[N, T] =
  for v in p.polyline.vertices:
    yield v

iterator segments*[N: static[int], T](p: Polygon[N, T]): LineSegment[N, T] =
  for s in p.polyline.segments:
    yield s

iterator faces*[N: static[int], T](p: Polygon[N, T]): LineSegment[N, T] =
  for s in p.polyline.segments:
    yield s

# NOTE: This is added from design doc
# NOTE: Remove returns for all in place operations
proc reverse*[N: static[int], T](p: var Polygon[N, T]): var Polygon[N, T] =
  p.polyline = reverse(p.polyline)
  result = p

# NOTE: This is added from design doc
proc contains*[N: static[int], T](p: Polygon[N, T], v: Vector[N, T]): bool =
  result = contains(p.polyline, v)

# NOTE: This is added from design doc
proc containsPoint*[N: static[int], T](p: Polygon[N, T], v: Vector[N, T]): bool =
  result = containsPoint(p.polyline, v)

# Equals (compares points in polygon)
proc `==`*[N: static[int], T](p1, p2: Polygon[N, T]): bool =
  result = p1.polyline == p2.polyline

# Non Equals
proc `!=`*[N: static[int], T](p1, p2: Polygon[N, T]): bool =
  result = not (p1 == p2)

# Hash
proc hash*[N: static[int], T](p: Polygon[N, T]): hashes.Hash =
  result = hash(p.polyline)

# Clear
# proc clear*[Vector](p: var Polygon[Vector]): var Polygon[Vector] {.noinit.} =
#   result = p.polyline.clear()

# Dimension
proc dimension*[N: static[int], T](p: Polygon[N, T]): int =
  result = dimension(p.polyline)

# Copy
proc copy*[N: static[int], T](p: Polygon[N, T]): Polygon[N, T] =
  result = Polygon[N: static[int], T](polyline: copy(p.polyline))

# String
proc `$`*[N: static[int], T](p: Polygon[N, T]): string =
  result = $p.polyline

# Area
proc signedArea[N: static[int], T](p: Polygon[N, T]): float =
  for s in p.polyline.segments:
    let
      a = s.startVertex
      b = s.endVertex
    result += (a.x * b.y)
    result -= (a.y * b.x)
  result *= 0.5

proc area*[N: static[int], T](p: Polygon[N, T]): float = abs(signedArea(p))

# Perimeter (the circumference)
proc perimeter*[N: static[int], T](p: Polygon[N, T]): float =
  for s in p.polyline.segments:
    result += distanceTo(s.startVertex, s.endVertex)

# Centroid
proc centroid*[N: static[int], T](p: Polygon[N, T]): Vector[N, T] =
  let l = len(p.polyline.vertices)
  if l > 0:
    var v1 = copy(p.polyline.vertices[0])
    result = v1.clear()
    for s in p.polyline.segments:
      let
        a = s.startVertex
        b = s.endVertex
      result += (a + b) * cross(a, b)
    result = multiplySelf(result, 1.0 / (6.0 * signedArea(p)))

# Predication Vertices
# Closest Vertex
proc closestVertex*[N: static[int], T](p: Polygon[N, T], v: Vector[N, T]): Vector[N, T] =
  result = closestVertex(p.polyline, v)

# To Polygon
proc toPolygon*[N: static[int], T](p: var Polygon[N, T]): var Polygon[N, T] {.noinit.} =
  result = p

# To Polyline
proc toPolyline*[N: static[int], T](p: Polygon[N, T]): Polyline[N, T] =
  result = p.polyline

# Predicate Closest
# Closest Point
proc closestPoint*[N: static[int], T](p: Polygon[N, T], v: Vector[N, T]): Vector[N, T] =
  result = closestPoint(p.polyline, v)

# NOTE: This is added from design doc
proc isClockwise*[N: static[int], T](p: Polygon[N, T]): bool =
  result = signedArea(p) > 0

# Predicate Transforms
# Rotate
proc rotate*[T](p: var Polygon[2, T], theta: float): var Polygon[2, T] {.noinit.} =
  p.polyline = rotate(p.polyline, theta)
  result = p

proc rotate*[T](p: var Polygon[3, T], axis: Vector[3, T], theta: float): var Polygon[3, T] {.noinit.} =
  p.polyline = rotate(p.polyline, axis, theta)
  result = p

proc rotate*[T](p: var Polygon[4, T], b1, b2: Vector[4, T], theta: float, b3, b4: Vector[4, T], phi: float): var Polygon[4, T] {.noinit.} =
  p.polyline = rotate(p.polyline, b1, b2, theta, b3, b4, phi)
  result = p

# Scale
proc scale*[N: static[int], T](p: var Polygon[N, T], s: float): var Polygon[N, T] {.noinit.} =
  p.polyline = scale(p.polyline, s)
  result = p

proc scale*[T](p: var Polygon[2, T], sx, sy: float): var Polygon[2, T] {.noinit.} =
  p.polyline = scale(p.polyline, sx, sy)
  result = p

proc scale*[T](p: var Polygon[3, T], sx, sy, sz: float): var Polygon[3, T] {.noinit.} =
  p.polyline = scale(p.polyline, sx, sy, sz)
  result = p

proc scale*[T](p: var Polygon[4, T], sx, sy, sz, sw: float): var Polygon[4, T] {.noinit.} =
  p.polyline = scale(p.polyline, sx, sy, sz, sw)
  result = p

# Translate
proc translate*[N: static[int], T](p: var Polygon[N, T], v: Vector[N, T]): var Polygon[N, T] {.noinit.} =
  p.polyline = translate(p.polyline, v)
  result = p

# Transform
proc transform*[N, M: static[int], T](p: var Polygon[N, T], m : Matrix[N, M, T]): var Polygon[N, T] {.noinit.} =
  p.polyline = transform(p.polyline, m)
  result = p