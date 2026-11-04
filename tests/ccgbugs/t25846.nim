discard """
output: '''
321
'''
"""

# bug #25846

proc testVarRet(x: var int): var int = x

proc testProcTypeParam(prc: proc (x: var int): var int {.nimcall.}) =
  var x = 123
  prc(x) = 321
  echo x

testProcTypeParam(testVarRet)
