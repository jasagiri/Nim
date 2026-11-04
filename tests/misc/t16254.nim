discard """
output: '''
1234
'''
"""

# bug #16254

var untypedHook: proc()

type Hook = proc(n: int)

proc setHook(hook: Hook) =
  untypedHook = cast[proc()](hook)

proc callHook(n: int) =
  cast[Hook](untypedHook)(n)

setHook proc(n: int) = echo(n)
callHook(1234)
