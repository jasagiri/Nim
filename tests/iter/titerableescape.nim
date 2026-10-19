discard """
  output: '''8
10
12'''
"""

template map[T; U](it: iterable[T], transform: proc (item: T): U): untyped =
  iterator mapped(): U {.gensym.} =
    for item in it:
      yield transform(item)
  mapped()

template filter[T](it: iterable[T], predicate: proc (item: T): bool): untyped =
  iterator filtered(): T {.gensym.} =
    for item in it:
      if predicate(item):
        yield item
  filtered()

template asClosure[T](it: iterable[T]): untyped =
  iterator escaped(): T {.closure, gensym.} =
    for item in it:
      yield item
  escaped

proc double(value: int): int = value * 2
proc isEven(value: int): bool = value mod 2 == 0

proc makeCounter(start: int): iterator (): int {.closure.} =
  var next = start
  result = iterator (): int {.closure.} =
    while next < start + 3:
      yield next
      inc next

proc makePipeline(start: int): iterator (): int {.closure.} =
  let source = makeCounter(start)
  result = asClosure(source().map(double).filter(isEven))

let pipeline = makePipeline(4)
for value in pipeline():
  echo value
