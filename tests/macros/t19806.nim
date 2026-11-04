discard """
output: '''
0
2
4
6
8
'''
"""

# bug #19806

iterator `.++`[T](a: T, b: T): T =
  ## Increment each output by 2
  var res: T = a
  while res <= b:
    yield res
    inc res
    inc res

for i in 0 .++ 8:
  echo i
