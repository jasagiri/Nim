discard """
nimout: '''
array[1..2, int]
'''
"""

# bug #22881

template test[I, T](a: array[I, T]) =
  static: echo typeof(a)

test([1: 4, 2: 5])
