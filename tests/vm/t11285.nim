discard """
output: '''
0
1
0
1
'''
"""

# bug #11285

proc unique: int =
  var id {.global.} = 0
  result = id
  id += 1

const x = unique()
const y = unique()

let z = unique()
let w = unique()

echo x
echo y
echo z
echo w
