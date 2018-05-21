# NOTE: All of this stuff needs a new home
from algorithm import fill

type LUDecomposition = tuple[lu: seq[seq[float]], p: seq[int]]

proc lu*(a: seq[seq[float]]): LUDecomposition =
  let n = len(a)
  result.lu = a
  result.p = newSeq[int](n)

  for k in 0..<n:
    var
      pk = k
      max = abs(result.lu[k][k])

    for j in (k + 1)..<n:
      let absAjk = abs(result.lu[j][k])
      if (max < absAjk):
        max = absAjk
        pk = j
    result.p[k] = pk

    if (pk != k):
      swap(result.lu[k], result.lu[pk])

    for i in (k + 1)..<n:
      result.lu[i][k] /= result.lu[k][k]

    for i in (k + 1)..<n:
      for j in (k + 1)..<n:
        result.lu[i][j] -= result.lu[i][k] * result.lu[k][j]

proc luSolve*(lup: LUDecomposition, b: seq[float]): seq[float] =
  let  n = len(lup.lu)
  result = b

  for i in 0..<n:
    let pi = lup.p[i]
    if (pi != i):
      swap(result[i], result[pi])

    for j in 0..<i:
      result[i] -= result[j] * lup.lu[i][j]

  for i in countdown(n - 1, 0):
    for j in (i + 1)..<n:
      result[i] -= result[j] * lup.lu[i][j]
    result[i] /= lup.lu[i][i]

proc solve*(a: seq[seq[float]], b: seq[float]): seq[float] =
  result = luSolve(lu(a), b)

# NOTE: This proc especially needs to move
proc transpose*(a: seq[seq[float]]): seq[seq[float]] =
  let n = len(a)
  result = a
  for i in 0..<n:
    for j in 0..<n:
      result[i][j] = a[j][i]