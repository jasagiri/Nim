discard """
output: '''
123 3
'''
"""

# bug #22239

func number(lit: string): string =
  for b in lit:
    result.add:
      if b in '0'..'9': b
      elif b == '_': continue
      else: raise newException(ValueError, "not a valid digit")

let s = number "1_2_3"
echo s, " ", s.len
