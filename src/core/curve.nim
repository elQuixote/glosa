from ./types import
  NurbsCurve

from ./errors import
  InvalidDegreeError,
  InvalidKnotsError,
  InvalidInterpolationError

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
proc nurbsCurve*[Vector](degree: int, controlPoints: seq[Vector], knots: seq[float]): NurbsCurve =
  if isValidNurbsCurveData(degree, controlPoints, knots):
    result = NurbsCurve(degree: degree, controlPoints: controlPoints, knots: knots)

# From interpolation through points
# TODO
proc nurbsCurve*[Vector](degree: int, points: seq[Vector]): NurbsCurve =
  if isValidInterpolationPoints(degree, points):
    discard

proc copy*[Vector](nc: NurbsCurve): NurbsCurve =
  result = nurbsCurve(nc.degree, nc.controlPoints, nc.knots)


