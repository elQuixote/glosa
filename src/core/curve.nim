from ./concepts import
  Equals,
  Hash,
  Transform,
  Dimension,
  # Clear,
  Copy,
  String,
  # Centroid,
  Closest

from ./types import
  NurbsCurve

from ./errors import
  InvalidDegreeError,
  InvalidKnotsError,
  InvalidInterpolationError

export
  Equals,
  Hash,
  Transform,
  Dimension,
  # Clear,
  Copy,
  String,
  # Centroid,
  Closest,
  NurbsCurve,
  InvalidDegreeError,
  InvalidKnotsError,
  InvalidInterpolationError

from strformat import `&`
import hashes

proc isValidNurbsCurveData[Vector](degree: int, controlPoints: seq[Vector], knots: seq[float]): bool =
  result = true
  let knotsLen = len(knots)
  if degree < 1:
    raise newException(InvalidDegreeError,
      "Degree is less than 1")
  if knotsLen == 0 or (knotsLen != len(controlPoints) + degree + 1):
    raise newException(InvalidKnotsError,
      "len(knots) does not equal len(controlPoints) + degree + 1")
  for i in 1..degree:
    if knots[i] != knots[0] or knots[^(1 + i)] != knots[^1]:
      raise newException(InvalidKnotsError,
        "Knots must begin and end with degree + 1 repeats")

proc isValidInterpolationPoints[Vector](degree: int, points: seq[Vector]): bool =
  result = true
  if len(points) < degree + 1:
    raise newException(InvalidInterpolationError,
      "Less than degree + 1 points given for interpolation")

# Constructors
# From data
proc nurbsCurve*[Vector](degree: int, controlPoints: seq[Vector], knots: seq[float]): NurbsCurve[Vector] =
  if isValidNurbsCurveData(degree, controlPoints, knots):
    result = NurbsCurve(degree: degree, controlPoints: controlPoints, knots: knots)

# From interpolation through points
# TODO
proc nurbsCurve*[Vector](degree: int, points: seq[Vector]): NurbsCurve[Vector] =
  if isValidInterpolationPoints(degree, points):
    discard

proc `==`*[Vector](nc1: NurbsCurve[Vector], nc2: NurbsCurve[Vector]): bool =
  result = true
  if (nc1.degree != nc2.degree) or
    (len(nc1.controlPoints) != len(nc2.controlPoints)) or
      (len(nc1.knots) != len(nc2.knots)):
    return false
  for i, v in nc1.controlPoints:
    if (v != nc2.controlPoints[i]):
      return false
  for i, v in nc1.knots:
    if (v != nc2.knots[i]):
      return false

proc `!=`*[Vector](nc1: NurbsCurve[Vector], nc2: NurbsCurve[Vector]): bool =
  result = not (nc1 == nc2)

proc hash*[Vector](nc: NurbsCurve[Vector]): hashes.Hash =
  result = !$(result !& hash(nc.degree))
  for i, v in nc.controlPoints:
    result = result !& hash(v)
  for i, v in nc.knots:
    result = result !& hash(v)

proc dimension*[Vector](nc: NurbsCurve[Vector]): int =
  if len(nc.controlPoints) != 0:
    result = dimension(nc.vertices[0])

proc copy*[Vector](nc: NurbsCurve[Vector]): NurbsCurve[Vector] =
  result = nurbsCurve(nc.degree, nc.controlPoints, nc.knots)

proc `$`*[Vector](nc: NurbsCurve[Vector]): string =
  result = "{ degree: " & nc.degree
  if len(nc.controlPoints) > 0:
    result &= ", controlPoints: [" & $nc.controlPoints[0]
    for v in nc.controlPoints[1..^1]:
      result &= ", " & $v
    result &= "]"
  if len(nc.knots) > 0:
    result &= ", knots: [" & $nc.knots[0]
    for v in nc.knots[1..^1]:
      result &= ", " & $v
    result &= "]"
  result &= " }"