discard """
output: '''
s1 = @[0]
s2 = @[0]
s1 = @[0, 1]
s2 = @[0]
'''
"""

# bug #16312

proc p() =
  var s1 = @[0]
  let s2 = s1  # Works if replacing "let" by "var".
  echo "s1 = ", s1
  echo "s2 = ", s2
  s1.add(1)
  echo "s1 = ", s1
  echo "s2 = ", s2

p()
