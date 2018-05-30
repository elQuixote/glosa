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
  InvalidInterpolationError

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
  `+=`,
  extend,
  shorten,
  dot,
  fillFromSeq,
  transform,
  rotate,
  scale,
  translate

from ./binomial import binGet
from ./linear import solve, transpose, shape

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

proc homogenize*[Vector, WeightedVector](points: openArray[Vector], weights: openArray[float]): seq[WeightedVector] =
  result = @[]
  for i in 0..<len(points):
    add(result, homogenize(points[i], weights[i]))

proc homogenize*(points: openArray[Vector1], weights: openArray[float]): seq[Vector2] =
  result = homogenize[Vector1, Vector2](points, weights)

proc homogenize*(points: openArray[Vector2], weights: openArray[float]): seq[Vector3] =
  result = homogenize[Vector2, Vector3](points, weights)

proc homogenize*(points: openArray[Vector3], weights: openArray[float]): seq[Vector4] =
  result = homogenize[Vector3, Vector4](points, weights)

proc dehomogenize*(point: Vector2): Vector1 =
  result = shorten(divideNew(point, point.y))

proc dehomogenize*(point: Vector3): Vector2 =
  result = shorten(divideNew(point, point.z))

proc dehomogenize*(point: Vector4): Vector3 =
  result = shorten(divideNew(point, point.w))

proc dehomogenize*[WeightedVector, Vector](points: openArray[WeightedVector]): seq[Vector] =
  result = @[]
  for i in 0..<len(points):
    add(result, dehomogenize(points[i]))

proc dehomogenize*(points: openArray[Vector2]): seq[Vector1] =
  result = dehomogenize[Vector2, Vector1](points)

proc dehomogenize*(points: openArray[Vector3]): seq[Vector2] =
  result = dehomogenize[Vector3, Vector2](points)

proc dehomogenize*(points: openArray[Vector4]): seq[Vector3] =
  result = dehomogenize[Vector4, Vector3](points)

proc weight*(point: Vector2): float =
  result = point.y

proc weight*(point: Vector3): float =
  result = point.z

proc weight*(point: Vector4): float =
  result = point.w

proc weights*[Vector](points: openArray[Vector]): float =
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
  let
    sub = subtractNew(endVertex, startVertex)
    mag = magnitude(sub)
  if mag == 0.0:
    return (u: ustart, v: startVertex)
  let t = dot(subtractNew(v, startVertex), sub) / mag
  if t < 0.0:
    result = (u: ustart, v: startVertex)
  elif t > mag:
    result = (u: uend, v: endVertex)
  else:
    result = (u: ustart + ((uend - ustart) * t / mag), v: addNew(startVertex, multiplyNew(divideNew(sub, mag), t)))

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
  echo "-----"
  echo $i
  echo $degree
  echo $u
  for v in knots:
    echo $v
  echo "-----"
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

  result = fill(newSeq[seq[float]](n + 1), newSeq[float](nc.degree + 1)) # result = ders
  for j in 0..nc.degree:
    result[0][j] = ndu[j][nc.degree]

  var a = [newSeq[float](2), newSeq[float](nc.degree + 1)]
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
      result[k][j] *= acc
    acc *= nc.degree - k

# Constructors
# From data
proc nurbsCurve*[Vector](degree: int, weightedControlPoints: openArray[Vector], knots: openArray[float]): NurbsCurve[Vector] =
  if isValidNurbsCurveData(degree, weightedControlPoints, knots):
    let
      controlPoints = dehomogenize(weightedControlPoints)
      weights = weights(controlPoints)
    result = NurbsCurve(degree: degree, controlPoints: @controlPoints, weights: @weights, knots: @knots)

# From weights
proc nurbsCurve*[Vector](degree: int, controlPoints: openArray[Vector], weights, knots: openArray[float]): NurbsCurve[Vector] =
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
    result = nurbsCurve(degree, controlPoints, weights, knots)

# Accessors
proc weightedControlPoints*[Vector, WeightedVector](nc: NurbsCurve[Vector]): seq[WeightedVector] =
  result = homogenize(nc.controlPoints, nc.weights)

# Rational Sampling (with weights)
proc rationalSample[Vector, WeightedVector](nc: NurbsCurve[Vector], u: float): WeightedVector =
  let
    span = knotSpan(nc, u)
    basisFunctions = basisFunctions(nc, span, u)
    weightedControlPoints = weightedControlPoints(nc)
  var tresult = copy(weightedControlPoints[0])
  result = clear(tresult)
  for j in 0..nc.degree:
    result += multiplyNew(weightedControlPoints[span - nc.degree + j], basisFunctions[j])

proc rationalRegularSampleWithParameter[Vector, WeightedVector](nc: NurbsCurve[Vector], ustart, uend: float, n: int): seq[tuple[u: float, v: WeightedVector]] =
  result = @[]
  let span = (ustart - uend) / (n - 1)
  for i in 0..<n:
    let u = ustart + span * i
    add(result, (u: u, v: rationalSample[Vector, WeightedVector](curve, u)))

proc rationalRegularSampleWithParameter[Vector, WeightedVector](nc: NurbsCurve[Vector], n: int): seq[tuple[u: float, v: WeightedVector]] =
  result = rationalRegularSampleWithParameter[Vector, WeightedVector](nc, nc.knot[0], nc.knot[^1], n)

proc rationalRegularSample[Vector, WeightedVector](nc: NurbsCurve[Vector], ustart, uend: float, n: int): seq[WeightedVector] =
  result = map(rationalRegularSampleWithParameter[Vector, WeightedVector](nc, nc.knot[0], nc.knot[^1], n),
    proc(x: tuple[u: float, v: WeightedVector]): WeightedVector = x.v)

proc rationalRegularSample[Vector, WeightedVector](nc: NurbsCurve[Vector], n: int): seq[WeightedVector] =
  result = rationalRegularSample[Vector, WeightedVector](nc, nc.knot[0], nc.knot[^1], n)

proc rationalSampleDerivatives[Vector, WeightedVector](nc: NurbsCurve[Vector], u: float, n: int): seq[WeightedVector] =
  let
    weightedControlPoints = weightedControlPoints(nc)
    dim = dimension(weightedControlPoints[0])
    du = min(n, nc.degree)
    knotSpan = knotSpan(nc, u)
    derivatives = derivativeBasisFunctions(nc, knotSpan, u)
  result = newSeq[Vector](du)
  for k in 0..<du:
    result[k] = clear(copy(weightedControlPoints[0]))
    for j in 0..<degree:
      result[k] += multiplyNew(weightedControlPoints[knotSpan - nc.degree + j], derivatives[k][j])

# NOTE: Needs refactor (maxits should probably be a threshold not an interation cap)
proc rationalClosestParameter[Vector](nc: NurbsCurve[Vector], v: Vector): float =
  var
    min = high(float)
    u = 0.0

  let
    points = rationalRegularSampleWithParameter(nc, len(nc.controlPoints) * nc.degree)
    weightedControlPoints = weightedControlPoints(nc)

  for i in 0..<len(points):
    let
      u1 = points[i].u
      u2 = points[i + 1].u
      p1 = points[i].v
      p2 = points[i].v
      proj = closestPointWithParameter(v, p1, p2, u1, u2)
      d = magnitude(subtractNew(v, proj.v))
    if (d < min):
      min = d
      u = proj

  const
    MAX_ITERATIONS = 5
    EPSILON_ALPHA = pow(10, -4)
    EPSILON_BETA = pow(5, -5)
  let
    minu = nc.knots[0]
    maxu = nc.knots[^1]
    closed = magnitudeSquared(subtractNew(weightedControlPoints[0], weightedControlPoints[^1])) < EPSILON
  result = u

  proc f(u: float): seq[Vector] =
    result = rationalSampleDerivatives(nc, u, 2)

  proc n(u: float, e: seq[Vector], d: seq[float]): float =
    result = u - dot(e[1], d) / dot(e[2], d) + dot(e[1], e[1])

  for i in 0..<maxits:
    let
      e = f(result)
      dif = subtractNew(e[0], v)
      c1v = magnitude(dif)
      c1 = c1v < EPSILON_ALPHA
      c2 = abs(dot(e[1], dif) / magnitude(e[1]) * c1v) < EPSILON_BETA

    if (c1 and c2):
      break

    var ct = n(result, e, dif)

    if (ct < minu):
      ct = if closed: maxu - (ct - minu) else: minu
    elif (ct > maxu):
      ct = if closed: minu + (ct - maxu) else: maxu

    let c3v = magnitude(multiplySelf(subtractNew(ct, result), e[1]))

    if (c3v < EPSILON_ALPHA):
      break

    result = ct

# Non-rational Sampling
proc sample*[Vector](nc: NurbsCurve[Vector], u: float): Vector =
  result = dehomogenize(rationalSample(nc, u))

proc regularSampleWithParameter*[Vector](nc: NurbsCurve[Vector], ustart, uend: float, n: int): seq[tuple[u: float, v: Vector]] =
  result = @[]
  let span = (ustart - uend) / (n - 1)
  for i in 0..<n:
    let u = ustart + span * i
    add(result, (u: u, v: sample(curve, u)))

proc regularSampleWithParameter*[Vector](nc: NurbsCurve[Vector], n: int): seq[tuple[u: float, v: Vector]] =
  result = regularSampleWithParameter(nc, nc.knot[0], nc.knot[^1], n)

proc regularSample*[Vector](nc: NurbsCurve[Vector], ustart, uend: float, n: int): seq[Vector] =
  result = map(regularSampleWithParameter(nc, nc.knot[0], nc.knot[^1], n),
    proc(x: tuple[u: float, v: Vector]): Vector = x.v)

proc regularSample*[Vector](nc: NurbsCurve[Vector], n: int): seq[Vector] =
  result = regularSample(nc, nc.knot[0], nc.knot[^1], n)

proc sampleDerivative*[Vector](nc: NurbsCurve[Vector], u: float, n: int = 1): seq[Vector] =
  let
    derivatives = rationalSampleDerivatives(nc, u, n)
    wderivatives = weights(derivatives)
  var weightedResult = fill(newSeq[Vector](n), clear(copy(derivatives[0])))
  for k in 0..<n:
    var v = copy(derivatives[k])
    for i in 1..<k:
      v -= multiplyNew(result[k - i], binGet(k, i) * wderivatives[i])
    weightedResult[k] = divideSelf(v, wderivatives[0])
  result = dehomogenize(weightedResult)

proc closestParameter*[Vector](nc: NurbsCurve[Vector], v: Vector): float =
  result = rationalClosestParameter(nc, v)

proc closestPoint*[Vector](nc: NurbsCurve[Vector], v: Vector): Vector =
  result = sample(closestParameter(nc, v))

# Transforms
proc transform*[Vector, Matrix](nc: NurbsCurve[Vector], m: Matrix): Vector =
  var controlPoints = nc.controlPoints
  for i, p in pairs(controlPoints):
    controlPoints[i] = transform(p, m)
  result = nurbsCurve(nc.degree, controlPoints, nc.weights, nc.knots)

proc rotate*(nc: NurbsCurve[Vector2], theta: float): NurbsCurve[Vector2] =
  var controlPoints = nc.controlPoints
  for i, p in pairs(controlPoints):
    var pcopy = copy(p)
    controlPoints[i] = rotate(pcopy, theta)
  result = nurbsCurve(nc.degree, controlPoints, nc.weights, nc.knots)

proc rotate*(nc: NurbsCurve[Vector3], axis: Vector3, theta: float): NurbsCurve[Vector3] =
  var controlPoints = nc.controlPoints
  for i, p in pairs(controlPoints):
    var pcopy = copy(p)
    controlPoints[i] = rotate(pcopy, axis, theta)
  result = nurbsCurve(nc.degree, controlPoints, nc.weights, nc.knots)

proc scale*[Vector](nc: NurbsCurve[Vector], s: float): NurbsCurve[Vector] =
  var controlPoints = nc.controlPoints
  for i, p in pairs(controlPoints):
    var pcopy = copy(p)
    controlPoints[i] = scale(pcopy, s)
  result = nurbsCurve(nc.degree, controlPoints, nc.weights, nc.knots)

proc scale*(nc: NurbsCurve[Vector2], sx, sy: float): NurbsCurve[Vector2] =
  var controlPoints = nc.controlPoints
  for i, p in pairs(controlPoints):
    var pcopy = copy(p)
    controlPoints[i] = scale(pcopy, sx, sy)
  result = nurbsCurve(nc.degree, controlPoints, nc.weights, nc.knots)

proc scale*(nc: NurbsCurve[Vector3], sx, sy, sz: float): NurbsCurve[Vector3] =
  var controlPoints = nc.controlPoints
  for i, p in pairs(controlPoints):
    var pcopy = copy(p)
    controlPoints[i] = scale(pcopy, sx, sy, sz)
  result = nurbsCurve(nc.degree, controlPoints, nc.weights, nc.knots)

proc scale*(nc: NurbsCurve[Vector4], sx, sy, sz, sw: float): NurbsCurve[Vector4] =
  var controlPoints = nc.controlPoints
  for i, p in pairs(controlPoints):
    var pcopy = copy(p)
    controlPoints[i] = scale(pcopy, sx, sy, sz, sw)
  result = nurbsCurve(nc.degree, controlPoints, nc.weights, nc.knots)

proc translate*[Vector](nc: NurbsCurve[Vector], v: Vector): NurbsCurve[Vector] =
  var controlPoints = nc.controlPoints
  for i, p in pairs(controlPoints):
    var pcopy = copy(p)
    controlPoints[i] = translate(pcopy, v)
  result = nurbsCurve(nc.degree, controlPoints, nc.weights, nc.knots)

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