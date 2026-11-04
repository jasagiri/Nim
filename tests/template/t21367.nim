discard """
nimout: '''
StmtList
    ProcDef
      Sym "foo"
      Empty
      Empty
      FormalParams
        Empty
      Empty
      Empty
      StmtList
        CommentStmt "Some documentation"
        DiscardStmt
          Empty
    TemplateDef
      Sym "bar"
      Empty
      Empty
      FormalParams
        Empty
      Empty
      Empty
      StmtList
        CommentStmt "Some documentation"
        DiscardStmt
          Empty
'''
"""

# bug #21367

import macros

template test(docs) =
  proc foo() =
    docs
    discard

  template bar() = 
    docs
    discard

macro dump(x: typed) =
  echo x.treeRepr

dump:
  test:
    ## Some documentation
