discard """
output: '''
11
'''
"""

# bug #23567

macro foo(arg: int): int =
  proc impl(): NimNode = arg
  impl()

echo foo(11)
