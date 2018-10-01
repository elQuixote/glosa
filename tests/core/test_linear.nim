from ../../src/core/constants import TEST_EPSILON
import ../../src/core/linear
import unittest

proc compareValuesWithinEpsilon(a, b: seq[seq[float]]): bool =
  result = true
  for i in 0..<len(a):
    for j in 0..<len(a):
      if abs(a[i][j] - b[i][j]) >= TEST_EPSILON:
        checkpoint("a[" & $i & "][" & $j & "] was " & $a[i][j])
        checkpoint("b[" & $i & "][" & $j & "] was " & $b[i][j])
        result = false

suite "Solving a set of equations":
  test "Calculating LU Decomposition":
    let
      lu1 = lu(
        @[
          @[0.46126, 0.947562, 0.0360899, 0.515195, 0.441904],
          @[0.755873, 0.399915, 0.0821265, 0.119738, 0.163626],
          @[0.391917, 0.29754, 0.599393, 0.551227, 0.715397],
          @[0.337709, 0.808845, 0.800232, 0.0179933, 0.0738991],
          @[0.977022, 0.620468, 0.698873, 0.658996, 0.824985]
        ]
      )
      expectedlu1 =
        (lu: @[
          @[0.9770219999999999, 0.620468, 0.698873, 0.658996, 0.824985],
          @[0.4721080999199609, 0.6546340314588617, -0.2938537041153628, 0.2040776505851454, 0.0524218991875311],
          @[0.3456513773487189, 0.9079567401569573, 0.8254720362298007, -0.3950832534314755, -0.2588549182411802],
          @[0.7736499280466561, -0.1223737534340007, -0.5990712043444254, -0.6018034603384453, -0.6232810489450752],
          @[0.4011342630974533, 0.07431484418253397, 0.4129622463494185, -0.7226106575375829, 0.03707930459523123]
        ], p: @[4, 4, 3, 4, 4])
    check:
      compareValuesWithinEpsilon(lu1.lu, expectedlu1.lu)
      lu1.p == expectedlu1.p
  test "Solving using LU Decomposition":
    discard

suite "Transposing an arbitrary matrix":
  test "Calculating LU Decomposition":
    let
      m1 = @[
        @[0.91, 0.51, 0.59, 0.508, 0.73],
        @[0.94, 0.1, 0.139, 0.5, 0.47],
        @[0.2, 0.3, 0.973, 0.973, 0.377],
        @[0.0, 0.4, 0.17, 0.64, 0.78],
        @[0.05, 0.52, 0.56, 0.485, 0.78]
      ]
      expectedm1 = @[
        @[0.91, 0.94, 0.2, 0.0, 0.05],
        @[0.51, 0.1, 0.3, 0.4, 0.52],
        @[0.59, 0.139, 0.973, 0.17, 0.56],
        @[0.508, 0.5, 0.973, 0.64, 0.485],
        @[0.73, 0.47, 0.377, 0.78, 0.78]
      ]
      m1transpose = transpose(m1)
    check:
      compareValuesWithinEpsilon(m1transpose, expectedm1)