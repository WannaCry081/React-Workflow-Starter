# Implement

Implement one todo doc end to end with minimal scope.
Follow `.ai/commands/_shared.md`.

## Input

- `todoFile`: path to todo markdown

## Workflow

1. Validate `todoFile` exists and is readable.
2. Move it to `docs/tasks/in-progress/<name>.md`.
3. Read `.ai/config/workflow-mode.md` and resolve `TDD_MODE` (`off` if missing).
4. Execute checklist items in order with no scope expansion.
5. If `TDD_MODE: on`, use test-first for new behavior. If `TDD_MODE: off`, implement first and defer new tests unless explicitly requested or required by the todo file.
6. Run available project checks: `lint`, `build`, then tests when required by mode or task definition.
7. Mark completed checklist items.
8. Move file to `docs/tasks/done/<name>.md`.

## Output

- Implemented code changes
- Verification summary (command + pass/fail)
- Final done-file path
- Brief summary

## Success Criteria

- All todo items are complete.
- Required checks pass.
- Task file is in done.
