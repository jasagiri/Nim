discard """
  output: '''2
4
2
4
'''
"""

import std/[iterutils, sequtils]

proc double(value: int): int = value * 2
proc keepEven(value: int): bool = value mod 2 == 0

let values = @[1, 2]

# For collections, the existing sequtils overload remains the selected API.
let eager = values.map(double)
static:
  doAssert typeof(eager) is seq[int]
doAssert eager == @[2, 4]

let injected = values.mapIt(it * 2)
doAssert injected == @[2, 4]

# Iterator-only sources use the lazy iterutils templates.
iterator source(): int {.inline.} =
  yield 1
  yield 2

for value in source().map(double).filter(keepEven):
  echo value

for value in values.items.map(double).filter(keepEven):
  echo value
