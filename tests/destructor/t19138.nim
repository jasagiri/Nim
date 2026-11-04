discard """
output: '''
Destroying Socket
Destroying AsyncSocket
'''
"""

# bug #19138

type
  SocketObj = object

  Socket = ref SocketObj

  AsyncSocketObj = distinct SocketObj

  AsyncSocket = ref AsyncSocketObj

proc `=destroy`(s: var SocketObj) =
  echo "Destroying Socket"

proc `=destroy`(s: var AsyncSocketObj) =
  echo "Destroying AsyncSocket"

proc newSocket(): Socket = Socket()
proc newAsyncSocket(): AsyncSocket = AsyncSocket(newSocket())

proc main() =
  var x = newSocket()
  var y = newAsyncSocket()

  x = nil
  y = nil

  GC_fullCollect()

main()
