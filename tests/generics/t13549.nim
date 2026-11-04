discard """
output: '''
b
c
'''
"""

# bug #13549

proc foo[T](x: T) = echo "a"

proc foo[T: tuple](x: T) = echo "b"

foo((1, 2, 3))

type Obj = object
proc foo(x: object) = echo "c"
foo(Obj())
