discard """
output: '''
false
'''
"""

# bug #16321

import options, streams

proc storeBin*(s: Stream; x: bool) =
  write(s, $x)

proc storeBin*[T](s: Stream; o: Option[T]) =
  let isSome = isSome(o)
  storeBin(s, isSome)
  if isSome:
    storeBin(s, get(o))

proc storeBin*[T: object|tuple](s: Stream; o: T) =
  write(s, "bug")

var s = newStringStream()
s.storeBin(none(bool))
#s.storeBin(some(true)) #same
echo s.data
