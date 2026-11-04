discard """
nimout: '''
@[0, 1, 2]
'''
"""

# bug #25437

import std/algorithm

func doCompute(a: ptr UncheckedArray[int], len: int): seq[int] =
  var foo = newSeq[int](len)
  for i in 0 ..< len:
    foo[i] = i
  foo.sort do (x, y: auto) -> int:
    cmp(a[x], a[y])
  foo

func compute(a: openArray[int]): seq[int] =
  doCompute(cast[ptr UncheckedArray[int]](unsafeAddr a[0]), a.len)

const x = [1, 2, 3]
static: echo compute(x)  # Works without `static`
