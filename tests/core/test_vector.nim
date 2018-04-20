import ../../src/core/vector
import unittest

# Vector testing constants
const
  ZERO_F: float = 0.0
  ONE_F: float = 1.0
  TWO_F: float = 2.0
  THREE_F: float = 3.0

# Vector testing utilities
proc checkValues(): bool =
  discard

suite "Testing Vector equality and inequality":
  test "Testing Vector1 equality and inequality":
    block:
      let
        v1 = Vector1(x: ZERO_F)
        v2 = Vector1(x: ZERO_F)
        v3 = Vector1(x: ONE_F)
      check:
        v1 == v2
        v1 != v3
  test "Testing Vector2 equality and inequality":
    block:
      let
        v1 = Vector2(x: ZERO_F, y: ONE_F)
        v2 = Vector2(x: ZERO_F, y: ONE_F )
        v3 = Vector2(x: ONE_F, y: TWO_F)
      check:
        v1 == v2
        v1 != v3
  test "Testing Vector3 equality and inequality":
    block:
      let
        v1 = Vector3(x: ZERO_F, y: ONE_F, z: TWO_F)
        v2 = Vector3(x: ZERO_F, y: ONE_F, z: TWO_F )
        v3 = Vector3(x: ONE_F, y: TWO_F, z: THREE_F)
      check:
        v1 == v2
        v1 != v3
  test "Testing Vector4 equality and inequality":
    block:
      let
        v1 = Vector4(x: ZERO_F, y: ONE_F, z: TWO_F, w: THREE_F)
        v2 = Vector4(x: ZERO_F, y: ONE_F, z: TWO_F, w: THREE_F )
        v3 = Vector4(x: ONE_F, y: TWO_F, z: THREE_F, w: ZERO_F)
      check:
        v1 == v2
        v1 != v3

suite "Creating a new Vector":
  test "Creating a Vector1 with the default constructor":
    block:
      let v1 = Vector1(x: ZERO_F)
      check:
        v1.x == ZERO_F
      let v2 = vector1(ZERO_F)
      check:
        v1 == v2
  test "Creating a Vector2 with the default constructor":
    block:
      let v1 = Vector2(x: ZERO_F, y: ONE_F)
      check:
        v1.x == ZERO_F
        v1.y == ONE_F
      let v2 = vector2(ZERO_F, ONE_F)
      check:
        v1 == v2
  test "Creating a Vector3 with the default constructor":
    block:
      let v1 = Vector3(x: ZERO_F, y: ONE_F, z: TWO_F)
      check:
        v1.x == ZERO_F
        v1.y == ONE_F
        v1.z == TWO_F
      let v2 = vector3(ZERO_F, ONE_F, TWO_F)
      check:
        v1 == v2
  test "Creating a Vector4 with the default constructor":
    block:
      let v1 = Vector4(x: ZERO_F, y: ONE_F, z: TWO_F, w: THREE_F)
      check:
        v1.x == ZERO_F
        v1.y == ONE_F
        v1.z == TWO_F
        v1.w == THREE_F
      let v2 = vector4(ZERO_F, ONE_F, TWO_F, THREE_F)
      check:
        v1 == v2

suite "Copying a new Vector":
  test "Copying a Vector1":
    block:
      var 
        v1 = Vector1(x: ZERO_F)
        v2 = v1.copy()
      v2.x += ONE_F
      check:
        v1.x != v2.x
        v1.x == ZERO_F
        v2.x == ONE_F
  test "Copying a Vector2":
    block:
      var 
        v1 = Vector2(x: ZERO_F, y: ZERO_F)
        v2 = v1.copy()
      v2.x += ONE_F
      v2.y += ONE_F
      check:
        v1.x != v2.x
        v1.x == ZERO_F
        v2.x == ONE_F
        v1.y != v2.y
        v1.y == ZERO_F
        v2.y == ONE_F
  test "Copying a Vector3":
    block:
      var 
        v1 = Vector3(x: ZERO_F, y: ZERO_F, z: ZERO_F)
        v2 = v1.copy()
      v2.x += ONE_F
      v2.y += ONE_F
      v2.z += ONE_F
      check:
        v1.x != v2.x
        v1.x == ZERO_F
        v2.x == ONE_F
        v1.y != v2.y
        v1.y == ZERO_F
        v2.y == ONE_F
        v1.z != v2.z
        v1.z == ZERO_F
        v2.z == ONE_F
  test "Copying a Vector4":
    block:
      var 
        v1 = Vector4(x: ZERO_F, y: ZERO_F, z: ZERO_F, w: ZERO_F)
        v2 = v1.copy()
      v2.x += ONE_F
      v2.y += ONE_F
      v2.z += ONE_F
      v2.w += ONE_F
      check:
        v1.x != v2.x
        v1.x == ZERO_F
        v2.x == ONE_F
        v1.y != v2.y
        v1.y == ZERO_F
        v2.y == ONE_F
        v1.z != v2.z
        v1.z == ZERO_F
        v2.z == ONE_F
        v1.w != v2.w
        v1.w == ZERO_F
        v2.w == ONE_F

suite "Setting a Vector to a single value":
  test "Setting a Vector1":
    block:
      var 
        v1 = Vector1(x: ZERO_F)
      let
        v2 = v1.setNew(ONE_F)
      check:
        v1.x != v2.x
        v1.x == ZERO_F
        v2.x == ONE_F
      v1 = v1.setSelf(TWO_F)
      check:
        v1.x != v2.x
        v1.x == TWO_F
        v2.x == ONE_F
    block:
      var
        v1 = Vector1(x: ZERO_F)
      v1 = v1.set(ONE_F)
      check:
        v1.x == ONE_F
  test "Setting a Vector2":
    block:
      var 
        v1 = Vector2(x: ZERO_F, y: ZERO_F)
      let
        v2 = v1.setNew(ONE_F)
      check:
        v1.x != v2.x
        v1.x == ZERO_F
        v2.x == ONE_F
        v1.y != v2.y
        v1.y == ZERO_F
        v2.y == ONE_F
      v1 = v1.setSelf(TWO_F)
      check:
        v1.x != v2.x
        v1.x == TWO_F
        v2.x == ONE_F
        v1.y != v2.y
        v1.y == TWO_F
        v2.y == ONE_F
    block:
      var
        v1 = Vector2(x: ZERO_F, y: ZERO_F)
      v1 = v1.set(ONE_F)
      check:
        v1.x == ONE_F
        v1.y == ONE_F
  test "Setting a Vector3":
    block:
      var 
        v1 = Vector3(x: ZERO_F, y: ZERO_F, z: ZERO_F)
      let
        v2 = v1.setNew(ONE_F)
      check:
        v1.x != v2.x
        v1.x == ZERO_F
        v2.x == ONE_F
        v1.y != v2.y
        v1.y == ZERO_F
        v2.y == ONE_F
        v1.z != v2.z
        v1.z == ZERO_F
        v2.z == ONE_F
      v1 = v1.setSelf(TWO_F)
      check:
        v1.x != v2.x
        v1.x == TWO_F
        v2.x == ONE_F
        v1.y != v2.y
        v1.y == TWO_F
        v2.y == ONE_F
        v1.z != v2.z
        v1.z == TWO_F
        v2.z == ONE_F
    block:
      var
        v1 = Vector3(x: ZERO_F, y: ZERO_F, z: ZERO_F)
      v1 = v1.set(ONE_F)
      check:
        v1.x == ONE_F
        v1.y == ONE_F
        v1.z == ONE_F
  test "Setting a Vector4":
    block:
      var 
        v1 = Vector4(x: ZERO_F, y: ZERO_F, z: ZERO_F, w: ZERO_F)
      let
        v2 = v1.setNew(ONE_F)
      check:
        v1.x != v2.x
        v1.x == ZERO_F
        v2.x == ONE_F
        v1.y != v2.y
        v1.y == ZERO_F
        v2.y == ONE_F
        v1.z != v2.z
        v1.z == ZERO_F
        v2.z == ONE_F
        v1.w != v2.w
        v1.w == ZERO_F
        v2.w == ONE_F
      v1 = v1.setSelf(TWO_F)
      check:
        v1.x != v2.x
        v1.x == TWO_F
        v2.x == ONE_F
        v1.y != v2.y
        v1.y == TWO_F
        v2.y == ONE_F
        v1.z != v2.z
        v1.z == TWO_F
        v2.z == ONE_F
        v1.w != v2.w
        v1.w == TWO_F
        v2.w == ONE_F
    block:
      var
        v1 = Vector4(x: ZERO_F, y: ZERO_F, z: ZERO_F, w: ZERO_F)
      v1 = v1.set(ONE_F)
      check:
        v1.x == ONE_F
        v1.y == ONE_F
        v1.z == ONE_F
        v1.w == ONE_F

suite "Clearing a Vector":
  test "Clearing a Vector1":
    block:
      var 
        v1 = Vector1(x: ONE_F)
      v1 = v1.clear()
      check:
        v1.x == ZERO_F
  test "Setting a Vector2":
    block:
      var 
        v1 = Vector2(x: ONE_F, y: ONE_F)
      v1 = v1.clear()
      check:
        v1.x == ZERO_F
        v1.y == ZERO_F
  test "Setting a Vector3":
    block:
      var 
        v1 = Vector3(x: ONE_F, y: ONE_F, z: ONE_F)
      v1 = v1.clear()
      check:
        v1.x == ZERO_F
        v1.y == ZERO_F
        v1.z == ZERO_F
  test "Setting a Vector4":
    block:
      var 
        v1 = Vector4(x: ONE_F, y: ONE_F, z: ONE_F, w: ONE_F)
      v1 = v1.clear()
      check:
        v1.x == ZERO_F
        v1.y == ZERO_F
        v1.z == ZERO_F
        v1.w == ZERO_F