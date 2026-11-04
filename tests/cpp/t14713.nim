discard """
output: '''
completed with error
'''
"""

# bug #14713

import asyncdispatch

proc raises(fail: bool) {.async.} =
  if fail:
    raise newException(Exception, "something bad happened")

proc reraises() {.async.} =
  try:
    await raises(true)
  except Exception as e:
    raise e

proc catches() =
  try:
    asyncCheck reraises()
  except:
    echo "completed with error"

catches()
