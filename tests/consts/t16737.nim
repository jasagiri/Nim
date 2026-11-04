discard """
output: '''
[0]: false
[1]: false
[2]: false
[3]: false
[4]: false
[5]: false
[6]: false
[7]: false

with constant index:
[7]: false
'''
"""

# bug #16737

type ProcType = proc()

const a: ProcType = proc() = discard
const arr: array[8, ProcType] = [a, a, a, a, a, a, a, a]

for i in 0..<arr.len:
  echo "[", i, "]: ", arr[i].isNil
echo "\nwith constant index:\n[7]: ", arr[7].isNil
