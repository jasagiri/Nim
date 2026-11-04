discard """
output: '''
(field: 3)
'''
"""

# bug #16105

type Foo[T] = object
  field: T

converter toFoo[T](x: T): Foo[T] = Foo[T](field: x)

echo Foo(3)
# works: echo Foo[auto](3)
