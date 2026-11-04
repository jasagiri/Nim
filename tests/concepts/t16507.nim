discard """
output: '''
ok
'''
"""

# bug #16507

type
  K = concept x
    true

proc foo(t: K) = echo "ok"

when defined(bad):
  int.foo
else:
  2.foo
