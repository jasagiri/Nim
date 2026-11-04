discard """
nimout: '''
ArgList
  Ident "foo"
  Call
    Ident "bar"
    IntLit 1
ArgList
  Ident "foo"
  Call
    Ident "bar"
    IntLit 1
'''
"""

# bug #19392

import std/macros
macro `?`(a: varargs[untyped]): untyped =
  echo a.treerepr

foo?bar(1)

macro `.?`(a: varargs[untyped]): untyped =
  echo a.treerepr

foo.?bar(1)
