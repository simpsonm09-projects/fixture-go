# Exceptions

One row per rule this repository cannot meet yet. The reason and the revisit date
are required. The shared `standard` job reads this file.

| Rule | Reason | Revisit |
| --- | --- | --- |
| `C5.1` | The audit snapshot's median pull request run was 73 s. This pull request's run took 68 s from the first job starting to the last required check finishing: the required work is spread across `fmt`, the shared `lint`, `aislop`, `security` and `coverage` jobs, and the Go `test` job, and the wall time is dominated by runner start-up plus the cold toolchain on the first run after a `mise.toml` change. The Go build cache is restored on the pull request path; the next step is to re-measure the median over 20 runs with a warm cache and shard the coverage job, which reruns the suite. | 2027-02-28 |
| `C7.4` | `scripts/coverage.mjs`, `scripts/coverprofile-to-lcov.mjs`, `scripts/prune.mjs` and `scripts/agent-files.mjs` are still `.mjs` on Node. The Go application has no JavaScript or TypeScript sources, so the repository keeps the Go toolchain behind the core recipe names and runs the helpers on the pinned Node until they port to Bun TypeScript. | 2027-05-31 |
