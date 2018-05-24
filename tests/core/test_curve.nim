import ../../src/core/vector
import ../../src/core/curve
import unittest

let nc = nurbsCurve([vector3(-10, 0, 0), vector3(10, 0,0 ), vector3(10, 10, 0), vector3(0, 10, 0), vector3(5, 5, 0)])
echo $nc

suite "Constructing 2D NURBS Curves":
  test "Constructing 2D NURBS Curves with weighted points":
    discard
  test "Constructing 2D NURBS Curves with points and weights":
    discard
  test "Constructing 2D NURBS Curves by interpolation":
    discard

suite "Constructing 3D NURBS Curves":
  test "Constructing 3D NURBS Curves with weighted points":
    discard
  test "Constructing 3D NURBS Curves with points and weights":
    discard
  test "Constructing 3D NURBS Curves by interpolation":
    discard