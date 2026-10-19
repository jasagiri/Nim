## Local benchmark for iterator pipeline prototypes.
## Run with: nim c -d:danger -r tests/benchmarks/iterutils.nim

discard """
  action: compile
"""

import std/times

const
  ItemCount = 2_000_000
  Repetitions = 3

proc transform(value: int): int = value * 3 + 1
proc keep(value: int): bool = value mod 5 == 0

template mapInline[T; U](source: iterable[T], f: proc (value: T): U): untyped =
  iterator mapped(): U {.gensym.} =
    for value in source:
      yield f(value)
  mapped()

template filterInline[T](source: iterable[T], predicate: proc (value: T): bool): untyped =
  iterator filtered(): T {.gensym.} =
    for value in source:
      if predicate(value):
        yield value
  filtered()

template asClosure[T](source: iterable[T]): untyped =
  iterator escaped(): T {.closure, gensym.} =
    for value in source:
      yield value
  escaped

proc manualSum(): int =
  for value in 0..<ItemCount:
    let mapped = transform(value)
    if keep(mapped):
      result += mapped

proc inlinePipelineSum(): int =
  for value in mapInline(0..<ItemCount, transform).filterInline(keep):
    result += value

proc makeEscapedInlinePipeline(count: int): iterator (): int {.closure.} =
  result = asClosure(mapInline(0..<count, transform).filterInline(keep))

proc escapedInlinePipelineSum(): int =
  let pipeline = makeEscapedInlinePipeline(ItemCount)
  for value in pipeline():
    result += value

proc makeClosureRange(count: int): iterator (): int {.closure.} =
  var current = 0
  result = iterator (): int {.closure.} =
    while current < count:
      yield current
      inc current

proc mapClosure[T; U](source: iterator (): T {.closure.},
                      f: proc (value: T): U {.closure.}): iterator (): U {.closure.} =
  result = iterator (): U {.closure.} =
    for value in source():
      yield f(value)

proc filterClosure[T](source: iterator (): T {.closure.},
                      predicate: proc (value: T): bool {.closure.}): iterator (): T {.closure.} =
  result = iterator (): T {.closure.} =
    for value in source():
      if predicate(value):
        yield value

proc closurePipelineSum(): int =
  let source = makeClosureRange(ItemCount)
  let mapped = mapClosure(source, transform)
  let filtered = filterClosure(mapped, keep)
  for value in filtered():
    result += value

proc benchmark(name: string, run: proc (): int {.nimcall.}, expected: int) =
  let started = cpuTime()
  var checksum = 0
  for _ in 0..<Repetitions:
    checksum += run()
  let elapsed = cpuTime() - started
  doAssert checksum == expected * Repetitions
  echo name, ": ", elapsed, "s"

let expected = manualSum()
benchmark("hand-written loop", manualSum, expected)
benchmark("inline iterator pipeline", inlinePipelineSum, expected)
benchmark("inline pipeline, one closure boundary", escapedInlinePipelineSum, expected)
benchmark("closure iterator pipeline", closurePipelineSum, expected)
