import ../../src/core/vector
import unittest

from system import `@`, abs
from math import pow, sqrt, PI
from sequtils import zip, toSeq

from ../../src/core/constants import
  EPSILON

# Vector testing utilities
proc compareVectorToValue[N: static[int], T](vector: Vector[N, T], value: T): bool =
  let a = vector.toArray()
  result = true
  for v in a:
    if v != value:
      result = false
  if not result:
    checkpoint("vector was " & $vector)
    checkpoint("value was " & $value)

proc compareVectorToValues[N: static[int], T](vector: Vector[N, T], values: seq[T]): bool =
  let a = vector.toArray()
  result = true
  for i, v in a:
    if v != values[i]:
      result = false
  if not result:
    checkpoint("vector was " & $vector)
    checkpoint("values were " & $values)

proc compareValuesWithinEpsilon[T](a, b: T): bool =
  if abs(a - b) >= EPSILON:
    result = false
    checkpoint("a was " & $a)
    checkpoint("b was " & $b)
  else:
    result = true

proc compareVectorsWithinEpsilon[N: static[int], T](v1, v2: Vector[N, T]): bool =
  let s = zip(v1.toArray(), v2.toArray())
  result = true
  for v in s:
    if abs(v[0] - v[1]) >= EPSILON:
      result = false
  if not result:
    checkpoint("v1 was " & $v1)
    checkpoint("v2 was " & $v2)

suite "Testing Vector equality and inequality":
  proc testVectorEquality[N: static[int], T](v1, v2, v3: Vector[N, T]) =
    check:
      v1 == v2
      v1 != v3
  test "Testing Vector1 equality and inequality":
    testVectorEquality(
      [0.0],
      [0.0],
      [1.0])
  test "Testing Vector2 equality and inequality":
    testVectorEquality(
      [0.0, 1.0],
      [0.0, 1.0],
      [1.0, 2.0])
  test "Testing Vector3 equality and inequality":
    testVectorEquality(
      [0.0, 1.0, 2.0],
      [0.0, 1.0, 2.0],
      [1.0, 2.0, 3.0])
  test "Testing Vector4 equality and inequality":
    testVectorEquality(
      [0.0, 1.0, 2.0, 3.0],
      [0.0, 1.0, 2.0, 3.0],
      [1.0, 2.0, 3.0, 0.0])

suite "Comparing Vectors":
  proc testCompareVectors[N: static[int], T](small, big: Vector[N, T]) =
    var otherSmall: Vector[N, T]
    deepCopy(otherSmall, small)
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
    testCompareVectors([1.0], [2.0])
  test "Comparing Vector2s":
    testCompareVectors([1.0, 1.0], [2.0, 2.0])
  test "Comparing Vector3s":
    testCompareVectors([1.0, 1.0, 1.0], [2.0, 2.0, 2.0])
  test "Comparing Vector4s":
    testCompareVectors([1.0, 1.0, 1.0, 1.0], [2.0, 2.0, 2.0, 2.0])

suite "Creating a new Vector with default constructor":
  proc testCreateVectorDefaultConstructor[N: static[int], T](v1, v2: Vector[N, T]) =
    check:
      v1 == v2
  test "Creating a Vector1 with the default constructor":
    testCreateVectorDefaultConstructor(
      [0.0],
      vector1(0.0))
  test "Creating a Vector2 with the default constructor":
    testCreateVectorDefaultConstructor(
      [0.0, 1.0],
      vector2(0.0, 1.0))
  test "Creating a Vector3 with the default constructor":
    testCreateVectorDefaultConstructor(
      [0.0, 1.0, 2.0],
      vector3(0.0, 1.0, 2.0))
  test "Creating a Vector4 with the default constructor":
    testCreateVectorDefaultConstructor(
      [0.0, 1.0, 2.0, 3.0],
      vector4(0.0, 1.0, 2.0, 3.0))

suite "Creating a new Vector with single value constructor":
  proc testCreateVectorSingleValueConstructor[N: static[int], T](v1, v2: Vector[N, T]) =
    check:
      v1 == v2
  test "Creating a Vector2 with single value constructor":
    testCreateVectorSingleValueConstructor(
        [0.0, 0.0],
        vector(2, 0.0))
  test "Creating a Vector3 with single value constructor":
    testCreateVectorSingleValueConstructor(
        [0.0, 0.0, 0.0],
        vector(3, 0.0))
  test "Creating a Vector4 with single value constructor":
    testCreateVectorSingleValueConstructor(
        [0.0, 0.0, 0.0, 0.0],
        vector(4, 0.0))

# suite "Testing Vector swizzles":
#   test "Testing Vector1 swizzles":
#     let v = vector1(1.0)
#     check:
#       v.xx == vector2(1.0, 1.0)
#       v.xxx == vector3(1.0, 1.0, 1.0)
#       v.xxxx == vector4(1.0, 1.0, 1.0, 1.0)
#   test "Testing Vector2 swizzles":
#     let v = vector2(1.0, 2.0)
#     check:
#       v.xx == vector2(1.0, 1.0)
#       v.xxx == vector3(1.0, 1.0, 1.0)
#       v.xxxx == vector4(1.0, 1.0, 1.0, 1.0)
#       v.xy == vector2(1.0, 2.0)
#       v.yy == vector2(2.0, 2.0)
#       v.xyy == vector3(1.0, 2.0, 2.0)
#       v.xyxy == vector4(1.0, 2.0, 1.0, 2.0)
#   test "Testing Vector3 swizzles":
#     let v = vector3(1.0, 2.0, 3.0)
#     check:
#       v.xx == vector2(1.0, 1.0)
#       v.xxx == vector3(1.0, 1.0, 1.0)
#       v.xxxx == vector4(1.0, 1.0, 1.0, 1.0)
#       v.xy == vector2(1.0, 2.0)
#       v.yy == vector2(2.0, 2.0)
#       v.xyy == vector3(1.0, 2.0, 2.0)
#       v.xyxy == vector4(1.0, 2.0, 1.0, 2.0)
#       v.zz == vector2(3.0, 3.0)
#       v.xzz == vector3(1.0, 3.0, 3.0)
#       v.xzyz == vector4(1.0, 3.0, 2.0, 3.0)
#   test "Testing Vector4 swizzles":
#     let v = vector4(1.0, 2.0, 3.0, 4.0)
#     check:
#       v.xx == vector2(1.0, 1.0)
#       v.xxx == vector3(1.0, 1.0, 1.0)
#       v.xxxx == vector4(1.0, 1.0, 1.0, 1.0)
#       v.xy == vector2(1.0, 2.0)
#       v.yy == vector2(2.0, 2.0)
#       v.xyy == vector3(1.0, 2.0, 2.0)
#       v.xyxy == vector4(1.0, 2.0, 1.0, 2.0)
#       v.zz == vector2(3.0, 3.0)
#       v.xzz == vector3(1.0, 3.0, 3.0)
#       v.xzyz == vector4(1.0, 3.0, 2.0, 3.0)
#       v.ww == vector2(4.0, 4.0)
#       v.wzz == vector3(4.0, 3.0, 3.0)
#       v.wzxy == vector4(4.0, 3.0, 1.0, 2.0)

suite "Copying a new Vector":
  proc testCopyVector[N: static[int], T](v1, v2: Vector[N, T]) =
    var v3: Vector[N, T]
    deepCopy(v3, v1)
    v3 += v2
    check:
      v1 != v3
      compareVectorToValue(v1, 0.0)
      compareVectorToValue(v3, 1.0)
  test "Copying a Vector1":
    testCopyVector(vector(1, 0.0), vector(1, 1.0))
  test "Copying a Vector2":
    testCopyVector(vector(2, 0.0), vector(2, 1.0))
  test "Copying a Vector3":
    testCopyVector(vector(3, 0.0), vector(3, 1.0))
  test "Copying a Vector4":
    testCopyVector(vector(4, 0.0), vector(4, 1.0))

suite "Setting a Vector to a single value":
  proc testSetVector[N: static[int], T](v1: Vector[N, T]) =
    var v2: Vector[N, T]
    discard v2.set(1.0)
    check:
      compareVectorToValue(v2, 1.0)
  test "Setting a Vector1":
    testSetVector(vector(1, 0.0))
  test "Setting a Vector2":
    testSetVector(vector(2, 0.0))
  test "Setting a Vector3":
    testSetVector(vector(3, 0.0))
  test "Setting a Vector4":
    testSetVector(vector(4, 0.0))

suite "Setting a Vector to multiple values":
  # Setting a Vector1 same as single value
  test "Setting a Vector2":
    var
      v = vector(2, 0.0)
    v = v.set(1.0, 2.0)
    check:
      v == vector2(1.0, 2.0)
  test "Setting a Vector3":
    var
      v = vector(3, 0.0)
    v = v.set(1.0, 2.0, 3.0)
    check:
      v == vector3(1.0, 2.0, 3.0)
  test "Setting a Vector4":
    var
      v = vector(4, 0.0)
    v = v.set(1.0, 2.0, 3.0, 4.0)
    check:
      v == vector4(1.0, 2.0, 3.0, 4.0)

suite "Clearing a Vector":
  proc testClearVector[N: static[int], T](v1: Vector[N, T]) =
    var v2: Vector[N, T]
    discard clear(v2)
    check:
      not compareVectorToValue(v2, 1.0)
      compareVectorToValue(v2, 0.0)
  test "Clearing a Vector1":
    testClearVector(vector(1, 1.0))
  test "Clearing a Vector2":
    testClearVector(vector(2, 1.0))
  test "Clearing a Vector3":
    testClearVector(vector(3, 1.0))
  test "Clearing a Vector4":
    testClearVector(vector(4, 1.0))

suite "Adding Vectors":
  proc testAddingVectors[N: static[int], T](v1, v2: Vector[N, T]) =
    block:
      let
        v3 = addNew(v1, v2)
        v4 = v1 + v2
      check:
        compareVectorToValue(v3, 3.0)
        compareVectorToValue(v4, 3.0)
    block:
      var v3: Vector[N, T]
      deepCopy(v3, v1)
      let
        v4 = addSelf(v3, v2)
      check:
        compareVectorToValue(v3, 3.0)
        compareVectorToValue(v4, 3.0)
        v3 == v4
    block:
      var v3: Vector[N, T]
      deepCopy(v3, v1)
      v3 += v2
      check:
        not compareVectorToValue(v3, 1.0)
        compareVectorToValue(v3, 3.0)
  test "Adding Vector1s":
    testAddingVectors(vector(1, 1.0), vector(1, 2.0))
  test "Adding Vector2s":
    testAddingVectors(vector(2, 1.0), vector(2, 2.0))
  test "Adding Vector3s":
    testAddingVectors(vector(3, 1.0), vector(3, 2.0))
  test "Adding Vector4s":
    testAddingVectors(vector(4, 1.0), vector(4, 2.0))

suite "Adding a float to a Vector":
  proc testAddingVectorAndFloat[N: static[int], T](v1: Vector[N, T]) =
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
      var v2: Vector[N, T]
      deepCopy(v2, v1)
      let
        v3 = addSelf(v2, 2.0)
      check:
        compareVectorToValue(v2, 3.0)
        compareVectorToValue(v3, 3.0)
        v2 == v3
    block:
      var v2: Vector[N, T]
      deepCopy(v2, v1)
      v2 += 2.0
      check:
        not compareVectorToValue(v2, 1.0)
        compareVectorToValue(v2, 3.0)
  test "Adding a float to a Vector1":
    testAddingVectorAndFloat(vector(1, 1.0))
  test "Adding a float to a Vector2":
    testAddingVectorAndFloat(vector(2, 1.0))
  test "Adding a float to a Vector3":
    testAddingVectorAndFloat(vector(3, 1.0))
  test "Adding a float to a Vector4":
    testAddingVectorAndFloat(vector(4, 1.0))

suite "Subtracting Vectors":
  proc testSubtactingVectors[N: static[int], T](v1, v2: Vector[N, T]) =
    block:
      let
        v3 = subtractNew(v2, v1)
        v4 = v2 - v1
      check:
        compareVectorToValue(v3, 2.0)
        compareVectorToValue(v4, 2.0)
    block:
      var v3: Vector[N, T]
      deepCopy(v3, v2)
      let
        v4 = subtractSelf(v3, v1)
      check:
        compareVectorToValue(v3, 2.0)
        compareVectorToValue(v4, 2.0)
        v3 == v4
    block:
      var v3: Vector[N, T]
      deepCopy(v3, v2)
      v3 -= v1
      check:
        not compareVectorToValue(v3, 3.0)
        compareVectorToValue(v3, 2.0)
  test "Subtracting Vector1s":
    testSubtactingVectors(vector(1, 1.0), vector(1, 3.0))
  test "Subtracting Vector2s":
    testSubtactingVectors(vector(2, 1.0), vector(2, 3.0))
  test "Subtracting Vector3s":
    testSubtactingVectors(vector(3, 1.0), vector(3, 3.0))
  test "Subtracting Vector4s":
    testSubtactingVectors(vector(4, 1.0), vector(4, 3.0))

suite "Subtacting a float from a Vector":
  proc testSubtactingVectorAndFloat[N: static[int], T](v1: Vector[N, T]) =
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
      var v2: Vector[N, T]
      deepCopy(v2, v1)
      let
        v3 = subtractSelf(v2, 1.0)
      check:
        compareVectorToValue(v2, 2.0)
        compareVectorToValue(v3, 2.0)
        v2 == v3
    block:
      var v2: Vector[N, T]
      deepCopy(v2, v1)
      v2 -= 1.0
      check:
        not compareVectorToValue(v2, 3.0)
        compareVectorToValue(v2, 2.0)
  test "Subtracting a float from a Vector1":
    testSubtactingVectorAndFloat(vector(1, 3.0))
  test "Subtracting a float from a Vector2":
    testSubtactingVectorAndFloat(vector(2, 3.0))
  test "Subtracting a float from a Vector3":
    testSubtactingVectorAndFloat(vector(3, 3.0))
  test "Subtracting a float from a Vector4":
    testSubtactingVectorAndFloat(vector(4, 3.0))

suite "Multiplying a Vector by a float":
  proc testMultiplyingVectorAndFloat[N: static[int], T](v1: Vector[N, T]) =
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
      var v2: Vector[N, T]
      deepCopy(v2, v1)
      let
        v3 = multiplySelf(v2, 2.0)
      check:
        compareVectorToValue(v2, 6.0)
        compareVectorToValue(v3, 6.0)
        v2 == v3
    block:
      var v2: Vector[N, T]
      deepCopy(v2, v1)
      v2 *= 2.0
      check:
        not compareVectorToValue(v2, 2.0)
        compareVectorToValue(v2, 6.0)
  test "Multiplying a Vector1 by a float":
    testMultiplyingVectorAndFloat(vector(1, 3.0))
  test "Multiplying a Vector2 by a float":
    testMultiplyingVectorAndFloat(vector(2, 3.0))
  test "Multiplying a Vector3 by a float":
    testMultiplyingVectorAndFloat(vector(3, 3.0))
  test "Multiplying a Vector4 by a float":
    testMultiplyingVectorAndFloat(vector(4, 3.0))

suite "Dividing a Vector by a float":
  proc testDividingVectorAndFloat[N: static[int], T](v1: Vector[N, T]) =
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
      var v2: Vector[N, T]
      deepCopy(v2, v1)
      let
        v3 = divideSelf(v2, 2.0)
      check:
        compareVectorToValue(v2, 3.0)
        compareVectorToValue(v3, 3.0)
        v2 == v3
    block:
      var v2: Vector[N, T]
      deepCopy(v2, v1)
      v2 /= 2.0
      check:
        not compareVectorToValue(v2, 6.0)
        compareVectorToValue(v2, 3.0)
  test "Dividing a Vector1 by a float":
    testDividingVectorAndFloat(vector(1, 6.0))
  test "Dividing a Vector2 by a float":
    testDividingVectorAndFloat(vector(2, 6.0))
  test "Dividing a Vector3 by a float":
    testDividingVectorAndFloat(vector(3, 6.0))
  test "Dividing a Vector4 by a float":
    testDividingVectorAndFloat(vector(4, 6.0))

suite "Calculating dot product of Vectors":
  proc testDotProduct[N: static[int], T](v1, v2: Vector[N, T], expected: float) =
    check:
      dot(v1, v2) == expected
  test "Calculating dot product of Vector1s":
    testDotProduct(
      vector(1, 1.0),
      vector(1, 2.0),
      1.0 * 2.0)
    testDotProduct(
      vector(1, 2.0),
      vector(1, 3.0),
      2.0 * 3.0)
  test "Calculating dot product of Vector2s":
    testDotProduct(
      vector(2, 1.0),
      vector(2, 2.0),
      1.0 * 2.0 * 2.0)
    testDotProduct(
      vector(2, 2.0),
      vector(2, 3.0),
      2.0 * 3.0 * 2.0)
  test "Calculating dot product of Vector3s":
    testDotProduct(
      vector(3, 1.0),
      vector(3, 2.0),
      1.0 * 2.0 * 3.0)
    testDotProduct(
      vector(3, 2.0),
      vector(3, 3.0),
      2.0 * 3.0 * 3.0)
  test "Calculating dot product of Vector4s":
    testDotProduct(
      vector(4, 1.0),
      vector(4, 2.0),
      1.0 * 2.0 * 4.0)
    testDotProduct(
      vector(4, 2.0),
      vector(4, 3.0),
      2.0 * 3.0 * 4.0)

suite "Calculating cross product of Vectors":
  proc testCrossProductFloat[N: static[int], T](v1, v2: Vector[N, T], expected: float) =
    check:
      cross(v1, v2) == expected
  proc testCrossProductVector[N: static[int], T](v1, v2, expected: Vector[N, T]) =
    check:
      cross(v1, v2) == expected
  test "Calculating cross product of Vector1s (float)":
    testCrossProductFloat(
      vector(1, 1.0),
      vector(1, 2.0),
      1.0 * 2.0)
    testCrossProductFloat(
      vector(1, 2.0),
      vector(1, 3.0),
      2.0 * 3.0)
  test "Calculating cross product of Vector2s (float)":
    testCrossProductFloat(
      [3.0, 1.0],
      [4.0, 2.0],
      3.0 * 2.0 - 1.0 * 4.0)
    testCrossProductFloat(
      [2.0, 4.0],
      [3.0, 1.0],
      2.0 * 1.0 - 4.0 * 3.0)
  test "Calculating cross product of Vector3s (Vector)":
    testCrossProductVector(
      [3.0, 1.0, 2.0],
      [4.0, 2.0, 3.0],
      [
        1.0 * 3.0 - 2.0 * 2.0,
        2.0 * 4.0 - 3.0 * 3.0,
        3.0 * 2.0 - 1.0 * 4.0
      ])
    testCrossProductVector(
      [2.0, 4.0, 1.0],
      [3.0, 1.0, 0.0],
      [
        4.0 * 0.0 - 1.0 * 1.0,
        1.0 * 3.0 - 2.0 * 0.0,
        2.0 * 1.0 - 4.0 * 3.0
      ])
  test "Calculating cross product of Vector4s (Error)":
    expect InvalidCrossProductError:
      cross([1.0, 1.0, 1.0, 1.0],
            [1.0, 1.0, 1.0, 1.0])

suite "Calculating the inverse of a Vector":
  proc testInverseVector[N: static[int], T](v1: Vector[N, T], expected: float) =
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
      var v2: Vector[N, T]
      deepCopy(v2, v1)
      let
        v3 = inverseSelf(v2)
      check:
        compareVectorToValue(v2, expected)
        compareVectorToValue(v3, expected)
        v2 == v3
  test "Calculating the inverse of a Vector1":
    testInverseVector(vector(1, 2.0), -1.0 * 2.0)
  test "Calculating the inverse of a Vector2":
    testInverseVector(vector(2, 2.0), -1.0 * 2.0)
  test "Calculating the inverse of a Vector3":
    testInverseVector(vector(3, 2.0), -1.0 * 2.0)
  test "Calculating the inverse of a Vector4":
    testInverseVector(vector(4, 2.0), -1.0 * 2.0)

suite "Calculating an inverted Vector":
  proc testInverseVector[N: static[int], T](v1: Vector[N, T], expected: float) =
    block:
      let
        v2 = invertNew(v1)
        v3 = invert(v1)
      check:
        compareVectorToValue(v1, 1.0 / expected)
        compareVectorToValue(v2, expected)
        compareVectorToValue(v3, expected)
    block:
      var v2: Vector[N, T]
      deepCopy(v2, v1)
      let
        v3 = invertSelf(v2)
      check:
        compareVectorToValue(v2, expected)
        compareVectorToValue(v3, expected)
        v2 == v3
  test "Calculating an inverted Vector1":
    testInverseVector(vector(1, 2.0), 1.0 / 2.0)
  test "Calculating an inverted Vector2":
    testInverseVector(vector(2, 2.0), 1.0 / 2.0)
  test "Calculating an inverted Vector3":
    testInverseVector(vector(3, 2.0), 1.0 / 2.0)
  test "Calculating an inverted Vector4":
    testInverseVector(vector(4, 2.0), 1.0 / 2.0)

suite "Calculating the heading of a Vector":
  const
    PI_OVER_FOUR_RADS = 45.0 * PI / 180
    PI_OVER_SIX_RADS = 30.0 * PI / 180
    PI_OVER_THREE_RADS = 60.0 * PI / 180
  test "Calculating the heading of a Vector1":
    check:
      heading(vector(1, 2.0)) == 0.0
  test "Calculating the heading of a Vector2":
    let
      v1 = vector(2, 2.0)
      v2 = vector2(pow(3.0, 0.5) / 2.0, 0.5)
    check:
      heading(v1) == PI_OVER_FOUR_RADS
      headingXY(v1) == PI_OVER_FOUR_RADS
      heading(v1) == headingXY(v1)
      abs(heading(v2) - PI_OVER_SIX_RADS) < EPSILON
      abs(headingXY(v2) - PI_OVER_SIX_RADS) < EPSILON
      abs(heading(v2) - headingXY(v2)) < EPSILON
  test "Calculating the heading of a Vector3":
    let
      v1 = vector(3, 2.0)
      v2 = vector3(
        pow(3.0, 0.5) / 2.0,
        0.5,
        0.5)
    check:
      heading(v1) == PI_OVER_FOUR_RADS
      headingXY(v1) == PI_OVER_FOUR_RADS
      heading(v1) == headingXY(v1)
      headingXZ(v1) == PI_OVER_FOUR_RADS
      headingYZ(v1) == PI_OVER_FOUR_RADS
      abs(heading(v2) - PI_OVER_SIX_RADS) < EPSILON
      abs(headingXY(v2) - PI_OVER_SIX_RADS) < EPSILON
      abs(heading(v2) - headingXY(v2)) < EPSILON
      abs(headingXZ(v2) - PI_OVER_SIX_RADS) < EPSILON
      headingYZ(v2) == PI_OVER_FOUR_RADS
  test "Calculating the heading of a Vector4":
    let
      v1 = vector(4, 2.0)
      v2 = vector4(
        pow(3.0, 0.5) / 2.0,
        0.5,
        0.5,
        pow(3.0, 0.5) / 2.0)
    check:
      heading(v1) == PI_OVER_FOUR_RADS
      headingXY(v1) == PI_OVER_FOUR_RADS
      heading(v1) == headingXY(v1)
      headingXZ(v1) == PI_OVER_FOUR_RADS
      headingXW(v1) == PI_OVER_FOUR_RADS
      headingYZ(v1) == PI_OVER_FOUR_RADS
      headingYW(v1) == PI_OVER_FOUR_RADS
      headingZW(v1) == PI_OVER_FOUR_RADS
      abs(heading(v2) - PI_OVER_SIX_RADS) < EPSILON
      abs(headingXY(v2) - PI_OVER_SIX_RADS) < EPSILON
      abs(heading(v2) - headingXY(v2)) < EPSILON
      abs(headingXZ(v2) - PI_OVER_SIX_RADS) < EPSILON
      headingXW(v2) == PI_OVER_FOUR_RADS
      headingYZ(v2) == PI_OVER_FOUR_RADS
      abs(headingYW(v2) - PI_OVER_THREE_RADS) < EPSILON
      abs(headingZW(v2) - PI_OVER_THREE_RADS) < EPSILON

suite "Calculating the magnitude and length of a Vector":
  proc testVectorMagnitudeAndLength[N: static[int], T](v1: Vector[N, T], expected: float) =
    let
      m = magnitude(v1)
      l = length(v1)
    check:
      m == expected
      l == expected
      m == l
  test "Calculating the magnitude and length of a Vector1":
    testVectorMagnitudeAndLength(vector(1, 2.0), 2.0)
  test "Calculating the magnitude and length of a Vector2":
    testVectorMagnitudeAndLength(vector(2, 2.0), 2.0 * sqrt(2.0))
  test "Calculating the magnitude and length of a Vector3":
    testVectorMagnitudeAndLength(vector(3, 2.0), 2.0 * sqrt(3.0))
  test "Calculating the magnitude and length of a Vector4":
    testVectorMagnitudeAndLength(vector(4, 2.0), 4.0)

suite "Normalizing a Vector":
  proc testNormalizeVector[N: static[int], T](v1, expected: Vector[N, T], value: float = 1.0) =
    block:
      var v2, v4: Vector[N, T]
      deepCopy(v2, v1)
      deepCopy(v4, v1)
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
    testNormalizeVector(vector(1, 2.0), vector(1, 1.0))
    testNormalizeVector(vector(1, 2.0), vector(1, 2.0), 2.0)
  test "Normalizing a Vector2":
    testNormalizeVector(vector(2, 2.0), vector(2, 1.0 / sqrt(2.0)))
    testNormalizeVector(vector(2, 2.0), vector(2, 2.0), 2.0 * sqrt(2.0))
  test "Normalizing a Vector3":
    testNormalizeVector(vector(3, 2.0), vector(3, 1.0 / sqrt(3.0)))
    testNormalizeVector(vector(3, 2.0), vector(3, 2.0), 2.0 * sqrt(3.0))
  test "Normalizing a Vector4":
    testNormalizeVector(vector(4, 2.0), vector(4, 1.0 / 2.0))
    testNormalizeVector(vector(4, 2.0), vector(4, 2.0), 4.0)

suite "Calculating the reflection of a Vector":
  proc testReflectVector[N: static[int], T](v, n, expected: Vector[N, T]) =
    block:
      let
        v1 = reflectNew(v, n)
        v2 = reflect(v, n)
      check:
        compareVectorsWithinEpsilon(v1, expected)
        compareVectorsWithinEpsilon(v2, expected)
        v1 == v2
    block:
      var v1: Vector[N, T]
      deepCopy(v1, v)
      let
        v2 = reflectSelf(v1, n)
      check:
        compareVectorsWithinEpsilon(v1, expected)
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
  proc testRefractVector[N: static[int], T](v, n: Vector[N, T], eta: float, expected: Vector[N, T]) =
    block:
      let
        v1 = refractNew(v, n, eta)
        v2 = refract(v, n, eta)
      if not compareVectorsWithinEpsilon(v1, expected):
        checkpoint("eta is " & $eta)
      check:
        compareVectorsWithinEpsilon(v1, expected)
        compareVectorsWithinEpsilon(v2, expected)
        v1 == v2
    block:
      var v1: Vector[N, T]
      deepCopy(v1, v)
      let
        v2 = refractSelf(v1, n, eta)
      check:
        compareVectorsWithinEpsilon(v1, expected)
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
  proc testAngleBetweenVectors[N: static[int], T](v1, v2: Vector[N, T], expected: float) =
    let
      a = angleBetween(v1, v2)
    check:
      compareValuesWithinEpsilon(a, expected)
  test "Calculating the angle between Vector1s":
    testAngleBetweenVectors(vector(1, 2.0), vector(1, 2.0), 0.0)
  test "Calculating the angle between Vector2s":
    testAngleBetweenVectors(vector(2, 2.0), vector(2, 2.0), 0.0)
    testAngleBetweenVectors(vector2(2.0,
                                    0.0),
                            vector2(0.0, 2.0), PI / 2.0)
  test "Calculating the angle between Vector3s":
    testAngleBetweenVectors(vector(3, 2.0), vector(3, 2.0), 0.0)
    testAngleBetweenVectors(vector3(2.0,
                                    0.0,
                                    0.0),
                            vector3(0.0, 2.0, 0.0), PI / 2.0)
  test "Calculating the angle between Vector4s":
    testAngleBetweenVectors(vector(4, 2.0), vector(4, 2.0), 0.0)
    testAngleBetweenVectors(vector4(2.0,
                                    0.0,
                                    0.0,
                                    0.0),
                            vector4(0.0, 2.0, 0.0, 0.0), PI / 2.0)

suite "Getting Vector dimension":
  proc testVectorDimension[N: static[int], T](v1: Vector[N, T], expected: int) =
    check:
      dimension(v1) == expected
  test "Getting Vector1 dimension":
    testVectorDimension(vector(1, 1.0), 1)
  test "Getting Vector2 dimension":
    testVectorDimension(vector(2, 1.0), 2)
  test "Getting Vector3 dimension":
    testVectorDimension(vector(3, 1.0), 3)
  test "Getting Vector4 dimension":
    testVectorDimension(vector(4, 1.0), 4)

suite "Hashing Vector":
  proc testHashVector[N: static[int], T](v1, v2: Vector[N, T]) =
    var v3: Vector[N, T]
    deepCopy(v3, v1)
    check:
      hash(v1) != hash(v2)
      hash(v1) == hash(v3)
  test "Hashing Vector1":
    testHashVector(vector(1, 1.0), vector(1, 2.0))
  test "Hashing Vector2":
    testHashVector(vector(2, 1.0), vector(2, 2.0))
  test "Hashing Vector3":
    testHashVector(vector(3, 1.0), vector(3, 2.0))
  test "Hashing Vector4":
    testHashVector(vector(4, 1.0), vector(4, 2.0))

suite "Getting array from Vector":
  proc testVectorToArray[N: static[int], T](v1: Vector[N, T]) =
    let
      a = v1.toArray()
    check:
      compareVectorToValues(v1, @(a))
  test "Getting array from Vector1":
    testVectorToArray(vector(1, 1.0))
  test "Getting array from Vector2":
    testVectorToArray(vector(2, 1.0))
  test "Getting array from Vector3":
    testVectorToArray(vector(3, 1.0))
  test "Getting array from Vector4":
    testVectorToArray(vector(4, 1.0))

suite "Iterating over a Vector":
  proc testVectorIterate[N: static[int], T](v1: Vector[N, T]) =
    let
      a = v1.toArray()
    var
      i = 0
    for e in v1:
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
  proc testVectorToString[N: static[int], T](v1: Vector[N, T], expected: string) =
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

suite "Calculating a plane and planarity":
  # 10x - 10y + z = -2
  let
    p0 = vector3(10.0, 5.0, -52.0)
    p1 = vector3(5.0, 10.0, 48.0)
    p2 = vector3(2.0, 4.0, 18.0)
    p3 = vector3(3.0, 4.0, 8.0)
    p4 = vector3(3.0, 1.0, -22.0)
    p5 = vector3(7.0, 10.0, 28.0)
    n0 = vector3(-1.0, 100.0, 2.0)
    n1 = vector3(-10.0, 1.0, 40.0)
    n2 = vector3(1.0, 1.0, 1.0)
  proc estimateDistanceToPlane[T](v: Vector[3, T], p: Vector[4, T]): T =
    result = p.x * v.x + p.y * v.y + p.z * v.z + p.w
  test "Calculating a plane from 3 Vector3s":
    let plane = calculatePlane(p0, p1, p2)
    check:
      estimateDistanceToPlane(p0, plane) == 0
      estimateDistanceToPlane(p1, plane) == 0
      estimateDistanceToPlane(p2, plane) == 0
      estimateDistanceToPlane(p3, plane) == 0
      estimateDistanceToPlane(p4, plane) == 0
      estimateDistanceToPlane(p5, plane) == 0
      estimateDistanceToPlane(n0, plane) != 0
      estimateDistanceToPlane(n1, plane) != 0
      estimateDistanceToPlane(n2, plane) != 0
  test "Testing planarity of a set of Vector3s":
    check:
      arePlanar([p0, p1, p2, p3, p4, p5])
      not arePlanar([p0, p1, p2, p3, p4, p5, n0, n1, n2])
      not arePlanar([n0, n1, n2, p3, p4, p5])
      arePlanar([n0, n1, n2])