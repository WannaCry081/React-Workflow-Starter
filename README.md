# React Workflow Starter

A lightweight, cross-tool workflow starter for shipping React work with consistent agent behavior and a built-in `code-review-graph` knowledge graph.

This repository is designed to work across Claude, Codex, OpenCode, and Copilot with a shared command lifecycle:

1. Ask
2. Plan
3. Todo
4. Implement
5. Test
6. Commit

## What This Repo Provides

- Shared instruction baseline in `AGENTS.md`
- Canonical command definitions in `.ai/commands`
- Task and planning templates in `.ai/references`
- Task lifecycle folders in `docs/tasks/*`
- Compatibility wrappers for multiple coding agents
- `code-review-graph` for graph-first code exploration, impact analysis, and review context

## Code Review Graph

This repository is configured to use `code-review-graph` as the default structural exploration layer.

Official site: https://code-review-graph.com/

- Agents should use the graph before broad Grep/Glob/Read passes when exploring the codebase.
- The graph is preferred for callers, dependents, test coverage, affected flows, and review context.
- Broad file scanning is the fallback path when graph data is insufficient.

Basic CLI usage:

```bash
code-review-graph build
code-review-graph update
```

- Use `code-review-graph build` for the initial graph build or a full rebuild.
- Use `code-review-graph update` to refresh graph data after code changes.

Typical graph-first workflow:

1. Use `semantic_search_nodes` or `query_graph` to find the relevant code.
2. Use `get_impact_radius` or `get_affected_flows` to understand blast radius.
3. Use `detect_changes` and `get_review_context` during review.
4. Use `query_graph` with `tests_for` to inspect nearby coverage.

## Repository Layout

```text
.
├─ AGENTS.md
├─ CLAUDE.md
├─ INSTRUCTIONS.md
├─ .ai/
│  ├─ commands/
│  │  ├─ ask.md
│  │  ├─ plan.md
│  │  ├─ todo.md
│  │  ├─ implement.md
│  │  ├─ test.md
│  │  └─ commit.md
│  └─ references/
│     ├─ plan-template.md
│     └─ todo-template.md
└─ docs/
	└─ tasks/
		├─ todo/
		├─ in-progress/
		├─ done/
		└─ plan/
```

## Workflow At A Glance

### 1) Ask

Refine ambiguous requests into minimal, clear prompts.

### 2) Plan

Generate one implementation-ready plan file:

- `docs/tasks/plan/<number>-<plan-name>.md`

### 3) Todo

Generate one executable checklist:

- `docs/tasks/todo/<number>-<todo-name>.md`

### 4) Implement

Execute a single todo file end-to-end and move it through lifecycle folders.

### 5) Test

Generate and run tests from task acceptance criteria.

Expected structure:

- `tests/unit` (Vitest)
- `tests/e2e` (Playwright)

### 6) Commit

Create atomic Conventional Commits from active changes.

## Task Lifecycle

Task files move through these states:

1. `docs/tasks/todo`
2. `docs/tasks/in-progress`
3. `docs/tasks/done`

Plans live in:

- `docs/tasks/plan`

## TDD Mode

Command behavior checks for:

- `.ai/config/workflow-mode.md`

Supported toggle:

- `TDD_MODE: on` -> test-first for new behavior
- `TDD_MODE: off` -> implement-first, tests optional unless requested

If the file is missing, commands default to `TDD_MODE: off`.

You can create this file when needed:

```md
TDD_MODE: off
```

## Source Of Truth

When behavior appears to conflict, resolve in this order:

1. `.ai/commands/*.md`
2. `AGENTS.md`
3. `.github/copilot-instructions.md` (Copilot-specific)
4. `INSTRUCTIONS.md` (repo workflow summary)

## Quality Gates

Each workflow phase should produce outputs that are:

- Executable
- Concise
- Scope-bounded
- Validated (what ran, what passed, what was skipped)

## Contributing Notes

- Keep shared workflow rules in `AGENTS.md`.
- Keep Copilot-only behavior in `.github/copilot-instructions.md`.
- Keep command-specific logic in `.ai/commands`.
- Avoid duplicating workflow definitions across tool folders unless required by platform format.

## Related Docs

- `INSTRUCTIONS.md` for operational workflow details in this starter
- `AGENTS.md` for cross-tool standards and stack conventions
