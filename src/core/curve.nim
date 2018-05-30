from ./concepts import
  Vector,
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
  Vector1,
  Vector2,
  Vector3,
  Vector4,
  NurbsCurve

from ./errors import
  InvalidDegreeError,
  InvalidKnotsError,
  InvalidInterpolationError,
  InvalidJsonError

from ./constants import
  EPSILON

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

from math import floor, pow
from strformat import `&`
from algorithm import fill
from sequtils import concat, map
import hashes

from ./vector import
  clear,
  copy,
  addNew,
  subtractNew,
  multiplySelf,
  multiplyNew,
  divideSelf,
  divideNew,
  magnitude,
  magnitudeSquared,
  dimension,
  `[]`,
  `[]=`,
  `-=`,
  `+=`,
  extend,
  shorten,
  dot,
  toSeq,
  fillFromSeq,
  transform,
  rotate,
  scale,
  translate,
  vector2FromJsonNode,
  vector3FromJsonNode,
  toJson

from ./binomial import binGet
from ./linear import solve, transpose, shape
import json

# Helpers
# Data Checkers
proc isValidNurbsCurveData[Vector](degree: int, controlPoints: openArray[Vector], knots: openArray[float]): bool =
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

proc isValidInterpolationPoints[Vector](degree: int, points: openArray[Vector]): bool =
  result = true
  if len(points) < degree + 1:
    raise newException(InvalidInterpolationError,
      "Less than degree + 1 points supplied for interpolation")

# Nurbs Utils
proc homogenize*(point: Vector1, weight: float): Vector2 =
  result = extend(multiplyNew(point, weight), weight)

proc homogenize*(point: Vector2, weight: float): Vector3 =
  result = extend(multiplyNew(point, weight), weight)

proc homogenize*(point: Vector3, weight: float): Vector4 =
  result = extend(multiplyNew(point, weight), weight)

proc calculateHomogenized[Vector, WeightedVector](points: openArray[Vector], weights: openArray[float]): seq[WeightedVector] =
  let pointsL = len(points)
  result = newSeq[WeightedVector](pointsL)
  for i in 0..<pointsL:
    result[i] = homogenize(points[i], weights[i])

proc homogenize*(points: openArray[Vector1], weights: openArray[float]): seq[Vector2] =
  result = calculateHomogenized[Vector1, Vector2](points, weights)

proc homogenize*(points: openArray[Vector2], weights: openArray[float]): seq[Vector3] =
  result = calculateHomogenized[Vector2, Vector3](points, weights)

proc homogenize*(points: openArray[Vector3], weights: openArray[float]): seq[Vector4] =
  result = calculateHomogenized[Vector3, Vector4](points, weights)

proc dehomogenize*(point: Vector2): Vector1 =
  result = shorten(divideNew(point, point.y))

proc dehomogenize*(point: Vector3): Vector2 =
  result = shorten(divideNew(point, point.z))

proc dehomogenize*(point: Vector4): Vector3 =
  result = shorten(divideNew(point, point.w))

proc calculateDehomogenized[WeightedVector, Vector](points: openArray[WeightedVector]): seq[Vector] =
  let pointsL = len(points)
  result = newSeq[Vector](pointsL)
  for i in 0..<pointsL:
    result[i] = dehomogenize(points[i])

proc dehomogenize*(points: openArray[Vector2]): seq[Vector1] =
  result = calculateDehomogenized[Vector2, Vector1](points)

proc dehomogenize*(points: openArray[Vector3]): seq[Vector2] =
  result = calculateDehomogenized[Vector3, Vector2](points)

proc dehomogenize*(points: openArray[Vector4]): seq[Vector3] =
  result = calculateDehomogenized[Vector4, Vector3](points)

proc weight*(point: Vector2): float =
  result = point.y

proc weight*(point: Vector3): float =
  result = point.z

proc weight*(point: Vector4): float =
  result = point.w

proc weights*[Vector](points: openArray[Vector]): seq[float] =
  result = map(points, proc(v: Vector): float = weight(v))

# Equality
proc `==`*[Vector](nc1: NurbsCurve[Vector], nc2: NurbsCurve[Vector]): bool =
  result = true
  if (nc1.degree != nc2.degree) or
    (len(nc1.controlPoints) != len(nc2.controlPoints)) or
      (len(nc1.knots) != len(nc2.knots)):
    return false
  for i, v in nc1.knots:
    if (v != nc2.knots[i]):
      return false
  for i, v in nc1.controlPoints:
    if (nc1.weights[i] != nc2.weights[i]):
      return false
    if (v != nc2.controlPoints[i]):
      return false

# Non Equality
proc `!=`*[Vector](nc1: NurbsCurve[Vector], nc2: NurbsCurve[Vector]): bool =
  result = not (nc1 == nc2)

# NOTE: Move all segment operations into a new file
proc closestPointWithParameter[Vector](v, startVertex, endVertex: Vector, ustart, uend: float): tuple[u: float, v: Vector] =
  var sub = subtractNew(endVertex, startVertex)
  let l = magnitude(sub)
  if l == 0.0:
    return (u: ustart, v: startVertex)
  let
    r = divideSelf(sub, l)
    t = dot(subtractNew(v, startVertex), r)
  if t < 0.0:
    result = (u: ustart, v: startVertex)
  elif t > l:
    result = (u: uend, v: endVertex)
  else:
    result = (u: ustart + (uend - ustart) * t / l, v: addNew(startVertex, multiplyNew(r, t)))

proc knotSpan[Vector](n, degree: int, u: float, knots: openArray[Vector]): int =
  if (u >= knots[n + 1]): # NOTE: Add tolerance/remove equals?
    return n
  if (u <= knots[degree]): # NOTE: Add tolerance/remove equals?
    return degree
  var
    l = degree
    h = n + 1
  result = (int) floor((l + h) / 2) # result == mid (m)
  while (u < knots[result] or u >= knots[result + 1]):
    if (u < knots[result]):
      h = result
    else:
      l = result
    result = (int) floor((l + h) / 2)

proc knotSpan[Vector](nc: NurbsCurve[Vector], u: float): int =
  result = knotSpan(len(nc.knots) - nc.degree - 2, nc.degree, u, nc.knots)

# TODO: Refactor to arrays (maybe change where loop variables are initialized)
proc basisFunctions[Vector](i, degree: int, u: float, knots: openArray[Vector]): seq[float] =
  result = newSeq[float](degree + 1) # result = N (basisFunctions)
  var
    left = newSeq[float](degree + 1)
    right = newSeq[float](degree + 1)
  result[0] = 1.0
  for j in 1..degree:
    left[j] = u - knots[i + 1 - j]
    right[j] = knots[i + j] - u
    var saved = 0.0
    for r in 0..<j:
      var temp = result[r] / (right[r + 1] + left[j - r])
      result[r] = saved + right[r + 1] * temp
      saved = left[j - r] * temp
    result[j] = saved

proc basisFunctions[Vector](nc: NurbsCurve[Vector], i: int, u: float): seq[float] =
  result = basisFunctions(i, nc.degree, u, nc.knots)

# TODO: Refactor to arrays (maybe change where loop variables are initialized)
proc derivativeBasisFunctions[Vector](nc: NurbsCurve[Vector], i: int, u: float): seq[seq[float]] =
  let n = len(nc.knots) - nc.degree - 2
  var
    ndu = newSeq[seq[float]](nc.degree + 1)
    left = newSeq[float](nc.degree + 1)
    right = newSeq[float](nc.degree + 1)
  fill(ndu, newSeq[float](nc.degree + 1))
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

  result = newSeq[seq[float]](n + 1)
  fill(result, newSeq[float](nc.degree + 1)) # result = ders
  for j in 0..nc.degree:
    result[0][j] = ndu[j][nc.degree]

  var a = @[newSeq[float](nc.degree + 1), newSeq[float](nc.degree + 1)]
  for r in 0..nc.degree:
    var
      s1 = 0
      s2 = 1
    a[0][0] = 1.0
    for k in 1..n:
      let
        rk = r - k
        pk = nc.degree - k
      var d = 0.0

      if (r >= k):
        a[s2][0] = a[s1][0] / ndu[pk + 1][rk]
        d = a[s2][0] * ndu[rk][pk]

      let
        j1 = if (rk >= -1): 1 else: -rk
        j2 = if (r - 1 <= pk): k - 1 else: nc.degree - r

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
      result[k][j] *= (float) acc
    acc *= nc.degree - k

# Constructors
# From weights
proc nurbsCurve*[Vector](controlPoints: openArray[Vector], weights, knots: openArray[float], degree: int = 3): NurbsCurve[Vector] =
  if isValidNurbsCurveData(degree, controlPoints, knots):
    result = NurbsCurve[Vector](degree: degree, controlPoints: @controlPoints, weights: @weights, knots: @knots)

# From interpolation through points
proc nurbsCurve*[Vector](points: openArray[Vector], degree: int = 3): NurbsCurve[Vector] =
  if isValidInterpolationPoints(degree, points):
    let pointsL = len(points)
    var us = @[0.0]
    for i in 1..<pointsL:
      add(us, us[len(us) - 1] + magnitude(subtractNew(points[i], points[i - 1])))

    let usL = len(us)
    var max = us[usL - 1]
    for i in 0..<usL:
      us[i] = us[i] / max

    var
      knotsStart: seq[float] = newSeq[float](degree + 1)
      s = 1
      e = usL - degree
    fill(knotsStart, 0.0)

    for i in s..<e:
      var weightedSum = 0.0
      for j in 0..<degree:
        weightedSum += us[i + j]
      add(knotsStart, (1 / degree) * weightedSum)

    let
      n = pointsL - 1
      lst = 0
      ld = pointsL - (degree + 1)
    var
      knots: seq[float] = newSeq[float](degree + 1)
      A: seq[seq[float]] = @[]
    fill(knots, 1.0)
    knots = concat(knotsStart, knots)
    for u in us:
      let
        span = knotSpan(n, degree, u, knots)
        basisFunctions = basisFunctions(span, degree, u, knots)
        ls = span - degree
      var
        rowStart = newSeq[float](ls)
        rowEnd = newSeq[float](ld - ls)
      add(A, concat(concat(rowStart, basisFunctions), rowEnd))

    let
      dim = dimension(points[0])
      mult1 = knots[degree + 1] / (float) degree
      mult2 = (1 - knots[len(knots) - degree - 2]) / (float) degree
    var xs: seq[seq[float]] = @[]

    for i in 0..<dim:
      var b = map(points, proc(x: Vector): float = x[i])
      add(xs, solve(A, b))

    let sxs = shape(xs)
    var controlPoints = newSeq[Vector](len(sxs))
    for i, v in pairs(sxs):
      fillFromSeq(controlPoints[i], v)

    var weights = newSeq[float](len(controlPoints))
    fill(weights, 1.0)
    result = nurbsCurve(controlPoints, weights, knots, degree)

# Accessors
# TODO: Revert to generics
proc weightedControlPoints*(nc: NurbsCurve[Vector1]): seq[Vector2] =
  result = homogenize(nc.controlPoints, nc.weights)

proc weightedControlPoints*(nc: NurbsCurve[Vector2]): seq[Vector3] =
  result = homogenize(nc.controlPoints, nc.weights)

proc weightedControlPoints*(nc: NurbsCurve[Vector3]): seq[Vector4] =
  result = homogenize(nc.controlPoints, nc.weights)

# Rational Sampling (with weights)
proc calculateRationalSample[Vector, WeightedVector](nc: NurbsCurve[Vector], u: float): WeightedVector =
  let
    span = knotSpan(nc, u)
    basisFunctions = basisFunctions(nc, span, u)
    weightedControlPoints = weightedControlPoints(nc)
  var tresult = copy(weightedControlPoints[0])
  result = clear(tresult)
  for j in 0..nc.degree:
    result += multiplyNew(weightedControlPoints[span - nc.degree + j], basisFunctions[j])

proc rationalSample*(nc: NurbsCurve[Vector1], u: float): Vector2 =
  result = calculateRationalSample[Vector1, Vector2](nc, u)

proc rationalSample*(nc: NurbsCurve[Vector2], u: float): Vector3 =
  result = calculateRationalSample[Vector2, Vector3](nc, u)

proc rationalSample*(nc: NurbsCurve[Vector3], u: float): Vector4 =
  result = calculateRationalSample[Vector3, Vector4](nc, u)

proc calculateRationalRegularSampleWithParameter[Vector, WeightedVector](nc: NurbsCurve[Vector], ustart, uend: float, n: int): seq[tuple[u: float, v: WeightedVector]] =
  result = newSeq[tuple[u: float, v: WeightedVector]](n)
  let
    num = if n < 1: 2 else: n
    span = (uend - ustart) / ((float) num - 1)
  for i in 0..<num:
    let u = ustart + span * (float) i
    result[i] = (u: u, v: rationalSample(nc, u))

proc rationalRegularSampleWithParameter(nc: NurbsCurve[Vector1], ustart, uend: float, n: int): seq[tuple[u: float, v: Vector2]] =
  result = calculateRationalRegularSampleWithParameter[Vector1, Vector2](nc, ustart, uend, n)

proc rationalRegularSampleWithParameter(nc: NurbsCurve[Vector2], ustart, uend: float, n: int): seq[tuple[u: float, v: Vector3]] =
  result = calculateRationalRegularSampleWithParameter[Vector2, Vector3](nc, ustart, uend, n)

proc rationalRegularSampleWithParameter(nc: NurbsCurve[Vector3], ustart, uend: float, n: int): seq[tuple[u: float, v: Vector4]] =
  result = calculateRationalRegularSampleWithParameter[Vector3, Vector4](nc, ustart, uend, n)

proc rationalRegularSampleWithParameter*(nc: NurbsCurve[Vector1], n: int): seq[tuple[u: float, v: Vector2]] =
  result = rationalRegularSampleWithParameter(nc, nc.knots[0], nc.knots[^1], n)

proc rationalRegularSampleWithParameter*(nc: NurbsCurve[Vector2], n: int): seq[tuple[u: float, v: Vector3]] =
  result = rationalRegularSampleWithParameter(nc, nc.knots[0], nc.knots[^1], n)

proc rationalRegularSampleWithParameter*(nc: NurbsCurve[Vector3], n: int): seq[tuple[u: float, v: Vector4]] =
  result = rationalRegularSampleWithParameter(nc, nc.knots[0], nc.knots[^1], n)

proc calculateRationalRegularSample[Vector, WeightedVector](nc: NurbsCurve[Vector], ustart, uend: float, n: int): seq[WeightedVector] =
  result = map(rationalRegularSampleWithParameter[Vector, WeightedVector](nc, nc.knots[0], nc.knots[^1], n),
    proc(x: tuple[u: float, v: WeightedVector]): WeightedVector = x.v)

proc rationalRegularSample(nc: NurbsCurve[Vector1], ustart, uend: float, n: int): seq[Vector2] =
  result = calculateRationalRegularSample[Vector1, Vector2](nc, ustart, uend, n)

proc rationalRegularSample(nc: NurbsCurve[Vector2], ustart, uend: float, n: int): seq[Vector3] =
  result = calculateRationalRegularSample[Vector2, Vector3](nc, ustart, uend, n)

proc rationalRegularSample(nc: NurbsCurve[Vector3], ustart, uend: float, n: int): seq[Vector4] =
  result = calculateRationalRegularSample[Vector3, Vector4](nc, ustart, uend, n)

proc rationalRegularSample*(nc: NurbsCurve[Vector1], n: int): seq[Vector2] =
  result = rationalRegularSample(nc, nc.knots[0], nc.knots[^1], n)

proc rationalRegularSample*(nc: NurbsCurve[Vector2], n: int): seq[Vector3] =
  result = rationalRegularSample(nc, nc.knots[0], nc.knots[^1], n)

proc rationalRegularSample*(nc: NurbsCurve[Vector3], n: int): seq[Vector4] =
  result = rationalRegularSample(nc, nc.knots[0], nc.knots[^1], n)

proc calculateRationalSampleDerivatives[Vector, WeightedVector](nc: NurbsCurve[Vector], u: float, n: int): seq[WeightedVector] =
  let
    weightedControlPoints = weightedControlPoints(nc)
    dim = dimension(weightedControlPoints[0])
    du = if n < nc.degree: n else: nc.degree
    knotSpan = knotSpan(nc, u)
    derivatives = derivativeBasisFunctions(nc, knotSpan, u)
  result = newSeq[WeightedVector](n + 1)
  for k in 0..du:
    var kcopy = copy(weightedControlPoints[0])
    result[k] = clear(kcopy)
    for j in 0..nc.degree:
      result[k] += multiplyNew(weightedControlPoints[knotSpan - nc.degree + j], derivatives[k][j])

proc rationalSampleDerivatives*(nc: NurbsCurve[Vector1], u: float, n: int): seq[Vector2] =
  result = calculateRationalSampleDerivatives[Vector1, Vector2](nc, u, n)

proc rationalSampleDerivatives*(nc: NurbsCurve[Vector2], u: float, n: int): seq[Vector3] =
  result = calculateRationalSampleDerivatives[Vector2, Vector3](nc, u, n)

proc rationalSampleDerivatives*(nc: NurbsCurve[Vector3], u: float, n: int): seq[Vector4] =
  result = calculateRationalSampleDerivatives[Vector3, Vector4](nc, u, n)

# Non-rational Sampling
proc sample*[Vector](nc: NurbsCurve[Vector], u: float): Vector =
  result = dehomogenize(rationalSample(nc, u))

proc regularSampleWithParameter*[Vector](nc: NurbsCurve[Vector], ustart, uend: float, n: int): seq[tuple[u: float, v: Vector]] =
  result = newSeq[tuple[u: float, v: Vector]](n)
  let span = (ustart - uend) / (n - 1)
  for i in 0..<n:
    let u = ustart + span * i
    result[i] = (u: u, v: sample(curve, u))

proc regularSampleWithParameter*[Vector](nc: NurbsCurve[Vector], n: int): seq[tuple[u: float, v: Vector]] =
  result = regularSampleWithParameter(nc, nc.knot[0], nc.knot[^1], n)

proc regularSample*[Vector](nc: NurbsCurve[Vector], ustart, uend: float, n: int): seq[Vector] =
  result = map(regularSampleWithParameter(nc, nc.knot[0], nc.knot[^1], n),
    proc(x: tuple[u: float, v: Vector]): Vector = x.v)

proc regularSample*[Vector](nc: NurbsCurve[Vector], n: int): seq[Vector] =
  result = regularSample(nc, nc.knot[0], nc.knot[^1], n)

proc sampleDerivatives*[Vector](nc: NurbsCurve[Vector], u: float, n: int = 1): seq[Vector] =
  let
    derivatives = rationalSampleDerivatives(nc, u, n)
    wderivatives = weights(derivatives)
  var weightedResult = derivatives
  for i in 0..n:
    weightedResult[i] = clear(weightedResult[i])
  for k in 0..n:
    var v = copy(derivatives[k])
    for i in 1..k:
      v -= multiplyNew(weightedResult[k - i], binGet(k, i) * wderivatives[i])
    weightedResult[k] = divideSelf(v, wderivatives[0])
  result = newSeq[Vector](n)
  for i in 0..<n:
    result[i] = shorten(weightedResult[i])

# NOTE: Needs refactor (maxits should probably be a threshold not an interation cap)
proc calculateRationalClosestParameter[Vector, WeightedVector](nc: NurbsCurve[Vector], v: Vector): float =
  var
    min = high(float)
    u = 0.0

  let
    points = rationalRegularSampleWithParameter(nc, len(nc.controlPoints) * nc.degree)
    weightedControlPoints = weightedControlPoints(nc)
    wv = extend(v, 1.0)

  for i in 0..<(len(points) - 1):
    let
      u1 = points[i].u
      u2 = points[i + 1].u
      p1 = dehomogenize(points[i].v)
      p2 = dehomogenize(points[i + 1].v)
      proj = closestPointWithParameter(v, p1, p2, u1, u2)
      d = magnitude(subtractNew(v, proj.v))
    if (d < min):
      min = d
      u = proj.u

  const
    MAX_ITERATIONS = 5
    EPSILON_ALPHA = pow(10.0, -4)
    EPSILON_BETA = pow(5.0, -5)
  let
    minu = nc.knots[0]
    maxu = nc.knots[^1]
    closed = magnitudeSquared(subtractNew(weightedControlPoints[0], weightedControlPoints[^1])) < EPSILON
  result = u

  for i in 0..<MAX_ITERATIONS:
    var e = rationalSampleDerivatives(nc, result, 2)
    let
      dif = subtractNew(e[0], wv)
      mdif = magnitude(dif)
      c1 = mdif < EPSILON_ALPHA
      c2 = abs(dot(e[1], dif) / magnitude(e[1]) * mdif) < EPSILON_BETA

    if (c1 and c2):
      break

    var ct = result - dot(e[1], dif) / (dot(e[2], dif) + dot(e[1], e[1]))

    if (ct < minu):
      ct = if closed: maxu - (ct - minu) else: minu
    elif (ct > maxu):
      ct = if closed: minu + (ct - maxu) else: maxu

    let m = magnitude(multiplySelf(e[1], ct - result))

    if (m < EPSILON_ALPHA):
      break

    result = ct

proc rationalClosestParameter*(nc: NurbsCurve[Vector1], v: Vector1): float =
  result = calculateRationalClosestParameter[Vector1, Vector2](nc, v)

proc rationalClosestParameter*(nc: NurbsCurve[Vector2], v: Vector2): float =
  result = calculateRationalClosestParameter[Vector2, Vector3](nc, v)

proc rationalClosestParameter*(nc: NurbsCurve[Vector3], v: Vector3): float =
  result = calculateRationalClosestParameter[Vector3, Vector4](nc, v)

proc closestParameter*[Vector](nc: NurbsCurve[Vector], v: Vector): float =
  result = rationalClosestParameter(nc, v)

proc closestPoint*[Vector](nc: NurbsCurve[Vector], v: Vector): Vector =
  result = sample(closestParameter(nc, v))

# Transforms
proc transform*[Vector, Matrix](nc: NurbsCurve[Vector], m: Matrix): Vector =
  var controlPoints = nc.controlPoints
  for i in 0..<len(controlPoints):
    controlPoints[i] = transform(controlPoints[i], m)
  result = nurbsCurve(controlPoints, nc.weights, nc.knots, nc.degree)

proc rotate*(nc: NurbsCurve[Vector2], theta: float): NurbsCurve[Vector2] =
  var controlPoints = nc.controlPoints
  for i in 0..<len(controlPoints):
    controlPoints[i] = rotate(controlPoints[i], theta)
  result = nurbsCurve(controlPoints, nc.weights, nc.knots, nc.degree)

proc rotate*(nc: NurbsCurve[Vector3], axis: Vector3, theta: float): NurbsCurve[Vector3] =
  var controlPoints = nc.controlPoints
  for i in 0..<len(controlPoints):
    controlPoints[i] = rotate(controlPoints[i], axis, theta)
  result = nurbsCurve(controlPoints, nc.weights, nc.knots, nc.degree)

proc scale*[Vector](nc: NurbsCurve[Vector], s: float): NurbsCurve[Vector] =
  var controlPoints = nc.controlPoints
  for i in 0..<len(controlPoints):
    controlPoints[i] = scale(controlPoints[i], s)
  result = nurbsCurve(controlPoints, nc.weights, nc.knots, nc.degree)

proc scale*(nc: NurbsCurve[Vector2], sx, sy: float): NurbsCurve[Vector2] =
  var controlPoints = nc.controlPoints
  for i in 0..<len(controlPoints):
    controlPoints[i] = scale(controlPoints[i], sx, sy)
  result = nurbsCurve(controlPoints, nc.weights, nc.knots, nc.degree)

proc scale*(nc: NurbsCurve[Vector3], sx, sy, sz: float): NurbsCurve[Vector3] =
  var controlPoints = nc.controlPoints
  for i in 0..<len(controlPoints):
    controlPoints[i] = scale(controlPoints[i], sx, sy, sz)
  result = nurbsCurve(controlPoints, nc.weights, nc.knots, nc.degree)

proc scale*(nc: NurbsCurve[Vector4], sx, sy, sz, sw: float): NurbsCurve[Vector4] =
  var controlPoints = nc.controlPoints
  for i in 0..<len(controlPoints):
    controlPoints[i] = scale(controlPoints[i], sx, sy, sz, sw)
  result = nurbsCurve(controlPoints, nc.weights, nc.knots, nc.degree)

proc translate*[Vector](nc: NurbsCurve[Vector], v: Vector): NurbsCurve[Vector] =
  var controlPoints = nc.controlPoints
  for i in 0..<len(controlPoints):
    controlPoints[i] = translate(controlPoints[i], v)
  result = nurbsCurve(controlPoints, nc.weights, nc.knots, nc.degree)

# Hash
proc hash*[Vector](nc: NurbsCurve[Vector]): hashes.Hash =
  let wcp = weightedControlPoints(nc)
  result = !$(result !& hash(nc.degree))
  for i, v in wcp:
    result = result !& hash(v)
  for i, v in nc.knots:
    result = result !& hash(v)

# Dimension
proc dimension*[Vector](nc: NurbsCurve[Vector]): int =
  if len(nc.controlPoints) != 0:
    result = dimension(nc.vertices[0])

# Copy
proc copy*[Vector](nc: NurbsCurve[Vector]): NurbsCurve[Vector] =
  result = NurbsCurve(degree: nc.degree, controlPoints: var nc.controlPoints, weights: var nc.weights, knots: var nc.knots)

# String
proc `$`*[Vector](nc: NurbsCurve[Vector]): string =
  result = "{ degree: " & $nc.degree
  if len(nc.controlPoints) > 0:
    result &= ", controlPoints: [" & $nc.controlPoints[0]
    for v in nc.controlPoints[1..^1]:
      result &= ", " & $v
    result &= "]"
  if len(nc.weights) > 0:
    result &= ", weights: [" & $nc.weights[0]
    for v in nc.weights[1..^1]:
      result &= ", " & $v
    result &= "]"
  if len(nc.knots) > 0:
    result &= ", knots: [" & $nc.knots[0]
    for v in nc.knots[1..^1]:
      result &= ", " & $v
    result &= "]"
  result &= " }"

# JSON
proc mapVector2Sequence(vectors: JsonNode): seq[Vector2] =
  result = map(getElems(vectors), proc(n: JsonNode): Vector2 = vector2FromJsonNode(n))

proc mapVector3Sequence(vectors: JsonNode): seq[Vector3] =
  result = map(getElems(vectors), proc(n: JsonNode): Vector3 = vector3FromJsonNode(n))

proc nurbsCurve2FromJsonNode(jsonNode: JsonNode): NurbsCurve[Vector2] =
  try:
    let
      degree = getInt(jsonNode["degree"])
      controlPoints = mapVector2Sequence(jsonNode["controlPoints"])
      weights = map(getElems(jsonNode["weights"]), proc(n: JsonNode): float = getFloat(n))
      knots = map(getElems(jsonNode["knots"]), proc(n: JsonNode): float = getFloat(n))
    result = nurbsCurve(controlPoints, weights, knots, degree)
  except:
    raise newException(InvalidJsonError,
      "JSON is formatted incorrectly")

proc nurbsCurve3FromJsonNode(jsonNode: JsonNode): NurbsCurve[Vector3] =
  try:
    let
      degree = getInt(jsonNode["degree"])
      controlPoints = mapVector3Sequence(jsonNode["controlPoints"])
      weights = map(getElems(jsonNode["weights"]), proc(n: JsonNode): float = getFloat(n))
      knots = map(getElems(jsonNode["knots"]), proc(n: JsonNode): float = getFloat(n))
    result = nurbsCurve(controlPoints, weights, knots, degree)
  except:
    raise newException(InvalidJsonError,
      "JSON is formatted incorrectly")

proc nurbsCurve2FromJson*(jsonString: string): NurbsCurve[Vector2] =
  result = nurbsCurve2FromJsonNode(parseJson(jsonString))

proc nurbsCurve3FromJson*(jsonString: string): NurbsCurve[Vector3] =
  result = nurbsCurve3FromJsonNode(parseJson(jsonString))

proc nurbsCurve2InterpolationFromJsonNode(jsonNode: JsonNode): NurbsCurve[Vector2] =
  try:
    let
      degree = getInt(jsonNode["degree"])
      points = mapVector2Sequence(jsonNode["points"])
    result = nurbsCurve(points, degree)
  except:
    raise newException(InvalidJsonError,
      "JSON is formatted incorrectly")

proc nurbsCurve3InterpolationFromJsonNode(jsonNode: JsonNode): NurbsCurve[Vector3] =
  try:
    let
      degree = getInt(jsonNode["degree"])
      points = mapVector3Sequence(jsonNode["points"])
    result = nurbsCurve(points, degree)
  except:
    raise newException(InvalidJsonError,
      "JSON is formatted incorrectly")

proc nurbsCurve2InterpolationFromJson*(jsonString: string): NurbsCurve[Vector2] =
  result = nurbsCurve2InterpolationFromJsonNode(parseJson(jsonString))

proc nurbsCurve3InterpolationFromJson*(jsonString: string): NurbsCurve[Vector3] =
  result = nurbsCurve3InterpolationFromJsonNode(parseJson(jsonString))

proc toJson*(nc: NurbsCurve[Vector2]): string =
  result = "{\"degree\":" & $nc.degree
  if len(nc.controlPoints) > 0:
    result &= ",\"controlPoints\":[" & toJson(nc.controlPoints[0])
    for v in nc.controlPoints[1..^1]:
      result &= "," & toJson(v)
    result &= "]"
  if len(nc.weights) > 0:
    result &= ",\"weights\":[" & $nc.weights[0]
    for v in nc.weights[1..^1]:
      result &= "," & $v
    result &= "]"
  if len(nc.knots) > 0:
    result &= ",\"knots\":[" & $nc.knots[0]
    for v in nc.knots[1..^1]:
      result &= "," & $v
    result &= "]"
  result &= "}"

proc toJson*(nc: NurbsCurve[Vector3]): string =
  result = "{\"degree\":" & $nc.degree
  if len(nc.controlPoints) > 0:
    result &= ",\"controlPoints\":[" & toJson(nc.controlPoints[0])
    for v in nc.controlPoints[1..^1]:
      result &= "," & toJson(v)
    result &= "]"
  if len(nc.weights) > 0:
    result &= ",\"weights\":[" & $nc.weights[0]
    for v in nc.weights[1..^1]:
      result &= "," & $v
    result &= "]"
  if len(nc.knots) > 0:
    result &= ",\"knots\":[" & $nc.knots[0]
    for v in nc.knots[1..^1]:
      result &= "," & $v
    result &= "]"
  result &= "}"