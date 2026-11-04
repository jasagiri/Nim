discard """
output: '''
1 -> pwned
2 -> pwned
3 -> pwned
4 -> pwned
5 -> pwned
6 -> pwned
7 -> pwned
8 -> pwned
9 -> pwned
10 -> pwned
11 -> pwned
12 -> pwned
13 -> pwned
14 -> pwned
15 -> pwned
16 -> pwned
17 -> pwned
18 -> pwned
19 -> pwned
20 -> pwned
'''
"""

# bug #25096

template pwnEcho*{echo(x)}(x: varargs[typed]) =
  {.noRewrite.}: echo(x & " -> pwned")

#const n = 0    # works fine.
let n = 0       # bug!
#var n = 0      # bug!


if n != 1 and n != 1 and n != 1 and n != 1 and n != 1 and n != 1 and n != 1 and n != 1 and n != 1 and n != 1 and n != 1 and n != 1 and n != 1:
  echo "1"
  echo "2"
  echo "3"
  echo "4"
  echo "5"
  echo "6"
  echo "7"
  echo "8"
  echo "9"
  echo "10"
if n != 1 and n != 1 and n != 1 and n != 1 and n != 1 and n != 1 and n != 1 and n != 1 and n != 1 and n != 1 and n != 1 and n != 1 and n != 1:
  echo "11"
  echo "12"
  echo "13"
  echo "14"
  echo "15"
  echo "16"
  echo "17"
  echo "18"
  echo "19"
  echo "20"
