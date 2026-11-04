discard """
output: '''
(x: 4, y: -10)
(x: 4, y: -10)
'''
"""

# bug #18342

block correct:
  var point = (x: 10, y: 4)

  point = (x: point.y, y: - point.x)
  echo point

block wrong:
  var point = (x: 10, y: 4)

  point = 
    if true: (x: point.y, y: - point.x)
    else: point

  echo point
