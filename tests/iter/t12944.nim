discard """
output: '''
c=1
c=2
c=3
d=4
d=5
d=6
'''
"""

# bug #12944

# Proc that creates an iterator
proc test2(a: seq[int]): iterator: int =
  iterator itseq: int {.closure.} =
    for i in a:
      yield i

  return itseq


let foo = test2(@[1, 2, 3])

# Iterates
for c in foo():
  echo "c=", c

# Does not iterate
for d in test2(@[4, 5, 6])():
  echo "d=", d

# Does not compile because does not call the iterator
#for c in test1(@[4, 5, 6]):
#  echo "c=", c
