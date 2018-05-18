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

from math import floor
from strformat import `&`
import hashes

from ./Vector import
  clear,
  copy

# Helpers
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

proc knotSpan[Vector](nc: NurbsCurve[Vector], u: float): int =
  let n = len(nc.knots) - nc.degree - 2
  if (u >= nc.knots[n + 1]): # NOTE: Add tolerance/remove equals?
    return n
  if (u <= nc.knots[nc.degree]): # NOTE: Add tolerance/remove equals?
    return nc.degree
  var
    l = nc.degree
    h = n + 1
  result = floor((l + h) / 2) # result == mid (m)
  while (u < nc.knots[result] or u >= nc.knots[result + 1]):
    if (u < nc.knots[result]):
      h = result
    else:
      l = result
    result = floor((l + h) / 2)

# TODO: Refactor to arrays (maybe change where loop variables are initialized)
proc basisFunctions[Vector](nc: NurbsCurve[Vector], i: int, u: float): seq[float] =
  result = newSeq(float, nc.degree + 1) # result = N (basisFunctions)
  var
    left = newSeq(float, nc.degree + 1)
    right = newSeq(float, nc.degree + 1)
  result[0] = 1.0
  for j in 1..nc.degree:
    left[j] = u - nc.knots[i + 1 - j]
    right[j] = nc.knots[i + j] - u
    var saved = 0.0
    for r in 0..<j:
      var temp = result[r] / (right[r + 1] + left[j - r])
      result[r] = saved + right[r + 1] * temp
      saved = left[j - r] * temp
    result[j] = saved

# TODO: Refactor to arrays (maybe change where loop variables are initialized)
proc derivativeBasisFunctions[Vector](nc: NurbsCurve[Vector], i: int, u: float): array[2, seq[float]] =
  let n = len(nc.knots) - nc.degree - 2
  var
    ndu = [newSeq(float, nc.degree + 1), newSeq(float, nc.degree + 1)]
    left = newSeq(float, nc.degree + 1)
    right = newSeq(float, nc.degree + 1)
  ndu[0][0] = 1.0
  for j in 1..nc.degree:
    left[j] = u - nc.knots[i + 1 - j]
    right[j] = nc.knots[i + j] - u
    var saved = 0.0
    for r in 0..<j:
      ndu[j][r] = right[r + 1] + left[j - r]
      var temp = ndu[r][j - 1] / ndu[j][r]
      ndu[r][j] = saved + right[r + 1] * temp
      saved = left[j - r] * temp
    ndu[j][j] = saved

  result = [newSeq(float, n + 1), newSeq(float, nc.degree + 1)] # result = ders
  for j in 0..nc.degree:
    result[0][j] = ndu[j][nc.degree]
  var a = [newSeq(float, 2), newSeq(float, nc.degree + 1)]
  for r in 0..nc.degree:
    var
      s1 = 0
      s2 = 1
    a[0][0] = 1.0
    for k in 1..n:
      var
        d = 0.0
        j1 = 0
        j2 = 0
        rk = r - k
        pk = nc.degree - k

      if (r >= k):
        a[s2][0] = a[s1][0] / ndu[pk + 1][rk]
        d = a[s2][0] * ndu[rk][pk]

      if (rk >= -1):
        j1 = 1
      else:
        j1 = -rk

      if (r - 1 <= pk):
        j2 = k - 1
      else:
        j2 = nc.degree - r

      for j in j1..j2:
        a[s2][j] = (a[s1][j] - a[s1][j - 1]) / ndu[pk + 1][rk + j]
        d += a[s2][j] * ndu[rk + j][pk]

      if (r <= pk):
        a[s2][k] = -a[s1][k - 1] / ndu[pk + 1][r]
        d += a[s2][k] * ndu[r][pk]

      result[k][r] = d
      swap(s1, s2)

  var acc = nc.degree
  for k in 1..n:
    for j in 0..nc.degree:
      result[k][j] *= acc
    acc *= nc.degree - k

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

proc sample*[Vector](nc: NurbsCurve[Vector], u: float): Vector =
  let
    span = knotSpan(nc, u)
    basisFunctions = basisFunctions(nc, span, u)
  var position = clear(copy(nc.controlPoints[0]))
  for j in 0..nc.degree:
    position += basisFunctions[j] * nc.controlPoints[span - nc.degree + j]

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