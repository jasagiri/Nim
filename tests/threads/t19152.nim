discard """
output: '''
hello
error: ECONNRESET
Quit
hello
error: ECONNRESET
Quit
'''
"""

# bug #19152

import std/[posix, osproc, selectors, streams]

type ProcEvent = enum
  StdOut, Quit

proc process_notification_test() =
  var selector = newSelector[ProcEvent]()
  var process =
    startProcess("echo", "", ["hello"], nil, {poStdErrToStdOut, poUsePath})
  selector.registerProcess(process.processID, Quit)
  selector.registerHandle(process.outputHandle.int, {Read, Error}, StdOut)
  block selectLoop:
    while true:
      var events = selector.select(-1)
      for ready in events.items:
        let kind = selector.getData ready.fd
        case kind
        of StdOut:
          if Read in ready.events:
            stdout.write process.outputStream.readAll
          if Error in ready.events:
            selector.unregister ready.fd
            if ready.errorCode.int == ECONNRESET:
              echo "error: ECONNRESET"
            else:
              echo "error: " & $ready.errorCode.int
        of Quit:
          echo $kind
          break selectLoop

proc passes =
  process_notification_test()

proc fails =
  var t: Thread[void]
  createThread(t, process_notification_test)
  joinThread t

passes()
fails()
