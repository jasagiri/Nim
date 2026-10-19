discard """
  output: '''2
4
6'''
"""

import std/[iterutils, sequtils]

proc double(value: var int) = value *= 2

var values = [1, 2, 3]
values.mitems.apply(double)
doAssert values == [2, 4, 6]
for value in values:
  echo value

var seqValues = [1, 2, 3]
seqValues.apply(double)
doAssert seqValues == [2, 4, 6]
