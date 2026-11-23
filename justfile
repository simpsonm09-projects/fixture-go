# Cross-platform task runner for humans and agents. `just --list` shows every
# recipe. Keep each recipe a thin call to a portable tool or a script under
# scripts/. See https://github.com/simpsonm09-projects/repo-standard/blob/main/docs/task-runner.md
set windows-shell := ["powershell.exe", "-NoLogo", "-NoProfile", "-Command"]

# List the recipes.
default:
    @just --list

# Install the pinned tools.
install:
    mise install

# Format the Go sources with gofmt.
fmt:
    mise exec -- golangci-lint fmt

# Fail when a Go source is not gofmt-formatted.
fmt-check:
    mise exec -- golangci-lint fmt --diff

# Run every linter over the tracked files.
lint:
    mise exec -- flint run --full

# Fix what the linters can fix.
lint-fix:
    mise exec -- flint run --fix

# Run the AI-slop gate.
aislop:
    npx --yes aislop@0.16.1 ci

# Run the test suite. `mise run test` holds the repository test command.
test:
    mise run test

# Run the tests and write an lcov report to coverage/lcov.info.
coverage:
    mise run coverage

# Regenerate docs/openapi.json from the handler annotations.
spec:
    mise run spec

# Fail when the generated API document differs from the code.
spec-check:
    just spec
    git diff --exit-code -- docs/openapi.json

# Build and serve the API on http://127.0.0.1:3000.
serve:
    mise run serve

# Everything CI requires.
check: fmt-check lint test spec-check

# Historical alias for `check`, kept for the support template.
verify: check

# Install the guarded git hook.
hooks:
    git config --local core.hooksPath .githooks

# Check the .agents/skills tree and its .claude/skills links.
agent-files:
    mise exec -- node scripts/agent-files.mjs

# Prune remote-tracking refs and delete local branches merged into main.
prune:
    node scripts/prune.mjs
