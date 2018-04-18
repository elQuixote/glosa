import ../../src/core/vector
import unittest

const
  ZERO_F: float = 0.0
  ONE_F: float = 1.0
  TWO_F: float = 2.0
  THREE_F: float = 3.0

suite "Creating a new Vector":
  test "Creating a Vector1 with the default constructor":
    block:
      let v1 = Vector1(x: ZERO_F)
      check:
        v1.x == ZERO_F
      let v2 = vector1(ZERO_F)
      check:
        v2.x == ZERO_F
        v1.x == v2.x
  test "Creating a Vector2 with the default constructor":
    block:
      let v1 = Vector2(x: ZERO_F, y: ONE_F)
      check:
        v1.x == ZERO_F
        v1.y == ONE_F
      let v2 = vector2(ZERO_F, ONE_F)
      check:
        v2.x == ZERO_F
        v1.x == v2.x
        v2.y == ONE_F
        v1.y == v2.y
  test "Creating a Vector3 with the default constructor":
    block:
      let v1 = Vector3(x: ZERO_F, y: ONE_F, z: TWO_F)
      check:
        v1.x == ZERO_F
        v1.y == ONE_F
        v1.z == TWO_F
      let v2 = vector3(ZERO_F, ONE_F, TWO_F)
      check:
        v2.x == ZERO_F
        v1.x == v2.x
        v2.y == ONE_F
        v1.y == v2.y
        v2.z == TWO_F
        v1.z == v2.z
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
        v2.x == ZERO_F
        v1.x == v2.x
        v2.y == ONE_F
        v1.y == v2.y
        v2.z == TWO_F
        v1.z == v2.z
        v1.w == THREE_F
        v1.w == v2.w