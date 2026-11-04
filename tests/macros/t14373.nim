discard """
output: '''
foo
bar
baz
bam
bat
'''
"""

# bug #14373

import macros

type Container = object
  n: NimNode

proc addBam(n: NimNode) =
  n.add newCall("echo", newLit("bam"))

var z {.compileTime.}: NimNode

macro test() =
  #var a = newStmtList()          # use this instead and the bug goes away
  var a = parseStmt("discard")
  let c = Container(n:a)
  let x = a
  z = a
  a.add newCall("echo", newLit("foo"))    # added
  c.n.add newCall("echo", newLit("bar"))  # not added!
  x.add newCall("echo", newLit("baz"))    # added
  x.addBam()                              # added
  z.add newCall("echo", newLit("bat"))    # not added!
  a

test()
