from ../../src/core/constants import EPSILON
import ../../src/core/vector
import ../../src/core/curve
import unittest

proc compareValuesWithinEpsilon(a, b: openarray[float]): bool =
  result = true
  let
    aL = len(a)
    bL = len(b)
  if aL != bL:
    checkpoint("len of a was " & $aL)
    checkpoint("len of b was " & $bL)
    result = false
  for i in 0..<aL:
    if abs(a[i] - b[i]) >= EPSILON:
      checkpoint("a[" & $i & "] was " & $a[i])
      checkpoint("b[" & $i & "] was " & $b[i])
      result = false

proc compareVectorsWithinEpsilon(a, b: openarray[Vector]): bool =
  result = true
  let
    aL = len(a)
    bL = len(b)
  if aL != bL:
    checkpoint("len of a was " & $aL)
    checkpoint("len of b was " & $bL)
    result = false
  for i in 0..<aL:
    for j in 0..<dimension(a[i]):
      if abs(a[i][j] - b[i][j]) >= EPSILON:
        checkpoint("a[" & $i & "][" & $j & "] was " & $a[i])
        checkpoint("b[" & $i & "][" & $j & "] was " & $b[i])
        result = false

suite "Constructing 2D NURBS Curves":
  test "Constructing 2D NURBS Curves with weighted points":
    discard
  test "Constructing 2D NURBS Curves with points and weights":
    discard
  test "Constructing 2D NURBS Curves by interpolation":
    let
      nc = nurbsCurve([vector3(0.463993,2.10996,2.19132),
                       vector3(0.0112093,0.828282,2.571),
                       vector3(0.426337,1.5089,0.497359),
                       vector3(0.0692439,2.52657,2.6116),
                       vector3(0.440637,1.57182,0.09436)])
      edegree = 3
      ecps = @[vector3(0.46399300000000004, 2.1099600000000005, 2.1913200000000006),
              vector3(-0.4939215779588224, 0.043901158682498054, 4.272856516461007),
              vector3(1.4965219659478346, 1.9218617897122912, -4.450338481709175),
              vector3(-0.7576280902353973, 3.2842298191163155, 6.934536722187345),
              vector3(0.440637, 1.57182, 0.09436)]
      eweights = @[1.0, 1.0, 1.0, 1.0, 1.0]
      eknots = @[0.0, 0.0, 0.0, 0.0, 0.4222276538130334, 1.0, 1.0, 1.0, 1.0]
    check:
      nc.degree == edegree
      compareVectorsWithinEpsilon(nc.controlPoints, ecps)
      compareValuesWithinEpsilon(nc.weights, eweights)
      compareValuesWithinEpsilon(nc.knots, eknots)




suite "Constructing 3D NURBS Curves":
  test "Constructing 3D NURBS Curves with weighted points":
    discard
  test "Constructing 3D NURBS Curves with points and weights":
    discard
  test "Constructing 3D NURBS Curves by interpolation":
    discard