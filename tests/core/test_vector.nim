import ../../src/core/vector
import unittest

from system import `@`, abs
from math import pow, sqrt, PI
from sequtils import zip, toSeq

const
  ETA = pow(10.0, -6)

# Vector testing utilities
proc compareVectorToValue(vector: Vector, value: float): bool =
  let a = vector.toArray()
  result = true
  for v in a:
    if v != value:
      result = false
  if not result:
    checkpoint("vector was " & $vector)
    checkpoint("value was " & $value)

proc compareVectorToValues(vector: Vector, values: seq[float]): bool =
  let a = vector.toArray()
  result = true
  for i, v in a:
    if v != values[i]:
      result = false
  if not result:
    checkpoint("vector was " & $vector)
    checkpoint("values were " & $values)

proc compareValuesWithinEta(a, b: float): bool =
  if abs(a - b) >= ETA:
    result = false
    checkpoint("a was " & $a)
    checkpoint("b was " & $b)
  else:
    result = true

proc compareVectorsWithinEta(v1, v2: Vector): bool =
  let s = zip(v1.toArray(), v2.toArray())
  result = true
  for v in s:
    if abs(v[0] - v[1]) >= ETA:
      result = false
  if not result:
    checkpoint("v1 was " & $v1)
    checkpoint("v2 was " & $v2)

suite "Testing Vector equality and inequality":
  proc testVectorEquality(v1, v2, v3: Vector) =
    check:
      v1 == v2
      v1 != v3
  test "Testing Vector1 equality and inequality":
    testVectorEquality(
      Vector1(x: 0.0),
      Vector1(x: 0.0),
      Vector1(x: 1.0))
  test "Testing Vector2 equality and inequality":
    testVectorEquality(
      Vector2(x: 0.0, y: 1.0),
      Vector2(x: 0.0, y: 1.0 ),
      Vector2(x: 1.0, y: 2.0))
  test "Testing Vector3 equality and inequality":
    testVectorEquality(
      Vector3(x: 0.0, y: 1.0, z: 2.0),
      Vector3(x: 0.0, y: 1.0, z: 2.0 ),
      Vector3(x: 1.0, y: 2.0, z: 3.0))
  test "Testing Vector4 equality and inequality":
    testVectorEquality(
      Vector4(x: 0.0, y: 1.0, z: 2.0, w: 3.0),
      Vector4(x: 0.0, y: 1.0, z: 2.0, w: 3.0 ),
      Vector4(x: 1.0, y: 2.0, z: 3.0, w: 0.0))

suite "Comparing Vectors":
  proc testCompareVectors(small, big: Vector) =
    let
      otherSmall = small.copy()
    check:
      not (small < otherSmall)
      not (big < small)
      small < big
      not (big <= small)
      small <= otherSmall
      small <= big
      not (small > otherSmall)
      not (small > big)
      big > small
      not (small >= big)
      small >= otherSmall
      big >= small
  test "Comparing Vector1s":
    testCompareVectors(vector1(1.0), vector1(2.0))
  test "Comparing Vector2s":
    testCompareVectors(vector2(1.0), vector2(2.0))
  test "Comparing Vector3s":
    testCompareVectors(vector3(1.0), vector3(2.0))
  test "Comparing Vector4s":
    testCompareVectors(vector4(1.0), vector4(2.0))

suite "Creating a new Vector with default constructor":
  proc testCreateVectorDefaultConstructor(v1, v2: Vector) =
    check:
      v1 == v2
  test "Creating a Vector1 with the default constructor":
    testCreateVectorDefaultConstructor(
      Vector1(x: 0.0),
      vector1(0.0))
  test "Creating a Vector2 with the default constructor":
    testCreateVectorDefaultConstructor(
      Vector2(x: 0.0, y: 1.0),
      vector2(0.0, 1.0))
  test "Creating a Vector3 with the default constructor":
    testCreateVectorDefaultConstructor(
      Vector3(x: 0.0, y: 1.0, z: 2.0),
      vector3(0.0, 1.0, 2.0))
  test "Creating a Vector4 with the default constructor":
    testCreateVectorDefaultConstructor(
      Vector4(x: 0.0, y: 1.0, z: 2.0, w: 3.0),
      vector4(0.0, 1.0, 2.0, 3.0))

suite "Creating a new Vector with single value constructor":
  proc testCreateVectorSingleValueConstructor(v1, v2: Vector) =
    check:
      v1 == v2
  test "Creating a Vector2 with single value constructor":
    testCreateVectorSingleValueConstructor(
        Vector2(x: 0.0, y: 0.0),
        vector2(0.0))
  test "Creating a Vector3 with single value constructor":
    testCreateVectorSingleValueConstructor(
        Vector3(x: 0.0, y: 0.0, z: 0.0),
        vector3(0.0))
  test "Creating a Vector4 with single value constructor":
    testCreateVectorSingleValueConstructor(
        Vector4(x: 0.0, y: 0.0, z: 0.0, w: 0.0),
        vector4(0.0))

suite "Copying a new Vector":
  proc testCopyVector(v1, v2: Vector) =
    var v3 = v1.copy()
    v3 += v2
    check:
      v1 != v3
      compareVectorToValue(v1, 0.0)
      compareVectorToValue(v3, 1.0)
  test "Copying a Vector1":
    testCopyVector(vector1(0.0), vector1(1.0))
  test "Copying a Vector2":
    testCopyVector(vector2(0.0), vector2(1.0))
  test "Copying a Vector3":
    testCopyVector(vector3(0.0), vector3(1.0))
  test "Copying a Vector4":
    testCopyVector(vector4(0.0), vector4(1.0))

suite "Setting a Vector to a single value":
  proc testSetVector(v1: Vector) =
    var
      v2 = v1.copy()
      v3 = v2.set(1.0)
    check:
      compareVectorToValue(v2, 1.0)
      v2 == v3
  test "Setting a Vector1":
    testSetVector(vector1(0.0))
  test "Setting a Vector2":
    testSetVector(vector2(0.0))
  test "Setting a Vector3":
    testSetVector(vector3(0.0))
  test "Setting a Vector4":
    testSetVector(vector4(0.0))

suite "Clearing a Vector":
  proc testClearVector(v1: Vector) =
    var 
      v2 = v1.copy()
      v3 = v2.clear()
    check:
      not compareVectorToValue(v2, 1.0)
      compareVectorToValue(v2, 0.0)
      v3 == v2
  test "Clearing a Vector1":
    testClearVector(vector1(1.0))
  test "Clearing a Vector2":
    testClearVector(vector2(1.0))
  test "Clearing a Vector3":
    testClearVector(vector3(1.0))
  test "Clearing a Vector4":
    testClearVector(vector4(1.0))

suite "Adding Vectors":
  proc testAddingVectors(v1, v2: Vector) =
    block:
      let
        v3 = addNew(v1, v2)
        v4 = v1 + v2
      check:
        compareVectorToValue(v3, 3.0)
        compareVectorToValue(v4, 3.0)
    block:
      var
        v3 = v1.copy()
      let
        v4 = addSelf(v3, v2)
      check:
        compareVectorToValue(v3, 3.0)
        compareVectorToValue(v4, 3.0)
        v3 == v4
    block:
      var
        v3 = v1.copy()
      v3 += v2
      check:
        not compareVectorToValue(v3, 1.0)
        compareVectorToValue(v3, 3.0)
  test "Adding Vector1s":
    testAddingVectors(vector1(1.0), vector1(2.0))
  test "Adding Vector2s":
    testAddingVectors(vector2(1.0), vector2(2.0))
  test "Adding Vector3s":
    testAddingVectors(vector3(1.0), vector3(2.0))
  test "Adding Vector4s":
    testAddingVectors(vector4(1.0), vector4(2.0))
  
suite "Adding a float to a Vector":
  proc testAddingVectorAndFloat(v1: Vector) =
    block:
      let
        v2 = addNew(v1, 2.0)
        v3 = v1 + 2.0
        v4 = 2.0 + v1
      check:
        compareVectorToValue(v2, 3.0)
        compareVectorToValue(v3, 3.0)
        compareVectorToValue(v4, 3.0)
    block:
      var
        v2 = v1.copy()
      let
        v3 = addSelf(v2, 2.0)
      check:
        compareVectorToValue(v2, 3.0)
        compareVectorToValue(v3, 3.0)
        v2 == v3
    block:
      var
        v2 = v1.copy()
      v2 += 2.0
      check:
        not compareVectorToValue(v2, 1.0)
        compareVectorToValue(v2, 3.0)
  test "Adding a float to a Vector1":
    testAddingVectorAndFloat(vector1(1.0))
  test "Adding a float to a Vector2":
    testAddingVectorAndFloat(vector2(1.0))
  test "Adding a float to a Vector3":
    testAddingVectorAndFloat(vector3(1.0))
  test "Adding a float to a Vector4":
    testAddingVectorAndFloat(vector4(1.0))

suite "Subtracting Vectors":
  proc testSubtactingVectors(v1, v2: Vector) =
    block:
      let
        v3 = subtractNew(v2, v1)
        v4 = v2 - v1
      check:
        compareVectorToValue(v3, 2.0)
        compareVectorToValue(v4, 2.0)
    block:
      var
        v3 = v2.copy()
      let
        v4 = subtractSelf(v3, v1)
      check:
        compareVectorToValue(v3, 2.0)
        compareVectorToValue(v4, 2.0)
        v3 == v4
    block:
      var
        v3 = v2.copy()
      v3 -= v1
      check:
        not compareVectorToValue(v3, 3.0)
        compareVectorToValue(v3, 2.0)
  test "Subtracting Vector1s":
    testSubtactingVectors(vector1(1.0), vector1(3.0))
  test "Subtracting Vector2s":
    testSubtactingVectors(vector2(1.0), vector2(3.0))
  test "Subtracting Vector3s":
    testSubtactingVectors(vector3(1.0), vector3(3.0))
  test "Subtracting Vector4s":
    testSubtactingVectors(vector4(1.0), vector4(3.0))
  
suite "Subtacting a float from a Vector":
  proc testSubtactingVectorAndFloat(v1: Vector) =
    block:
      let
        v2 = subtractNew(v1, 1.0)
        v3 = v1 - 1.0
        v4 = 5.0 - v1
      check:
        compareVectorToValue(v2, 2.0)
        compareVectorToValue(v3, 2.0)
        compareVectorToValue(v4, 2.0)
    block:
      var
        v2 = v1.copy()
      let
        v3 = subtractSelf(v2, 1.0)
      check:
        compareVectorToValue(v2, 2.0)
        compareVectorToValue(v3, 2.0)
        v2 == v3
    block:
      var
        v2 = v1.copy()
      v2 -= 1.0
      check:
        not compareVectorToValue(v2, 3.0)
        compareVectorToValue(v2, 2.0)
  test "Subtracting a float from a Vector1":
    testSubtactingVectorAndFloat(vector1(3.0))
  test "Subtracting a float from a Vector2":
    testSubtactingVectorAndFloat(vector2(3.0))
  test "Subtracting a float from a Vector3":
    testSubtactingVectorAndFloat(vector3(3.0))
  test "Subtracting a float from a Vector4":
    testSubtactingVectorAndFloat(vector4(3.0))

suite "Multiplying a Vector by a float":
  proc testMultiplyingVectorAndFloat(v1: Vector) =
    block:
      let
        v2 = multiplyNew(v1, 2.0)
        v3 = v1 * 2.0
        v4 = 2.0 * v1
      check:
        compareVectorToValue(v2, 6.0)
        compareVectorToValue(v3, 6.0)
        compareVectorToValue(v4, 6.0)
    block:
      var
        v2 = v1.copy()
      let
        v3 = multiplySelf(v2, 2.0)
      check:
        compareVectorToValue(v2, 6.0)
        compareVectorToValue(v3, 6.0)
        v2 == v3
    block:
      var
        v2 = v1.copy()
      v2 *= 2.0
      check:
        not compareVectorToValue(v2, 2.0)
        compareVectorToValue(v2, 6.0)
  test "Multiplying a Vector1 by a float":
    testMultiplyingVectorAndFloat(vector1(3.0))
  test "Multiplying a Vector2 by a float":
    testMultiplyingVectorAndFloat(vector2(3.0))
  test "Multiplying a Vector3 by a float":
    testMultiplyingVectorAndFloat(vector3(3.0))
  test "Multiplying a Vector4 by a float":
    testMultiplyingVectorAndFloat(vector4(3.0))

suite "Dividing a Vector by a float":
  proc testDividingVectorAndFloat(v1: Vector) =
    block:
      let
        v2 = divideNew(v1, 2.0)
        v3 = v1 / 2.0
        v4 = 2.0 / v1
      check:
        compareVectorToValue(v2, 3.0)
        compareVectorToValue(v3, 3.0)
        compareVectorToValue(v4, 1.0 / 3.0)
    block:
      var
        v2 = v1.copy()
      let
        v3 = divideSelf(v2, 2.0)
      check:
        compareVectorToValue(v2, 3.0)
        compareVectorToValue(v3, 3.0)
        v2 == v3
    block:
      var
        v2 = v1.copy()
      v2 /= 2.0
      check:
        not compareVectorToValue(v2, 6.0)
        compareVectorToValue(v2, 3.0)
  test "Dividing a Vector1 by a float":
    testDividingVectorAndFloat(vector1(6.0))
  test "Dividing a Vector2 by a float":
    testDividingVectorAndFloat(vector2(6.0))
  test "Dividing a Vector3 by a float":
    testDividingVectorAndFloat(vector3(6.0))
  test "Dividing a Vector4 by a float":
    testDividingVectorAndFloat(vector4(6.0))

suite "Calculating dot product of Vectors":
  proc testDotProduct(v1, v2: Vector, expected: float) =
    check:
      dot(v1, v2) == expected
  test "Calculating dot product of Vector1s":
    testDotProduct(
      vector1(1.0),
      vector1(2.0),
      1.0 * 2.0)
    testDotProduct(
      vector1(2.0),
      vector1(3.0),
      2.0 * 3.0)
  test "Calculating dot product of Vector2s":
    testDotProduct(
      vector2(1.0),
      vector2(2.0),
      1.0 * 2.0 * 2.0)
    testDotProduct(
      vector2(2.0),
      vector2(3.0),
      2.0 * 3.0 * 2.0)
  test "Calculating dot product of Vector3s":
    testDotProduct(
      vector3(1.0),
      vector3(2.0),
      1.0 * 2.0 * 3.0)
    testDotProduct(
      vector3(2.0),
      vector3(3.0),
      2.0 * 3.0 * 3.0)
  test "Calculating dot product of Vector4s":
    testDotProduct(
      vector4(1.0),
      vector4(2.0),
      1.0 * 2.0 * 4.0)
    testDotProduct(
      vector4(2.0),
      vector4(3.0),
      2.0 * 3.0 * 4.0)

suite "Calculating cross product of Vectors":
  proc testCrossProductFloat(v1, v2: Vector, expected: float) =
    check:
      cross(v1, v2) == expected
  proc testCrossProductVector(v1, v2, expected: Vector) =
    check:
      cross(v1, v2) == expected
  test "Calculating cross product of Vector1s (float)":
    testCrossProductFloat(
      vector1(1.0),
      vector1(2.0),
      1.0 * 2.0)
    testCrossProductFloat(
      vector1(2.0),
      vector1(3.0),
      2.0 * 3.0)
  test "Calculating cross product of Vector2s (float)":
    testCrossProductFloat(
      Vector2(x: 3.0, y: 1.0),
      Vector2(x: 4.0, y: 2.0),
      3.0 * 4.0 - 1.0 * 2.0)
    testCrossProductFloat(
      Vector2(x: 2.0, y: 4.0),
      Vector2(x: 3.0, y: 1.0),
      2.0 * 3.0 - 4.0 * 1.0)
  test "Calculating cross product of Vector3s (Vector)":
    testCrossProductVector(
      Vector3(x: 3.0, y: 1.0, z: 2.0),
      Vector3(x: 4.0, y: 2.0, z: 3.0),
      Vector3(
        x: 1.0 * 3.0 - 2.0 * 2.0,
        y: 2.0 * 4.0 - 3.0 * 3.0,
        z: 3.0 * 2.0 - 1.0 * 4.0
      ))
    testCrossProductVector(
      Vector3(x: 2.0, y: 4.0, z: 1.0),
      Vector3(x: 3.0, y: 1.0, z: 0.0),
      Vector3(
        x: 4.0 * 0.0 - 1.0 * 1.0,
        y: 1.0 * 3.0 - 2.0 * 0.0,
        z: 2.0 * 1.0 - 4.0 * 3.0
      ))
  # No Vector4 cross product

suite "Calculating the inverse of a Vector":
  proc testInverseVector(v1: Vector, expected: float) =
    block:
      let
        v2 = inverseNew(v1)
        v3 = inverse(v1)
        v4 = reverse(v1)
      check:
        compareVectorToValue(v1, -1.0 * expected)
        compareVectorToValue(v2, expected)
        compareVectorToValue(v3, expected)
        compareVectorToValue(v4, expected)
    block:
      var
        v2 = v1.copy()
      let
        v3 = inverseSelf(v2)
      check:
        compareVectorToValue(v2, expected)
        compareVectorToValue(v3, expected)
        v2 == v3
  test "Calculating the inverse of a Vector1":
    testInverseVector(vector1(2.0), -1.0 * 2.0)
  test "Calculating the inverse of a Vector2":
    testInverseVector(vector2(2.0), -1.0 * 2.0)
  test "Calculating the inverse of a Vector3":
    testInverseVector(vector3(2.0), -1.0 * 2.0)
  test "Calculating the inverse of a Vector4":
    testInverseVector(vector4(2.0), -1.0 * 2.0)

suite "Calculating an inverted Vector":
  proc testInverseVector(v1: Vector, expected: float) =
    block:
      let
        v2 = invertNew(v1)
        v3 = invert(v1)
      check:
        compareVectorToValue(v1, 1.0 / expected)
        compareVectorToValue(v2, expected)
        compareVectorToValue(v3, expected)
    block:
      var
        v2 = v1.copy()
      let
        v3 = invertSelf(v2)
      check:
        compareVectorToValue(v2, expected)
        compareVectorToValue(v3, expected)
        v2 == v3
  test "Calculating an inverted Vector1":
    testInverseVector(vector1(2.0), 1.0 / 2.0)
  test "Calculating an inverted Vector2":
    testInverseVector(vector2(2.0), 1.0 / 2.0)
  test "Calculating an inverted Vector3":
    testInverseVector(vector3(2.0), 1.0 / 2.0)
  test "Calculating an inverted Vector4":
    testInverseVector(vector4(2.0), 1.0 / 2.0)

suite "Calculating the heading of a Vector":
  const
    PI_OVER_FOUR_RADS = 45.0 * PI / 180
    PI_OVER_SIX_RADS = 30.0 * PI / 180
    PI_OVER_THREE_RADS = 60.0 * PI / 180
  test "Calculating the heading of a Vector1":
    check:
      heading(vector1(2.0)) == 0.0
  test "Calculating the heading of a Vector2":
    let
      v1 = vector2(2.0)
      v2 = Vector2(x: pow(3.0, 0.5) / 2.0, y: 0.5)
    check:
      heading(v1) == PI_OVER_FOUR_RADS
      headingXY(v1) == PI_OVER_FOUR_RADS
      heading(v1) == headingXY(v1)
      abs(heading(v2) - PI_OVER_SIX_RADS) < ETA
      abs(headingXY(v2) - PI_OVER_SIX_RADS) < ETA
      abs(heading(v2) - headingXY(v2)) < ETA
  test "Calculating the heading of a Vector3":
    let
      v1 = vector3(2.0)
      v2 = Vector3(
        x: pow(3.0, 0.5) / 2.0,
        y: 0.5,
        z: 0.5)
    check:
      heading(v1) == PI_OVER_FOUR_RADS
      headingXY(v1) == PI_OVER_FOUR_RADS
      heading(v1) == headingXY(v1)
      headingXZ(v1) == PI_OVER_FOUR_RADS
      headingYZ(v1) == PI_OVER_FOUR_RADS
      abs(heading(v2) - PI_OVER_SIX_RADS) < ETA
      abs(headingXY(v2) - PI_OVER_SIX_RADS) < ETA
      abs(heading(v2) - headingXY(v2)) < ETA
      abs(headingXZ(v2) - PI_OVER_SIX_RADS) < ETA
      headingYZ(v2) == PI_OVER_FOUR_RADS
  test "Calculating the heading of a Vector4":
    let
      v1 = vector4(2.0)
      v2 = Vector4(
        x: pow(3.0, 0.5) / 2.0,
        y: 0.5,
        z: 0.5,
        w: pow(3.0, 0.5) / 2.0)
    check:
      heading(v1) == PI_OVER_FOUR_RADS
      headingXY(v1) == PI_OVER_FOUR_RADS
      heading(v1) == headingXY(v1)
      headingXZ(v1) == PI_OVER_FOUR_RADS
      headingXW(v1) == PI_OVER_FOUR_RADS
      headingYZ(v1) == PI_OVER_FOUR_RADS
      headingYW(v1) == PI_OVER_FOUR_RADS
      headingZW(v1) == PI_OVER_FOUR_RADS
      abs(heading(v2) - PI_OVER_SIX_RADS) < ETA
      abs(headingXY(v2) - PI_OVER_SIX_RADS) < ETA
      abs(heading(v2) - headingXY(v2)) < ETA
      abs(headingXZ(v2) - PI_OVER_SIX_RADS) < ETA
      headingXW(v2) == PI_OVER_FOUR_RADS
      headingYZ(v2) == PI_OVER_FOUR_RADS
      abs(headingYW(v2) - PI_OVER_THREE_RADS) < ETA
      abs(headingZW(v2) - PI_OVER_THREE_RADS) < ETA

suite "Calculating the magnitude and length of a Vector":
  proc testVectorMagnitudeAndLength(v1: Vector, expected: float) =
    let
      m = magnitude(v1)
      l = length(v1)
    check:
      m == expected
      l == expected
      m == l
  test "Calculating the magnitude and length of a Vector1":
    testVectorMagnitudeAndLength(vector1(2.0), 2.0)
  test "Calculating the magnitude and length of a Vector2":
    testVectorMagnitudeAndLength(vector2(2.0), 2.0 * sqrt(2.0))
  test "Calculating the magnitude and length of a Vector3":
    testVectorMagnitudeAndLength(vector3(2.0), 2.0 * sqrt(3.0))
  test "Calculating the magnitude and length of a Vector4":
    testVectorMagnitudeAndLength(vector4(2.0), 4.0)

suite "Normalizing a Vector":
  proc testNormalizeVector(v1, expected: Vector, value: float = 1.0) =
    block:
      var
        v2 = v1.copy()
        v4 = v1.copy()
      let
        v3 = normalizeSelf(v2, value)
        v5 = normalize(v4, value)
      check:
        v3 == expected
        v5 == expected
        v3 == v5
    block:
      let
        v2 = normalizeNew(v1, value)
      check:
        v2 == expected
  test "Normalizing a Vector1":
    testNormalizeVector(vector1(2.0), vector1(1.0))
    testNormalizeVector(vector1(2.0), vector1(2.0), 2.0)
  test "Normalizing a Vector2":
    testNormalizeVector(vector2(2.0), vector2(1.0 / sqrt(2.0)))
    testNormalizeVector(vector2(2.0), vector2(2.0), 2.0 * sqrt(2.0))
  test "Normalizing a Vector3":
    testNormalizeVector(vector3(2.0), vector3(1.0 / sqrt(3.0)))
    testNormalizeVector(vector3(2.0), vector3(2.0), 2.0 * sqrt(3.0))
  test "Normalizing a Vector4":
    testNormalizeVector(vector4(2.0), vector4(1.0 / 2.0))
    testNormalizeVector(vector4(2.0), vector4(2.0), 4.0)

suite "Calculating the reflection of a Vector":
  proc testReflectVector(v, n, expected: Vector) =
    block:
      let
        v1 = reflectNew(v, n)
        v2 = reflect(v, n)
      check:
        compareVectorsWithinEta(v1, expected)
        compareVectorsWithinEta(v2, expected)
        v1 == v2
    block:
      var
        v1 = v.copy()
      let
        v2 = reflectSelf(v1, n)
      check:
        compareVectorsWithinEta(v1, expected)
        v1 == v2
  test "Calculating the reflection of a Vector1":
    testReflectVector(
      normalizeNew(vector1(2.0)),
      normalizeNew(vector1(-1.0)),
      normalizeNew(vector1(-1.0 * 2.0)))
  test "Calculating the reflection of a Vector2":
    testReflectVector(
      normalizeNew(vector2(2.0, 2.0)),
      normalizeNew(vector2(-1.0, -1.0)),
      normalizeNew(vector2(-1.0 * 2.0, -1.0 * 2.0)))
  test "Calculating the reflection of a Vector3":
    testReflectVector(
      normalizeNew(vector2(2.0, 2.0)),
      normalizeNew(vector2(-1.0, -1.0)),
      normalizeNew(vector2(-1.0 * 2.0, -1.0 * 2.0)))
  test "Calculating the reflection of a Vector4":
    testReflectVector(
      normalizeNew(vector4(2.0, 2.0, 2.0, 2.0)),
      normalizeNew(vector4(-1.0, 
                           -1.0, 
                           -1.0, 
                           -1.0)),
      normalizeNew(vector4(-1.0 * 2.0, 
              -1.0 * 2.0,
              -1.0 * 2.0,
              -1.0 * 2.0)))

# NOTE: More tests need to be added
suite "Calculating the refraction of a Vector":
  proc testRefractVector(v, n: Vector, eta: float, expected: Vector) =
    block:
      let
        v1 = refractNew(v, n, eta)
        v2 = refract(v, n, eta)
      if not compareVectorsWithinEta(v1, expected):
        checkpoint("eta is " & $eta)
      check:
        compareVectorsWithinEta(v1, expected)
        compareVectorsWithinEta(v2, expected)
        v1 == v2
    block:
      var
        v1 = v.copy()
      let
        v2 = refractSelf(v1, n, eta)
      check:
        compareVectorsWithinEta(v1, expected)
        v1 == v2
  test "Calculating the refraction of a Vector1":
    let
      v1 = normalizeNew(vector1(2.0))
      v2 = normalizeNew(vector1(-1.0))
    testRefractVector(v1, v2, 1.0, v1)
  test "Calculating the refraction of a Vector2":
    let
      v1 = normalizeNew(vector2(2.0, 2.0))
      v2 = normalizeNew(vector2(-1.0, 
                                -1.0))
    testRefractVector(v1, v2, 1.0, v1)
  test "Calculating the refraction of a Vector3":
    let
      v1 = normalizeNew(vector3(2.0, 2.0, 2.0))
      v2 = normalizeNew(vector3(-1.0, 
                                -1.0, 
                                -1.0))
    testRefractVector(v1, v2, 1.0, v1)
  test "Calculating the refraction of a Vector4":
    let
      v1 = normalizeNew(vector4(2.0, 2.0, 2.0, 2.0))
      v2 = normalizeNew(vector4(-1.0, 
                                -1.0, 
                                -1.0, 
                                -1.0))
    testRefractVector(v1, v2, 1.0, v1)

suite "Calculating the angle between Vectors":
  proc testAngleBetweenVectors(v1, v2: Vector, expected: float) =
    let
      a = angleBetween(v1, v2)
    check:
      compareValuesWithinEta(a, expected)
  test "Calculating the angle between Vector1s":
    testAngleBetweenVectors(vector1(2.0), vector1(2.0), 0.0)
  test "Calculating the angle between Vector2s":
    testAngleBetweenVectors(vector2(2.0), vector2(2.0), 0.0)
    testAngleBetweenVectors(vector2(2.0,
                                    0.0),
                            vector2(0.0, 2.0), PI / 2.0)
  test "Calculating the angle between Vector3s":
    testAngleBetweenVectors(vector3(2.0), vector3(2.0), 0.0)
    testAngleBetweenVectors(vector3(2.0,
                                    0.0,
                                    0.0), 
                            vector3(0.0, 2.0, 0.0), PI / 2.0)
  test "Calculating the angle between Vector4s":
    testAngleBetweenVectors(vector4(2.0), vector4(2.0), 0.0)
    testAngleBetweenVectors(vector4(2.0,
                                    0.0,
                                    0.0,
                                    0.0),
                            vector4(0.0, 2.0, 0.0, 0.0), PI / 2.0)

suite "Getting Vector dimension":
  proc testVectorDimension(v1: Vector, expected: int) =
    check:
      dimension(v1) == expected
  test "Getting Vector1 dimension":
    testVectorDimension(vector1(1.0), 1)
  test "Getting Vector2 dimension":
    testVectorDimension(vector2(1.0), 2)
  test "Getting Vector3 dimension":
    testVectorDimension(vector3(1.0), 3)
  test "Getting Vector4 dimension":
    testVectorDimension(vector4(1.0), 4)

suite "Hashing Vector":
  proc testHashVector(v1, v2: Vector) =
    let
      v3 = v1.copy()
    check:
      hash(v1) != hash(v2)
      hash(v1) == hash(v3)
  test "Hashing Vector1":
    testHashVector(vector1(1.0), vector1(2.0))
  test "Hashing Vector2":
    testHashVector(vector2(1.0), vector2(2.0))
  test "Hashing Vector3":
    testHashVector(vector3(1.0), vector3(2.0))
  test "Hashing Vector4":
    testHashVector(vector4(1.0), vector4(2.0))

suite "Getting array from Vector":
  proc testVectorToArray(v1: Vector) =
    let
      a = v1.toArray()
    check:
      compareVectorToValues(v1, @(a))
  test "Getting array from Vector1":
    testVectorToArray(vector1(1.0))
  test "Getting array from Vector2":
    testVectorToArray(vector2(1.0))
  test "Getting array from Vector3":
    testVectorToArray(vector3(1.0))
  test "Getting array from Vector4":
    testVectorToArray(vector4(1.0))

suite "Iterating over a Vector":
  proc testVectorIterate(v1: Vector) =
    let
      a = v1.toArray()
    var
      i = 0
    for e in elements(v1):
      check:
        a[i] == e
      i += 1
    for j, e in pairs(v1):
      check:
        a[j] == e
  test "Iterating over a Vector1":
    testVectorIterate(vector1(1.0))
  test "Iterating over a Vector2":
    testVectorIterate(vector2(1.0, 2.0))
  test "Iterating over a Vector3":
    testVectorIterate(vector3(1.0, 2.0, 3.0))
  test "Iterating over a Vector4":
    testVectorIterate(vector4(1.0, 2.0, 3.0, 4.0))

suite "Getting string from Vector":
  proc testVectorToString(v1: Vector, expected: string) =
    let
      s = $v1
    check:
      s == expected
  test "Getting string from Vector1":
    testVectorToString(vector1(1.0), "[1.0]")
  test "Getting string from Vector2":
    testVectorToString(vector2(1.0, 2.0), "[1.0, 2.0]")
  test "Getting string from Vector3":
    testVectorToString(vector3(1.0, 2.0, 3.0), "[1.0, 2.0, 3.0]")
  test "Getting string from Vector4":
    testVectorToString(vector4(1.0, 2.0, 3.0, 4.0), "[1.0, 2.0, 3.0, 4.0]")