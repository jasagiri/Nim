## Utilities for composing lazy iterator pipelines.
##
## `map` and `filter` are templates that expand to inline iterators. This keeps
## pipeline stages in the caller and avoids a closure iterator call for every
## yielded value. Use `asClosure` when an iterator must be stored or returned;
## it introduces one closure iterator around the completed pipeline.

template map*[T; U](source: iterable[T], transform: proc (value: T): U): untyped =
  ## Lazily applies `transform` to each value in `source`.
  iterator mapped(): U {.gensym.} =
    for value in source:
      yield transform(value)
  mapped()

template filter*[T](source: iterable[T], predicate: proc (value: T): bool): untyped =
  ## Lazily yields values from `source` for which `predicate` is true.
  iterator filtered(): T {.gensym.} =
    for value in source:
      if predicate(value):
        yield value
  filtered()

template apply*[T](source: iterable[var T], operation: proc (value: var T)) =
  ## Applies a mutation to each element of a mutable iterator source.
  ##
  ## Unlike `map` and `filter`, `apply` is a terminal operation: it mutates
  ## the values yielded by `source` and does not produce another iterator.
  for value in source:
    operation(value)

template asClosure*[T](source: iterable[T]): untyped =
  ## Wraps an inline iterator pipeline in one closure iterator.
  ##
  ## This is useful when the resulting iterator must escape its current scope,
  ## for example as a procedure result. Prefer keeping intermediate stages
  ## inline and applying `asClosure` once at that boundary.
  iterator escaped(): T {.closure, gensym.} =
    for value in source:
      yield value
  escaped
