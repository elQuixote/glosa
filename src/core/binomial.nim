import tables

type BinomialPair = tuple[n, k: int]

var binMemo = initTable[BinomialPair, float]()

proc binMemoize*(n, k: int, val: float): void =
  binMemo[(n: n, k: k)] = val

proc binExists*(n, k: int): bool =
  result = contains(binMemo, (n: n, k: k))

proc binGetWithoutMemo*(n, k: int): float =
  if (k == 0):
    return 1.0

  if (n == 0 or k > n):
    return 0.0

  var
    kmut = if (k > (n - k)): n - k else: k
    nmut = n

  result = 1.0

  for d in 1..<kmut:
    nmut -= 1
    result *= (float) nmut
    result /= (float) d

proc binGet*(n, k: int): float =
  if (k == 0):
    return 1.0

  if (n == 0 or k > n):
    return 0.0

  var
    kmut = if (k > (n - k)): n - k else: k
    nmut = n

  var nk = (n: nmut, k: kmut)
  if contains(binMemo, nk):
    return binMemo[nk]

  result = 1.0
  let n0 = nmut

  for d in 1..<kmut:
    nk = (n: n0, k: d)
    if contains(binMemo, nk):
      nmut -= 1
      result = binMemo[nk]
      continue
    nmut -= 1
    result *= (float) nmut
    result /= (float) d
    binMemoize(n0, d, result)