import std/strutils

template collect[T](it: iterable[T]): seq[T] =
  var result: seq[T]
  for item in it:
    result.add item
  result

const text = "a,b,c"

# `split` has both collection-returning and iterator overloads. In iterable
# context, the iterator overload must be considered for both call syntaxes.
doAssert collect(text.split(',')) == @["a", "b", "c"]
doAssert text.split(',').collect == @["a", "b", "c"]
