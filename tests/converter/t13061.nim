discard """
action: reject
errormsg: "type mismatch"
"""

# bug #13061

type
  A = distinct int

# If two converters do the same thing after a match is found the rest are not typechecked
converter toA(a:A):int = (int)a
converter anotherToA(a:A):int = "lol"

# If the wrong one comes first it is typechecked and throws a compiler error
# converter anotherToA(a:A):int = "lol"
# converter toA(a:A):int = (int)a
