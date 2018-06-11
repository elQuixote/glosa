from ./concepts import
  Vector,
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
  Matrix

from ./types import
  Vector1,
  Vector2,
  Vector3,
  Vector4,
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
  copy,
  distanceTo,
  arePlanar,
  multiplySelf

from ./path import
  polyline,
  areClosed,
  closestVertex,
  closestPoint,
  containsPoint,
  rotate,
  scale,
  translate,
  transform,
  polyline1FromJsonNode,
  polyline2FromJsonNode,
  polyline3FromJsonNode,
  polyline4FromJsonNode,
  toJson

# Constuctors
proc polygon*[Vector](polyline: Polyline[Vector]): Polygon[Vector] =
  if not (areClosed(polyline.segments)):
    raise newException(InvalidPolylineError,
      "Polyline is not closed")
  if not (arePlanar(polyline.vertices)):
    raise newException(InvalidPolylineError,
      "Polyline is not planar")
  result.polyline = polyline

proc polygon*[Vector](segments: openArray[LineSegment[Vector]]): Polygon[Vector] =
  if not areClosed(segments):
    raise newException(InvalidSegmentsError,
      "Segments are not closed")
  result.polyline = polyline(segments)
  if not arePlanar(result.polyline.vertices):
    raise newException(InvalidSegmentsError,
      "Segments are not planar")

proc polygon*[Vector](vertices: openArray[Vector]): Polygon[Vector] =
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
proc vertices*[Vector](p: Polygon[Vector]): seq[Vector] {.inline.} =
  result = p.polyline.vertices

proc segments*[Vector](p: Polygon[Vector]): seq[LineSegment[Vector]] {.inline.} =
  result = p.polyline.segments

proc faces*[Vector](p: Polygon[Vector]): seq[LineSegment[Vector]] {.inline.} = p.segments

# Iterators
iterator vertices*[Vector](p: Polygon[Vector]): Vector =
  for v in p.vertices:
    yield v

iterator segments*[Vector](p: Polygon[Vector]): LineSegment[Vector] =
  for s in p.segments:
    yield s

iterator faces*[Vector](p: Polygon[Vector]): LineSegment[Vector] =
  for s in p.segments:
    yield s

# NOTE: This is added from design doc
proc reverse*[Vector](p: Polygon[Vector]): Polygon[Vector] =
  result = polygon(reverse(p.polyline))

# NOTE: This is added from design doc
proc contains*[Vector](p: Polygon[Vector], v: Vector): bool =
  result = contains(p.polyline, v)

# NOTE: This is added from design doc
proc containsPoint*[Vector](p: Polygon[Vector], v: Vector): bool =
  result = containsPoint(p.polyline, v)

# Equals (compares points in polygon)
proc `==`*[Vector](p1, p2: Polygon[Vector]): bool =
  result = p1.polyline == p2.polyline

# Non Equals
proc `!=`*[Vector](p1, p2: Polygon[Vector]): bool =
  result = not (p1 == p2)

# Hash
proc hash*[Vector](p: Polygon[Vector]): hashes.Hash =
  result = hash(p.polyline)

# Clear
# proc clear*[Vector](p: var Polygon[Vector]): var Polygon[Vector] {.noinit.} =
#   result = p.polyline.clear()

# Dimension
proc dimension*[Vector](p: Polygon[Vector]): int =
  result = dimension(p.polyline)

# Copy
proc copy*[Vector](p: Polygon[Vector]): Polygon[Vector] =
  result = Polygon(polyline: copy(p.polyline))

# String
proc `$`*[Vector](p: Polygon[Vector]): string =
  result = $p.polyline

# Area
proc signedArea[Vector](p: Polygon[Vector]): float =
  for s in p.segments:
    let
      a = s.startVertex
      b = s.endVertex
    result += (a.x * b.y)
    result -= (a.y * b.x)
  result *= 0.5

proc area*[Vector](p: Polygon[Vector]): float = abs(signedArea(p))

# Perimeter (the circumference)
proc perimeter*[Vector](p: Polygon[Vector]): float =
  for s in p.segments:
    result += distanceTo(s.startVertex, s.endVertex)

# Centroid
proc centroid*[Vector](p: Polygon[Vector]): Vector =
  let l = len(p.vertices)
  if l > 0:
    result = clear(copy(p.vertices[0]))
    for s in p.segments:
      let
        a = s.startVertex
        b = s.endVertex
      result += (a + b) * cross(a, b)
    result = multiplySelf(result, 1.0 / (6.0 * signedArea(p)))

# Predication Vertices
# Closest Vertex
proc closestVertex*[Vector](p: Polygon[Vector], v: Vector): Vector =
  result = closestVertex(p.polyline, v)

# To Polygon
proc toPolygon*[Vector](p: var Polygon[Vector]): var Polygon[Vector] {.noinit.} =
  result = p

# To Polyline
proc toPolyline*[Vector](p: Polygon[Vector]): Polyline[Vector] =
  result = p.polyline

# Predicate Closest
# Closest Point
proc closestPoint*[Vector](p: Polygon[Vector], v: Vector): Vector =
  result = closestPoint(p.polyline, v)

# NOTE: This is added from design doc
proc isClockwise*[Vector](p: Polygon[Vector]): bool =
  result = signedArea(p) > 0

# Predicate Transforms
# Rotate
proc rotate*[Vector](p: var Polygon[Vector], theta: float): var Polygon[Vector] {.noinit.} =
  p.polyline = rotate(p.polyline, theta)
  result = p

# Scale
proc scale*[Vector](p: var Polygon[Vector], s: float): var Polygon[Vector] {.noinit.} =
  p.polyline = scale(p.polyline, s)
  result = p

proc scale*[Vector](p: var Polygon[Vector], sx, sy: float): var Polygon[Vector] {.noinit.} =
  p.polyline = scale(p.polyline, sx, sy)
  result = p

proc scale*[Vector](p: var Polygon[Vector], sx, sy, sz: float): var Polygon[Vector] {.noinit.} =
  p.polyline = scale(p.polyline, sx, sy, sz)
  result = p

# Translate
proc translate*[Vector](p: var Polygon[Vector], v: Vector): var Polygon[Vector] {.noinit.} =
  p.polyline = translate(p.polyline, v)
  result = p

# Transform
proc transform*[Vector](p: var Polygon[Vector], m : Matrix): var Polygon[Vector] {.noinit.} =
  p.polyline = transform(p.polyline, m)
  result = p

# JSON
proc polygon1FromJsonNode*(jsonNode: JsonNode): Polygon[Vector1] =
  try:
    result = polygon(polyline1FromJsonNode(jsonNode["polyline"]))
  except:
    raise newException(InvalidJsonError,
      "JSON is formatted incorrectly")

proc polygon2FromJsonNode*(jsonNode: JsonNode): Polygon[Vector2] =
  try:
    result = polygon(polyline2FromJsonNode(jsonNode["polyline"]))
  except:
    raise newException(InvalidJsonError,
      "JSON is formatted incorrectly")

proc polygon3FromJsonNode*(jsonNode: JsonNode): Polygon[Vector3] =
  try:
    result = polygon(polyline3FromJsonNode(jsonNode["polyline"]))
  except:
    raise newException(InvalidJsonError,
      "JSON is formatted incorrectly")

proc polygon4FromJsonNode*(jsonNode: JsonNode): Polygon[Vector4] =
  try:
    result = polygon(polyline4FromJsonNode(jsonNode["polyline"]))
  except:
    raise newException(InvalidJsonError,
      "JSON is formatted incorrectly")

proc polygon1FromJson*(jsonString: string): Polygon[Vector1] =
  result = polygon1FromJsonNode(parseJson(jsonString))

proc polygon2FromJson*(jsonString: string): Polygon[Vector2] =
  result = polygon2FromJsonNode(parseJson(jsonString))

proc polygon3FromJson*(jsonString: string): Polygon[Vector3] =
  result = polygon3FromJsonNode(parseJson(jsonString))

proc polygon4FromJson*(jsonString: string): Polygon[Vector4] =
  result = polygon4FromJsonNode(parseJson(jsonString))

proc toJson*(p: Polygon[Vector1]): string =
  result = "{\"polyline\":" & toJson(p.polyline) & "}"

proc toJson*(p: Polygon[Vector2]): string =
  result = "{\"polyline\":" & toJson(p.polyline) & "}"

proc toJson*(p: Polygon[Vector3]): string =
  result = "{\"polyline\":" & toJson(p.polyline) & "}"

proc toJson*(p: Polygon[Vector4]): string =
  result = "{\"polyline\":" & toJson(p.polyline) & "}"