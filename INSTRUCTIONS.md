# Workflow Instructions

This repository is a workflow starter for agent-driven delivery. The core loop is:

1. Ask (tighten request)
2. Plan (define implementation)
3. Todo (create execution checklist)
4. Implement (ship checklist items)
5. Test (generate/run tests)
6. Commit (atomic Conventional Commits)

## Code Review Graph

This repository uses `code-review-graph` as part of the default agent workflow.

Official site: https://code-review-graph.com/

- Use the graph before broad file scanning when exploring code, tracing impact, or reviewing changes.
- Prefer graph tools for structural context such as callers, dependents, affected flows, and test coverage.
- Fall back to Grep/Glob/Read only when the graph does not cover the question.

Basic CLI usage:

```bash
code-review-graph build
code-review-graph update
```

- Run `code-review-graph build` to create or rebuild the repository graph.
- Run `code-review-graph update` to refresh graph data after local code changes.

Common graph-first use cases:

- `semantic_search_nodes` or `query_graph` for exploration
- `get_impact_radius` for blast-radius checks
- `detect_changes` and `get_review_context` for code review
- `get_affected_flows` and `query_graph` with `tests_for` for validation context

## Source Of Truth

- Shared rules for all agents: `AGENTS.md`
- Copilot-specific behavior: `.github/copilot-instructions.md`
- Canonical command contracts: `.ai/commands/*.md`
- Output templates: `.ai/references/*.md`

When in doubt, follow the command files in `.ai/commands`.

The detailed `code-review-graph` guidance also lives in `AGENTS.md` and `CLAUDE.md` so the supported agents in this starter follow the same graph-first convention.

## Task File Lifecycle

Task markdown files move through these folders:

- `docs/tasks/todo/` - ready to execute
- `docs/tasks/in-progress/` - currently being worked
- `docs/tasks/done/` - completed

Planned work should be stored in:

- `docs/tasks/plan/` (created by the plan workflow)

Current repo state may not include files in every folder yet; create them through the command workflows as needed.

## Workflow Toggle (TDD Mode)

Commands read `.ai/config/workflow-mode.md` for `TDD_MODE`.

- `TDD_MODE: on` - test-first for new behavior
- `TDD_MODE: off` - implementation-first, tests optional unless requested

If `.ai/config/workflow-mode.md` is missing, default behavior is `TDD_MODE: off`.

## Command Behavior

### 1) Ask

File: `.ai/commands/ask.md`

Use for token-efficient request refinement before planning or coding.

- Keep responses concise and direct
- Ask only blocking questions
- Avoid unnecessary tool calls

### 2) Plan

File: `.ai/commands/plan.md`

Generates one implementation-ready plan file using `.ai/references/plan-template.md`.

- Output path: `docs/tasks/plan/<number>-<plan-name>.md`
- Must include: scope, ordered steps, testable acceptance criteria

### 3) Todo

File: `.ai/commands/todo.md`

Generates one execution checklist using `.ai/references/todo-template.md`.

- Output path: `docs/tasks/todo/<number>-<todo-name>.md`
- Must include: files to modify, dependencies, checklist, validation, done criteria

### 4) Implement

File: `.ai/commands/implement.md`

Executes a single todo file end-to-end.

- Moves todo file to `docs/tasks/in-progress/`
- Completes checklist in order with minimal scope expansion
- Runs available checks (`lint`, `build`, tests when required)
- Moves file to `docs/tasks/done/` after completion

### 5) Test

File: `.ai/commands/test.md`

Generates and runs tests from a task file.

- Expects test structure:
  - `tests/unit/` (Vitest)
  - `tests/e2e/` (Playwright)
- Moves selected task through `todo -> in-progress -> done` when successful
- Returns pass/fail report and skipped checks

### 6) Commit

File: `.ai/commands/commit.md`

Creates atomic Conventional Commits from active changes.

- Commit format: `<type>[scope]: <description>`
- Keep unrelated changes in separate commits
- Supported types include: `feat`, `fix`, `docs`, `refactor`, `test`, `chore`, etc.

## Recommended End-To-End Run

1. Start with `ask` only if request is ambiguous.
2. Create plan with `plan`.
3. Create execution checklist with `todo`.
4. Execute with `implement`.
5. Validate with `test` (scope `unit`, `e2e`, or `all`).
6. Finalize with `commit`.

## Quality Gates

Every phase should satisfy:

- Steps are executable and unambiguous
- Output is concise and clear
- Scope stays minimal (no unrequested expansion)
- Validation is reported (what ran, what passed, what was skipped)

## Notes For Contributors

- Keep workflow conventions in command files, not duplicated across tools.
- Prefer updating `AGENTS.md` for shared cross-tool rules.
- Keep `CLAUDE.md` as a thin pointer to `AGENTS.md`.
- Use `.github/copilot-instructions.md` only for Copilot-specific behavior.
