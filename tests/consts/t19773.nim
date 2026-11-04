discard """
output: '''
root
'''
"""

# bug #19773

const s1 = ""
if s1.len == 0 or s1[0] == '/':
  echo "root"
