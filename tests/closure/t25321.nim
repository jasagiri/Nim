discard """
output: '''
arr defined: @[0, 0, 0]
p1; arr = @[1, 0, 0]
p2; arr = @[1, 2, 0]
p3; arr = @[1, 2, 3]
'''
"""

# bug #25321

var p1: proc() {.closure.}
var p2: proc() {.closure.}
var p3: proc() {.closure.}

proc makeClosure(): proc(i: int) =
    var arr = @[0,0,0]
    echo "arr defined: " & $arr
    var p = proc(i: int) =
        if i == 0:
            p1 = proc() =
                arr[0] = 1
                echo "p1; arr = " & $arr
        elif i == 1:
            p2 = proc() =
                arr[1] = 2
                echo "p2; arr = " & $arr
            p3 = proc() =
                arr[2] = 3
                echo "p3; arr = " & $arr
    return p

var dostuff = makeClosure()
dostuff(0) # define p1
dostuff(1) # define p2, p3
p1()
p2()
p3() # causes segfault if p3 is assigned in 'elif' block
