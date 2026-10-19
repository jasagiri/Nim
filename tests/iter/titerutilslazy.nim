import std/iterutils

iterator values(): int {.inline.} =
  yield 1
  yield 2
  yield 3

template consumeAndCheck(source: iterable[int], calls: untyped) =
  doAssert calls == 0
  for value in source:
    discard value
  doAssert calls == 3

var mapCalls = 0
proc countMap(value: int): int =
  inc mapCalls
  value * 2

consumeAndCheck(values().map(countMap), mapCalls)

var predicateCalls = 0
proc countPredicate(value: int): bool =
  inc predicateCalls
  value mod 2 == 1

consumeAndCheck(values().filter(countPredicate), predicateCalls)
