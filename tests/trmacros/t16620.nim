discard """
output: '''
1
11
'''
"""

# bug #16620

# test 1
# ------

proc get(x: int): int = x

template t{get(a)}(a: int): int =
  {.noRewrite.}:
    get(a) + 1

echo get(0)


# test 2
# ------

var x: int

template asgn{a = b}(a: int{lvalue}, b: int) =
  {.noRewrite.}:
    a = b + 1

x = 10
echo x
