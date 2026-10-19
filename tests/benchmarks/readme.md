# Collection of benchmarks

In future work, benchmarks can be added to CI, but for now we provide benchmarks that can be run locally.

See RFC: https://github.com/timotheecour/Nim/issues/425

`iterutils.nim` compares a hand-written loop with inline and closure iterator
pipelines. Run it locally with `nim c -d:danger -r
tests/benchmarks/iterutils.nim`; timings are informational and are not CI
thresholds.
