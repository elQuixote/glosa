from ../../src/core/concepts import Vector, Set
import ../../src/core/vector
import unittest

# Vector testing constants
const
  ZERO_F: float = 0.0
  ONE_F: float = 1.0
  TWO_F: float = 2.0
  THREE_F: float = 3.0

# Vector testing utilities
proc compareVectorToValue(vector: Vector, value: float): bool =
  let a = vector.toArray()
  result = true
  for v in a:
    if v != value:
      result = false

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