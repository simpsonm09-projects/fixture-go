# Exceptions

One row per rule this repository cannot meet yet. The reason and the revisit date
are required. The shared `standard` job reads this file.

| Rule | Reason | Revisit |
| --- | --- | --- |
| `C5.1` | The audit snapshot's median pull request run was 73 s. After this change the two pull request runs took 68 s with a cold toolchain and cache, then 51 s warm, measured from the first job starting to the last required check finishing. The required work is spread across `fmt`, the shared `lint`, `aislop`, `security` and `coverage` jobs, and the Go `test` job, so the wall time tracks runner start-up. The Go build cache is restored on the pull request path; the next step is to re-measure the median over 20 runs and shard the coverage job, which reruns the suite. | 2027-02-28 |
| `C7.4` | `scripts/coverage.mjs`, `scripts/coverprofile-to-lcov.mjs`, `scripts/prune.mjs` and `scripts/agent-files.mjs` are still `.mjs` on Node. The Go application has no JavaScript or TypeScript sources, so the repository keeps the Go toolchain behind the core recipe names and runs the helpers on the pinned Node until they port to Bun TypeScript. | 2027-05-31 |
