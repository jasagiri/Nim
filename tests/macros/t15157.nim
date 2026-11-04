discard """
nimout: '''
g got: (Ident "echo")
m got: (Ident "echo")
'''
"""

# bug #15157

import macros
macro g(n:untyped) =
  echo "g got: ",n.lisprepr
  result = newCall(n,newLit"ok")
macro m(n:untyped) =
  echo "m got: ",n.lisprepr
  proc p(x:NimNode):NimNode = newCall(n,x)
  result = p(newLit"ok")
g echo
m echo
