discard """
  output: "8,10,12,14|8,10,12,14|8,10,12,14|10,11,12"
"""

import std/iterutils

proc double(value: int): int = value * 2
proc keep(value: int): bool = value >= 8
proc addOffset(offset: int): proc (value: int): int {.closure.} =
  result = proc (value: int): int = value + offset

iterator numbers(count: int): int {.inline.} =
  for value in 0 ..< count:
    yield value

proc makePipeline(count: int): iterator (): int {.closure.} =
  result = asClosure(numbers(count).map(double).filter(keep))

var inlineValues: seq[int]
for value in numbers(8).map(double).filter(keep):
  inlineValues.add value

let escaped = makePipeline(8)
var escapedValues: seq[int]
for value in escaped():
  escapedValues.add value

var chainedClosureValues: seq[int]
let chained = numbers(8).map(double).filter(keep).asClosure()
for value in chained():
  chainedClosureValues.add value

var capturedValues: seq[int]
for value in numbers(3).map(addOffset(10)):
  capturedValues.add value

proc format(values: seq[int]): string =
  for index, value in values:
    if index > 0:
      result.add ','
    result.add $value

echo format(inlineValues), '|', format(escapedValues), '|',
  format(chainedClosureValues), '|', format(capturedValues)
