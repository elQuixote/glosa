from ./concepts import
  Equals,
  Hash,
  Transform,
  Dimension,
  # Set,
  # Clear,
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

from ./errors import
  InvalidSegmentsError,
  InvalidJsonError

export
  Equals,
  Hash,
  Transform,
  Dimension,
  # Set,
  # Clear,
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
from sequtils import map
import hashes
import json

from ./vector import
  vector1,
  vector2,
  vector3,
  vector4,
  clear,
  copy,
  dimension,
  dot,
  addNew,
  subtractNew,
  multiplySelf,
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
proc lineSegment*[Vector](v1, v2: Vector): LineSegment[Vector] =
  result.startVertex = v1
  result.endVertex = v2

proc areClosed*[Vector](vertices: openArray[Vector]): bool =
  result = len(vertices) > 1 and vertices[0] == vertices[^1]

proc areClosed*[Vector](segments: openArray[LineSegment[Vector]]): bool =
  result = len(segments) > 1 and segments[0].startVertex == segments[^1].endVertex

proc getSegments*[Vector](vertices: openArray[Vector], closed: bool): seq[LineSegment[Vector]] =
  result = @[]
  let l = len(vertices)
  if l > 1:
    for i in 0..<(len(vertices) - 1):
      add(result, lineSegment(vertices[i], vertices[(i + 1)]))
    if closed:
      add(result, lineSegment(vertices[l - 1], vertices[0]))

proc getVertices*[Vector](segments: openArray[LineSegment[Vector]], closed: bool): seq[Vector] =
  result = @[]
  if len(segments) > 0:
    for s in segments:
      add(result, s.startVertex)
    if not closed:
      add(result, segments[^1].endVertex)

proc collapseVertices[Vector](vertices: openArray[Vector]): seq[Vector] =
  result = @[]
  let l = len(vertices)
  for i, v in pairs(vertices):
    if v != vertices[(i + 1) mod l]:
      add(result, v)

proc areSegmentsValid[Vector](segments: openArray[LineSegment[Vector]]): bool =
  result = true
  for i in 0..<(len(segments) - 1):
    if segments[i].endVertex != segments[i + 1].startVertex:
      result = false
      break

proc polyline*[Vector](vertices: openArray[Vector], closed: bool = false): Polyline[Vector] =
  let
    c = closed or areClosed(vertices)
    vs = collapseVertices(vertices)
  result.vertices = @vs
  result.segments = getSegments(vs, c)

proc polyline*[Vector](segments: openArray[LineSegment[Vector]]): Polyline[Vector] =
  if not areSegmentsValid(segments):
    raise newException(InvalidSegmentsError,
      "Segments are disjoint")
  result.vertices = getVertices(segments, areClosed(segments))
  result.segments = @segments

# NOTE: This is added from design doc
proc closestPointTo*[Vector](l: LineSegment[Vector], v: Vector2): Vector2 =
  var sub = subtractNew(l.endVertex, l.startVertex)
  let t = dot(subtractNew(v, l.startVertex), sub) / magnitudeSquared(sub)
  if t < 0.0:
    result = l.startVertex
  elif t > 1.0:
    result = l.endVertex
  else:
    result = addNew(l.startVertex, multiplySelf(sub, t))

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

# NOTE: This is added from design doc
# NOTE: Using Nim paradigm (items, fields, pairs, etc)
iterator vertices*[Vector](p: Polyline[Vector]): Vector =
  for v in p.vertices:
    yield v

iterator segments*[Vector](p: Polyline[Vector]): LineSegment[Vector] =
  for s in p.segments:
    yield s

# NOTE: This is added from design doc
proc isClosed*[Vector](p: Polyline[Vector]): bool =
  result = p.segments[0].startVertex == p.segments[^1].endVertex

# NOTE: This is added from design doc
proc reverse*[Vector](p: Polyline[Vector]): Polyline[Vector] =
  result = polyline(reverse(p.vertices))

# NOTE: This is added from design doc
proc contains*[Vector](p: Polyline[Vector], v: Vector): bool =
  result = contains(polyline.vertices, v)

proc contains*[Vector](p: Polyline[Vector], s: LineSegment): bool =
  result = contains(polyline.segments, s)

# NOTE: This is added from design doc
proc containsPoint*[Vector](p: Polyline[Vector], v: Vector): bool =
  # Checks if a point is contained within the polygon
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

# Equals (compares points in polygon)
proc `==`*[Vector](p1, p2: Polyline[Vector]): bool =
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
proc `!=`*[Vector](p1,p2: Polyline[Vector]): bool =
  result = not (p1 == p2)

# Hash
proc hash*[Vector](p: Polyline[Vector]): hashes.Hash =
  for v in p.vertices:
    result = !$(result !& hash(v))

# # Clear
# proc clear*[Vector](p: var Polyline[Vector]): var Polyline[Vector] {.noinit.} =
#   p.vertices = @[]
#   result = p

# Dimension
proc dimension*[Vector](p: Polyline[Vector]): int =
  if len(p.vertices) != 0:
    result = dimension(p.vertices[0])

# Copy
proc copy*[Vector](p: Polyline[Vector]): Polyline[Vector] =
  result = Polyline(vertices: var p.vertices, segments: var p.segments)

# String
proc `$`*[Vector](p: Polyline[Vector]): string =
  result = ""
  if len(p.vertices) > 0:
    result &= "[" & $p.vertices[0]
    for v in p.vertices[1..^1]:
      result &= ", " & $v
    result &= "]"

# NOTE: This is added from design doc
proc average*[Vector](p: Polyline[Vector]): Vector =
  if len(p.vertices) > 0:
    result = clear(copy(p.vertices[0]))
    for i in 0..<len(p.vertices):
      result += p.vertices[i]
    result /= (float) len(p.vertices)

# Closest Vertex
proc closestVertex*[Vector](p: Polyline[Vector], v: Vector): Vector =
  if len(p.vertices > 0):
    result = clear(copy(p.vertices[0]))
    var minDist = high(float)
    for vertex in p.vertices:
      var dist = distanceToSquared(vertex, v)
      if (dist < minDist):
        result = vertex
        minDist = dist

# To Polyline
proc toPolyline*[Vector](p: Polyline[Vector]): Polyline[Vector] =
  result = p

# To Polygon
proc toPolygon*[Vector](p: Polyline[Vector]): Polygon[Vector] =
  result = Polygon(vertices: var p.vertices)

# Closest Point
proc closestPoint*[Vector](p: Polyline[Vector], v: Vector): Vector =
  if len(p.vertices) > 0:
    result = clear(copy(p.vertices[0]))
    var minDist = high(float)
    for s in p.segments:
      var
        closestVec = s.closestPointTo(v)
        dist = closestVec.distanceToSquared(v)
      if (dist < minDist):
        result = closestVec
        minDist = dist

# Transforms
# Rotate
proc rotate*[Vector](p: var Polyline[Vector], theta: float): var Polyline[Vector] {.noinit.} =
  for i, x in pairs(p.vertices):
    p.vertices[i] = rotate(x, theta)
  result = p
# Scale
proc scale*[Vector](p: var Polyline[Vector], s: float): var Polyline[Vector] {.noinit.} =
  for i, x in pairs(p.vertices):
    p.vertices[i] = scale(x, s)
  result = p

proc scale*[Vector2](p: var Polyline[Vector2], sx, sy: float): var Polyline[Vector2] {.noinit.} =
  for i, x in pairs(p.vertices):
    p.vertices[i] = scale(x, sx, sy)
  result = p

proc scale*[Vector3](p: var Polyline[Vector3], sx, sy, sz: float): var Polyline[Vector3] {.noinit.} =
  for i, x in pairs(p.vertices):
    p.vertices[i] = scale(x, sx, sy, sz)
  result = p

# Translate
proc translate*[Vector](p: var Polyline[Vector], v: Vector): var Polyline[Vector] {.noinit.} =
  for i, x in pairs(p.vertices):
    p.vertices[i] = translate(x, v)
  result = p

# Transform(Matrix)
proc transform*[Vector](p: var Polyline[Vector], m: Matrix): var Polyline[Vector] {.noinit.} =
  for i, x in pairs(p.vertices):
    p.vertices[i] = transform(x, m)
  result = p

# JSON
proc lineSegment1FromJsonNode*(jsonNode: JsonNode): LineSegment[Vector1] =
  try:
    let
      startVertex = jsonNode["startVertex"]
      endVertex = jsonNode["endVertex"]
    result = lineSegment(vector1FromJsonNode(startVertex), vector1FromJsonNode(endVertex))
  except:
    raise newException(InvalidJsonError,
      "JSON is formatted incorrectly")

proc lineSegment2FromJsonNode*(jsonNode: JsonNode): LineSegment[Vector2] =
  try:
    let
      startVertex = jsonNode["startVertex"]
      endVertex = jsonNode["endVertex"]
    result = lineSegment(vector2FromJsonNode(startVertex), vector2FromJsonNode(endVertex))
  except:
    raise newException(InvalidJsonError,
      "JSON is formatted incorrectly")

proc lineSegment3FromJsonNode*(jsonNode: JsonNode): LineSegment[Vector3] =
  try:
    let
      startVertex = jsonNode["startVertex"]
      endVertex = jsonNode["endVertex"]
    result = lineSegment(vector3FromJsonNode(startVertex), vector3FromJsonNode(endVertex))
  except:
    raise newException(InvalidJsonError,
      "JSON is formatted incorrectly")

proc lineSegment4FromJsonNode*(jsonNode: JsonNode): LineSegment[Vector4] =
  try:
    let
      startVertex = jsonNode["startVertex"]
      endVertex = jsonNode["endVertex"]
    result = lineSegment(vector4FromJsonNode(startVertex), vector4FromJsonNode(endVertex))
  except:
    raise newException(InvalidJsonError,
      "JSON is formatted incorrectly")

proc lineSegment1FromJson*(jsonString: string): LineSegment[Vector1] =
  result = lineSegment1FromJsonNode(parseJson(jsonString))

proc lineSegment2FromJson*(jsonString: string): LineSegment[Vector2] =
  result = lineSegment2FromJsonNode(parseJson(jsonString))

proc lineSegment3FromJson*(jsonString: string): LineSegment[Vector3] =
  result = lineSegment3FromJsonNode(parseJson(jsonString))

proc lineSegment4FromJson*(jsonString: string): LineSegment[Vector4] =
  result = lineSegment4FromJsonNode(parseJson(jsonString))

proc toJson*(l: LineSegment[Vector1]): string =
  result = "{\"startVertex\":" & toJson(l.startVertex) & ",\"endVertex:\"" & toJson(l.endVertex) & "}"

proc toJson*(l: LineSegment[Vector2]): string =
  result = "{\"startVertex\":" & toJson(l.startVertex) & ",\"endVertex:\"" & toJson(l.endVertex) & "}"

proc toJson*(l: LineSegment[Vector3]): string =
  result = "{\"startVertex\":" & toJson(l.startVertex) & ",\"endVertex:\"" & toJson(l.endVertex) & "}"

proc toJson*(l: LineSegment[Vector4]): string =
  result = "{\"startVertex\":" & toJson(l.startVertex) & ",\"endVertex:\"" & toJson(l.endVertex) & "}"

proc polyline1FromJsonNode*(jsonNode: JsonNode): Polyline[Vector1] =
  try:
    if contains(jsonNode, "vertices"):
      let
        elems = getElems(jsonNode["vertices"])
        closed = getBool(jsonNode["closed"])
        vertices = map(elems, proc(n: JsonNode): Vector1 = vector1FromJsonNode(n))
      result = polyline(vertices, closed)
    elif contains(jsonNode, "segments"):
      let
        elems = getElems(jsonNode["segments"])
        segments = map(elems, proc(n: JsonNode): LineSegment[Vector1] = lineSegment1FromJsonNode(n))
      result = polyline(segments)
    else:
      raise newException(InvalidJsonError,
        "Incorrect JSON arguments")
  except:
    raise newException(InvalidJsonError,
      "JSON is formatted incorrectly")

proc polyline2FromJsonNode*(jsonNode: JsonNode): Polyline[Vector2] =
  try:
    if contains(jsonNode, "vertices"):
      let
        elems = getElems(jsonNode["vertices"])
        closed = getBool(jsonNode["closed"])
        vertices = map(elems, proc(n: JsonNode): Vector2 = vector2FromJsonNode(n))
      result = polyline(vertices, closed)
    elif contains(jsonNode, "segments"):
      let
        elems = getElems(jsonNode["segments"])
        segments = map(elems, proc(n: JsonNode): LineSegment[Vector2] = lineSegment2FromJsonNode(n))
      result = polyline(segments)
    else:
      raise newException(InvalidJsonError,
        "Incorrect JSON arguments")
  except:
    raise newException(InvalidJsonError,
      "JSON is formatted incorrectly")

proc polyline3FromJsonNode*(jsonNode: JsonNode): Polyline[Vector3] =
  try:
    if contains(jsonNode, "vertices"):
      let
        elems = getElems(jsonNode["vertices"])
        closed = getBool(jsonNode["closed"])
        vertices = map(elems, proc(n: JsonNode): Vector3 = vector3FromJsonNode(n))
      result = polyline(vertices, closed)
    elif contains(jsonNode, "segments"):
      let
        elems = getElems(jsonNode["segments"])
        segments = map(elems, proc(n: JsonNode): LineSegment[Vector3] = lineSegment3FromJsonNode(n))
      result = polyline(segments)
    else:
      raise newException(InvalidJsonError,
        "Incorrect JSON arguments")
  except:
    raise newException(InvalidJsonError,
      "JSON is formatted incorrectly")

proc polyline4FromJsonNode*(jsonNode: JsonNode): Polyline[Vector4] =
  try:
    if contains(jsonNode, "vertices"):
      let
        elems = getElems(jsonNode["vertices"])
        closed = getBool(jsonNode["closed"])
        vertices = map(elems, proc(n: JsonNode): Vector4 = vector4FromJsonNode(n))
      result = polyline(vertices, closed)
    elif contains(jsonNode, "segments"):
      let
        elems = getElems(jsonNode["segments"])
        segments = map(elems, proc(n: JsonNode): LineSegment[Vector4] = lineSegment4FromJsonNode(n))
      result = polyline(segments)
    else:
      raise newException(InvalidJsonError,
        "Incorrect JSON arguments")
  except:
    raise newException(InvalidJsonError,
      "JSON is formatted incorrectly")

proc polyline1FromJson*(jsonString: string): Polyline[Vector1] =
  result = polyline1FromJsonNode(parseJson(jsonString))

proc polyline2FromJson*(jsonString: string): Polyline[Vector2] =
  result = polyline2FromJsonNode(parseJson(jsonString))

proc polyline3FromJson*(jsonString: string): Polyline[Vector3] =
  result = polyline3FromJsonNode(parseJson(jsonString))

proc polyline4FromJson*(jsonString: string): Polyline[Vector4] =
  result = polyline4FromJsonNode(parseJson(jsonString))

# proc toJson*[Vector](p: Polyline[Vector]): string =
#   result = "{\"vertices\":["
#   for v in p.vertices: