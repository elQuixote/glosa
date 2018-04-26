import ../../src/core/vector
import unittest

from system import abs
from math import pow, sqrt, PI
from sequtils import zip

const
  ETA = pow(10.0, -6)

# Vector testing constants
const
  NEGATIVE_ONE_F = -1.0
  ZERO_F: float = 0.0
  HALF_F: float = 0.5
  ONE_F: float = 1.0
  TWO_F: float = 2.0
  THREE_F: float = 3.0
  FOUR_F: float = 4.0
  FIVE_F: float = 5.0
  SIX_F: float = 6.0

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
      Vector1(x: ZERO_F),
      Vector1(x: ZERO_F),
      Vector1(x: ONE_F))
  test "Testing Vector2 equality and inequality":
    testVectorEquality(
      Vector2(x: ZERO_F, y: ONE_F),
      Vector2(x: ZERO_F, y: ONE_F ),
      Vector2(x: ONE_F, y: TWO_F))
  test "Testing Vector3 equality and inequality":
    testVectorEquality(
      Vector3(x: ZERO_F, y: ONE_F, z: TWO_F),
      Vector3(x: ZERO_F, y: ONE_F, z: TWO_F ),
      Vector3(x: ONE_F, y: TWO_F, z: THREE_F))
  test "Testing Vector4 equality and inequality":
    testVectorEquality(
      Vector4(x: ZERO_F, y: ONE_F, z: TWO_F, w: THREE_F),
      Vector4(x: ZERO_F, y: ONE_F, z: TWO_F, w: THREE_F ),
      Vector4(x: ONE_F, y: TWO_F, z: THREE_F, w: ZERO_F))

suite "Creating a new Vector with default constructor":
  proc testCreateVectorDefaultConstructor(v1, v2: Vector) =
    check:
      v1 == v2
  test "Creating a Vector1 with the default constructor":
    testCreateVectorDefaultConstructor(
      Vector1(x: ZERO_F),
      vector1(ZERO_F))
  test "Creating a Vector2 with the default constructor":
    testCreateVectorDefaultConstructor(
      Vector2(x: ZERO_F, y: ONE_F),
      vector2(ZERO_F, ONE_F))
  test "Creating a Vector3 with the default constructor":
    testCreateVectorDefaultConstructor(
      Vector3(x: ZERO_F, y: ONE_F, z: TWO_F),
      vector3(ZERO_F, ONE_F, TWO_F))
  test "Creating a Vector4 with the default constructor":
    testCreateVectorDefaultConstructor(
      Vector4(x: ZERO_F, y: ONE_F, z: TWO_F, w: THREE_F),
      vector4(ZERO_F, ONE_F, TWO_F, THREE_F))

suite "Creating a new Vector with single value constructor":
  proc testCreateVectorSingleValueConstructor(v1, v2: Vector) =
    check:
      v1 == v2
  test "Creating a Vector2 with single value constructor":
    testCreateVectorSingleValueConstructor(
        Vector2(x: ZERO_F, y: ZERO_F),
        vector2(ZERO_F))
  test "Creating a Vector3 with single value constructor":
    testCreateVectorSingleValueConstructor(
        Vector3(x: ZERO_F, y: ZERO_F, z: ZERO_F),
        vector3(ZERO_F))
  test "Creating a Vector4 with single value constructor":
    testCreateVectorSingleValueConstructor(
        Vector4(x: ZERO_F, y: ZERO_F, z: ZERO_F, w: ZERO_F),
        vector4(ZERO_F))

suite "Copying a new Vector":
  proc testCopyVector(v1, v2: Vector) =
    var v3 = v1.copy()
    v3 += v2
    check:
      v1 != v3
      compareVectorToValue(v1, ZERO_F)
      compareVectorToValue(v3, ONE_F)
  test "Copying a Vector1":
    testCopyVector(vector1(ZERO_F), vector1(ONE_F))
  test "Copying a Vector2":
    testCopyVector(vector2(ZERO_F), vector2(ONE_F))
  test "Copying a Vector3":
    testCopyVector(vector3(ZERO_F), vector3(ONE_F))
  test "Copying a Vector4":
    testCopyVector(vector4(ZERO_F), vector4(ONE_F))

suite "Setting a Vector to a single value":
  proc testSetVector(v1: Vector) =
    var
      v2 = v1.copy()
      v3 = v2.set(ONE_F)
    check:
      compareVectorToValue(v2, ONE_F)
      v2 == v3
  test "Setting a Vector1":
    testSetVector(vector1(ZERO_F))
  test "Setting a Vector2":
    testSetVector(vector2(ZERO_F))
  test "Setting a Vector3":
    testSetVector(vector3(ZERO_F))
  test "Setting a Vector4":
    testSetVector(vector4(ZERO_F))

suite "Clearing a Vector":
  proc testClearVector(v1: Vector) =
    var 
      v2 = v1.copy()
      v3 = v2.clear()
    check:
      not compareVectorToValue(v2, ONE_F)
      compareVectorToValue(v2, ZERO_F)
      v3 == v2
  test "Clearing a Vector1":
    testClearVector(vector1(ONE_F))
  test "Clearing a Vector2":
    testClearVector(vector2(ONE_F))
  test "Clearing a Vector3":
    testClearVector(vector3(ONE_F))
  test "Clearing a Vector4":
    testClearVector(vector4(ONE_F))

suite "Adding Vectors":
  proc testAddingVectors(v1, v2: Vector) =
    block:
      let
        v3 = addNew(v1, v2)
        v4 = v1 + v2
      check:
        compareVectorToValue(v3, THREE_F)
        compareVectorToValue(v4, THREE_F)
    block:
      var
        v3 = v1.copy()
      let
        v4 = addSelf(v3, v2)
      check:
        compareVectorToValue(v3, THREE_F)
        compareVectorToValue(v4, THREE_F)
        v3 == v4
    block:
      var
        v3 = v1.copy()
      v3 += v2
      check:
        not compareVectorToValue(v3, ONE_F)
        compareVectorToValue(v3, THREE_F)
  test "Adding Vector1s":
    testAddingVectors(vector1(ONE_F), vector1(TWO_F))
  test "Adding Vector2s":
    testAddingVectors(vector2(ONE_F), vector2(TWO_F))
  test "Adding Vector3s":
    testAddingVectors(vector3(ONE_F), vector3(TWO_F))
  test "Adding Vector4s":
    testAddingVectors(vector4(ONE_F), vector4(TWO_F))
  
suite "Adding a float to a Vector":
  proc testAddingVectorAndFloat(v1: Vector) =
    block:
      let
        v2 = addNew(v1, TWO_F)
        v3 = v1 + TWO_F
        v4 = TWO_F + v1
      check:
        compareVectorToValue(v2, THREE_F)
        compareVectorToValue(v3, THREE_F)
        compareVectorToValue(v4, THREE_F)
    block:
      var
        v2 = v1.copy()
      let
        v3 = addSelf(v2, TWO_F)
      check:
        compareVectorToValue(v2, THREE_F)
        compareVectorToValue(v3, THREE_F)
        v2 == v3
    block:
      var
        v2 = v1.copy()
      v2 += TWO_F
      check:
        not compareVectorToValue(v2, ONE_F)
        compareVectorToValue(v2, THREE_F)
  test "Adding a float to a Vector1":
    testAddingVectorAndFloat(vector1(ONE_F))
  test "Adding a float to a Vector2":
    testAddingVectorAndFloat(vector2(ONE_F))
  test "Adding a float to a Vector3":
    testAddingVectorAndFloat(vector3(ONE_F))
  test "Adding a float to a Vector4":
    testAddingVectorAndFloat(vector4(ONE_F))

suite "Subtracting Vectors":
  proc testSubtactingVectors(v1, v2: Vector) =
    block:
      let
        v3 = subtractNew(v2, v1)
        v4 = v2 - v1
      check:
        compareVectorToValue(v3, TWO_F)
        compareVectorToValue(v4, TWO_F)
    block:
      var
        v3 = v2.copy()
      let
        v4 = subtractSelf(v3, v1)
      check:
        compareVectorToValue(v3, TWO_F)
        compareVectorToValue(v4, TWO_F)
        v3 == v4
    block:
      var
        v3 = v2.copy()
      v3 -= v1
      check:
        not compareVectorToValue(v3, THREE_F)
        compareVectorToValue(v3, TWO_F)
  test "Subtracting Vector1s":
    testSubtactingVectors(vector1(ONE_F), vector1(THREE_F))
  test "Subtracting Vector2s":
    testSubtactingVectors(vector2(ONE_F), vector2(THREE_F))
  test "Subtracting Vector3s":
    testSubtactingVectors(vector3(ONE_F), vector3(THREE_F))
  test "Subtracting Vector4s":
    testSubtactingVectors(vector4(ONE_F), vector4(THREE_F))
  
suite "Subtacting a float from a Vector":
  proc testSubtactingVectorAndFloat(v1: Vector) =
    block:
      let
        v2 = subtractNew(v1, ONE_F)
        v3 = v1 - ONE_F
        v4 = FIVE_F - v1
      check:
        compareVectorToValue(v2, TWO_F)
        compareVectorToValue(v3, TWO_F)
        compareVectorToValue(v4, TWO_F)
    block:
      var
        v2 = v1.copy()
      let
        v3 = subtractSelf(v2, ONE_F)
      check:
        compareVectorToValue(v2, TWO_F)
        compareVectorToValue(v3, TWO_F)
        v2 == v3
    block:
      var
        v2 = v1.copy()
      v2 -= ONE_F
      check:
        not compareVectorToValue(v2, THREE_F)
        compareVectorToValue(v2, TWO_F)
  test "Subtracting a float from a Vector1":
    testSubtactingVectorAndFloat(vector1(THREE_F))
  test "Subtracting a float from a Vector2":
    testSubtactingVectorAndFloat(vector2(THREE_F))
  test "Subtracting a float from a Vector3":
    testSubtactingVectorAndFloat(vector3(THREE_F))
  test "Subtracting a float from a Vector4":
    testSubtactingVectorAndFloat(vector4(THREE_F))

suite "Multiplying a Vector by a float":
  proc testMultiplyingVectorAndFloat(v1: Vector) =
    block:
      let
        v2 = multiplyNew(v1, TWO_F)
        v3 = v1 * TWO_F
        v4 = TWO_F * v1
      check:
        compareVectorToValue(v2, SIX_F)
        compareVectorToValue(v3, SIX_F)
        compareVectorToValue(v4, SIX_F)
    block:
      var
        v2 = v1.copy()
      let
        v3 = multiplySelf(v2, TWO_F)
      check:
        compareVectorToValue(v2, SIX_F)
        compareVectorToValue(v3, SIX_F)
        v2 == v3
    block:
      var
        v2 = v1.copy()
      v2 *= TWO_F
      check:
        not compareVectorToValue(v2, TWO_F)
        compareVectorToValue(v2, SIX_F)
  test "Multiplying a Vector1 by a float":
    testMultiplyingVectorAndFloat(vector1(THREE_F))
  test "Multiplying a Vector2 by a float":
    testMultiplyingVectorAndFloat(vector2(THREE_F))
  test "Multiplying a Vector3 by a float":
    testMultiplyingVectorAndFloat(vector3(THREE_F))
  test "Multiplying a Vector4 by a float":
    testMultiplyingVectorAndFloat(vector4(THREE_F))

suite "Dividing a Vector by a float":
  proc testDividingVectorAndFloat(v1: Vector) =
    block:
      let
        v2 = divideNew(v1, TWO_F)
        v3 = v1 / TWO_F
        v4 = TWO_F / v1
      check:
        compareVectorToValue(v2, THREE_F)
        compareVectorToValue(v3, THREE_F)
        compareVectorToValue(v4, ONE_F / THREE_F)
    block:
      var
        v2 = v1.copy()
      let
        v3 = divideSelf(v2, TWO_F)
      check:
        compareVectorToValue(v2, THREE_F)
        compareVectorToValue(v3, THREE_F)
        v2 == v3
    block:
      var
        v2 = v1.copy()
      v2 /= TWO_F
      check:
        not compareVectorToValue(v2, SIX_F)
        compareVectorToValue(v2, THREE_F)
  test "Dividing a Vector1 by a float":
    testDividingVectorAndFloat(vector1(SIX_F))
  test "Dividing a Vector2 by a float":
    testDividingVectorAndFloat(vector2(SIX_F))
  test "Dividing a Vector3 by a float":
    testDividingVectorAndFloat(vector3(SIX_F))
  test "Dividing a Vector4 by a float":
    testDividingVectorAndFloat(vector4(SIX_F))

suite "Calculating dot product of Vectors":
  proc testDotProduct(v1, v2: Vector, expected: float) =
    check:
      dot(v1, v2) == expected
  test "Calculating dot product of Vector1s":
    testDotProduct(
      vector1(ONE_F),
      vector1(TWO_F),
      ONE_F * TWO_F)
    testDotProduct(
      vector1(TWO_F),
      vector1(THREE_F),
      TWO_F * THREE_F)
  test "Calculating dot product of Vector2s":
    testDotProduct(
      vector2(ONE_F),
      vector2(TWO_F),
      ONE_F * TWO_F * TWO_F)
    testDotProduct(
      vector2(TWO_F),
      vector2(THREE_F),
      TWO_F * THREE_F * TWO_F)
  test "Calculating dot product of Vector3s":
    testDotProduct(
      vector3(ONE_F),
      vector3(TWO_F),
      ONE_F * TWO_F * THREE_F)
    testDotProduct(
      vector3(TWO_F),
      vector3(THREE_F),
      TWO_F * THREE_F * THREE_F)
  test "Calculating dot product of Vector4s":
    testDotProduct(
      vector4(ONE_F),
      vector4(TWO_F),
      ONE_F * TWO_F * FOUR_F)
    testDotProduct(
      vector4(TWO_F),
      vector4(THREE_F),
      TWO_F * THREE_F * FOUR_F)

suite "Calculating cross product of Vectors":
  proc testCrossProductFloat(v1, v2: Vector, expected: float) =
    check:
      cross(v1, v2) == expected
  proc testCrossProductVector(v1, v2, expected: Vector) =
    check:
      cross(v1, v2) == expected
  test "Calculating cross product of Vector1s (float)":
    testCrossProductFloat(
      vector1(ONE_F),
      vector1(TWO_F),
      ONE_F * TWO_F)
    testCrossProductFloat(
      vector1(TWO_F),
      vector1(THREE_F),
      TWO_F * THREE_F)
  test "Calculating cross product of Vector2s (float)":
    testCrossProductFloat(
      Vector2(x: THREE_F, y: ONE_F),
      Vector2(x: FOUR_F, y: TWO_F),
      THREE_F * FOUR_F - ONE_F * TWO_F)
    testCrossProductFloat(
      Vector2(x: TWO_F, y: FOUR_F),
      Vector2(x: THREE_F, y: ONE_F),
      TWO_F * THREE_F - FOUR_F * ONE_F)
  test "Calculating cross product of Vector3s (Vector)":
    testCrossProductVector(
      Vector3(x: THREE_F, y: ONE_F, z: TWO_F),
      Vector3(x: FOUR_F, y: TWO_F, z: THREE_F),
      Vector3(
        x: ONE_F * THREE_F - TWO_F * TWO_F,
        y: TWO_F * FOUR_F - THREE_F * THREE_F,
        z: THREE_F * TWO_F - ONE_F * FOUR_F
      ))
    testCrossProductVector(
      Vector3(x: TWO_F, y: FOUR_F, z: ONE_F),
      Vector3(x: THREE_F, y: ONE_F, z: ZERO_F),
      Vector3(
        x: FOUR_F * ZERO_F - ONE_F * ONE_F,
        y: ONE_F * THREE_F - TWO_F * ZERO_F,
        z: TWO_F * ONE_F - FOUR_F * THREE_F
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
        compareVectorToValue(v1, NEGATIVE_ONE_F * expected)
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
    testInverseVector(vector1(TWO_F), NEGATIVE_ONE_F * TWO_F)
  test "Calculating the inverse of a Vector2":
    testInverseVector(vector2(TWO_F), NEGATIVE_ONE_F * TWO_F)
  test "Calculating the inverse of a Vector3":
    testInverseVector(vector3(TWO_F), NEGATIVE_ONE_F * TWO_F)
  test "Calculating the inverse of a Vector4":
    testInverseVector(vector4(TWO_F), NEGATIVE_ONE_F * TWO_F)

suite "Calculating an inverted Vector":
  proc testInverseVector(v1: Vector, expected: float) =
    block:
      let
        v2 = invertNew(v1)
        v3 = invert(v1)
      check:
        compareVectorToValue(v1, ONE_F / expected)
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
    testInverseVector(vector1(TWO_F), ONE_F / TWO_F)
  test "Calculating an inverted Vector2":
    testInverseVector(vector2(TWO_F), ONE_F / TWO_F)
  test "Calculating an inverted Vector3":
    testInverseVector(vector3(TWO_F), ONE_F / TWO_F)
  test "Calculating an inverted Vector4":
    testInverseVector(vector4(TWO_F), ONE_F / TWO_F)

suite "Calculating the heading of a Vector":
  const
    FORTY_FIVE_F = 45.0 * PI / 180
    THIRTY_F = 30.0 * PI / 180
    SIXTY_F = 60.0 * PI / 180
  test "Calculating the heading of a Vector1":
    check:
      heading(vector1(TWO_F)) == ZERO_F
  test "Calculating the heading of a Vector2":
    let
      v1 = vector2(TWO_F)
      v2 = Vector2(x: pow(THREE_F, HALF_F) / TWO_F, y: HALF_F)
    check:
      heading(v1) == FORTY_FIVE_F
      headingXY(v1) == FORTY_FIVE_F
      heading(v1) == headingXY(v1)
      abs(heading(v2) - THIRTY_F) < ETA
      abs(headingXY(v2) - THIRTY_F) < ETA
      abs(heading(v2) - headingXY(v2)) < ETA
  test "Calculating the heading of a Vector3":
    let
      v1 = vector3(TWO_F)
      v2 = Vector3(
        x: pow(THREE_F, HALF_F) / TWO_F,
        y: HALF_F,
        z: HALF_F)
    check:
      heading(v1) == FORTY_FIVE_F
      headingXY(v1) == FORTY_FIVE_F
      heading(v1) == headingXY(v1)
      headingXZ(v1) == FORTY_FIVE_F
      headingYZ(v1) == FORTY_FIVE_F
      abs(heading(v2) - THIRTY_F) < ETA
      abs(headingXY(v2) - THIRTY_F) < ETA
      abs(heading(v2) - headingXY(v2)) < ETA
      abs(headingXZ(v2) - THIRTY_F) < ETA
      headingYZ(v2) == FORTY_FIVE_F
  test "Calculating the heading of a Vector4":
    let
      v1 = vector4(TWO_F)
      v2 = Vector4(
        x: pow(THREE_F, HALF_F) / TWO_F,
        y: HALF_F,
        z: HALF_F,
        w: pow(THREE_F, HALF_F) / TWO_F)
    check:
      heading(v1) == FORTY_FIVE_F
      headingXY(v1) == FORTY_FIVE_F
      heading(v1) == headingXY(v1)
      headingXZ(v1) == FORTY_FIVE_F
      headingXW(v1) == FORTY_FIVE_F
      headingYZ(v1) == FORTY_FIVE_F
      headingYW(v1) == FORTY_FIVE_F
      headingZW(v1) == FORTY_FIVE_F
      abs(heading(v2) - THIRTY_F) < ETA
      abs(headingXY(v2) - THIRTY_F) < ETA
      abs(heading(v2) - headingXY(v2)) < ETA
      abs(headingXZ(v2) - THIRTY_F) < ETA
      headingXW(v2) == FORTY_FIVE_F
      headingYZ(v2) == FORTY_FIVE_F
      abs(headingYW(v2) - SIXTY_F) < ETA
      abs(headingZW(v2) - SIXTY_F) < ETA

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
    testVectorMagnitudeAndLength(vector1(TWO_F), TWO_F)
  test "Calculating the magnitude and length of a Vector2":
    testVectorMagnitudeAndLength(vector2(TWO_F), TWO_F * sqrt(TWO_F))
  test "Calculating the magnitude and length of a Vector3":
    testVectorMagnitudeAndLength(vector3(TWO_F), TWO_F * sqrt(THREE_F))
  test "Calculating the magnitude and length of a Vector4":
    testVectorMagnitudeAndLength(vector4(TWO_F), FOUR_F)

suite "Normalizing a Vector":
  proc testNormalizeVector(v1, expected: Vector, value: float = ONE_F) =
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
    testNormalizeVector(vector1(TWO_F), vector1(ONE_F))
    testNormalizeVector(vector1(TWO_F), vector1(TWO_F), TWO_F)
  test "Normalizing a Vector2":
    testNormalizeVector(vector2(TWO_F), vector2(ONE_F / sqrt(TWO_F)))
    testNormalizeVector(vector2(TWO_F), vector2(TWO_F), TWO_F * sqrt(TWO_F))
  test "Normalizing a Vector3":
    testNormalizeVector(vector3(TWO_F), vector3(ONE_F / sqrt(THREE_F)))
    testNormalizeVector(vector3(TWO_F), vector3(TWO_F), TWO_F * sqrt(THREE_F))
  test "Normalizing a Vector4":
    testNormalizeVector(vector4(TWO_F), vector4(ONE_F / TWO_F))
    testNormalizeVector(vector4(TWO_F), vector4(TWO_F), FOUR_F)

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
      normalizeNew(vector1(TWO_F)),
      normalizeNew(vector1(NEGATIVE_ONE_F)),
      normalizeNew(vector1(NEGATIVE_ONE_F * TWO_F)))
  test "Calculating the reflection of a Vector2":
    testReflectVector(
      normalizeNew(vector2(TWO_F, TWO_F)),
      normalizeNew(vector2(NEGATIVE_ONE_F, NEGATIVE_ONE_F)),
      normalizeNew(vector2(NEGATIVE_ONE_F * TWO_F, NEGATIVE_ONE_F * TWO_F)))
  test "Calculating the reflection of a Vector3":
    testReflectVector(
      normalizeNew(vector2(TWO_F, TWO_F)),
      normalizeNew(vector2(NEGATIVE_ONE_F, NEGATIVE_ONE_F)),
      normalizeNew(vector2(NEGATIVE_ONE_F * TWO_F, NEGATIVE_ONE_F * TWO_F)))
  test "Calculating the reflection of a Vector4":
    testReflectVector(
      normalizeNew(vector4(TWO_F, TWO_F, TWO_F, TWO_F)),
      normalizeNew(vector4(NEGATIVE_ONE_F, 
                           NEGATIVE_ONE_F, 
                           NEGATIVE_ONE_F, 
                           NEGATIVE_ONE_F)),
      normalizeNew(vector4(NEGATIVE_ONE_F * TWO_F, 
              NEGATIVE_ONE_F * TWO_F,
              NEGATIVE_ONE_F * TWO_F,
              NEGATIVE_ONE_F * TWO_F)))

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
      v1 = normalizeNew(vector1(TWO_F))
      v2 = normalizeNew(vector1(NEGATIVE_ONE_F))
    testRefractVector(v1, v2, ONE_F, v1)
  test "Calculating the refraction of a Vector2":
    let
      v1 = normalizeNew(vector2(TWO_F, TWO_F))
      v2 = normalizeNew(vector2(NEGATIVE_ONE_F, 
                                NEGATIVE_ONE_F))
    testRefractVector(v1, v2, ONE_F, v1)
  test "Calculating the refraction of a Vector3":
    let
      v1 = normalizeNew(vector3(TWO_F, TWO_F, TWO_F))
      v2 = normalizeNew(vector3(NEGATIVE_ONE_F, 
                                NEGATIVE_ONE_F, 
                                NEGATIVE_ONE_F))
    testRefractVector(v1, v2, ONE_F, v1)
  test "Calculating the refraction of a Vector4":
    let
      v1 = normalizeNew(vector4(TWO_F, TWO_F, TWO_F, TWO_F))
      v2 = normalizeNew(vector4(NEGATIVE_ONE_F, 
                                NEGATIVE_ONE_F, 
                                NEGATIVE_ONE_F, 
                                NEGATIVE_ONE_F))
    testRefractVector(v1, v2, ONE_F, v1)