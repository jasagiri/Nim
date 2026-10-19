discard """
  output: '''8
10
12'''
"""

template collect[T](it: iterable[T]): seq[T] =
  var result: seq[T]
  for item in it:
    result.add item
  result

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

proc double(value: int): int = value * 2
proc isEven(value: int): bool = value mod 2 == 0

proc makeCounter(start: int): iterator (): int {.closure.} =
  var next = start
  result = iterator (): int {.closure.} =
    while next < start + 3:
      yield next
      inc next

let counter = makeCounter(4)
let values = collect(counter().map(double).filter(isEven))
for value in values:
  echo value
