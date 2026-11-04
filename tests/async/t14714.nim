discard """
output: '''
Not implemented
'''
"""

# bug #14714

import asyncdispatch

proc test() {.gcsafe, async.} =
  try:
    await sleepAsync(1000)
    return
  except CatchableError as err:
    echo err.msg

var mrRuntime = true
try:
  if mrRuntime:
    raise newException(CatchableError, "Not implemented")
except CatchableError as err:
  echo err.msg
  waitFor test() # if this is in the `except` block it crashes - otherwise (unindent) it's fine
