# Test

Generate tests from one task file and run them.
Follow `.ai/commands/_shared.md`.

## Required Structure

```text
tests/
  unit/  # Vitest
  e2e/   # Playwright
```

## Input

- `todoFile?`: file under `docs/tasks/*/*.md`
- `testScope?`: `unit|e2e|all` (default `all`)

If `todoFile` is missing, use the newest `.md` from:

- `docs/tasks/todo/*.md`
- `docs/tasks/in-progress/*.md`
- `docs/tasks/done/*.md`

## Steps

1. Resolve `todoFile`; fail clearly if none found.
2. Normalize task name as `<name>.md`.
3. Move input task to `docs/tasks/todo/<name>.md` (skip if already there).
4. Move task to `docs/tasks/in-progress/<name>.md` before generating tests.
5. Parse scope + acceptance criteria from the in-progress task.
6. Ensure scaffolding exists: Vitest config/script + `tests/unit`; Playwright config/script + `tests/e2e`.
7. Generate tests in `tests/unit` and `tests/e2e`.
8. Run checks (if available): `typecheck` or `build`, then Vitest, then Playwright.
9. On failure, fix generated test/config issues and rerun once.
10. If done, move task to `docs/tasks/done/<name>.md`. If not done, keep it in `docs/tasks/in-progress/<name>.md`.
11. Return report: moved task path(s), created files, pass/fail, skipped checks.

## Output

- Created/updated tests in `tests/unit` and `tests/e2e`
- Task lifecycle result across `docs/tasks/todo`, `docs/tasks/in-progress`, and `docs/tasks/done`
- Status for compile/typecheck/build, Vitest, Playwright
- Skipped checks with reason

## Success

- Uses selected task file.
- Moves task through `todo -> in-progress -> done` when completed.
- Writes unit tests to `tests/unit`.
- Writes e2e tests to `tests/e2e`.
- Runs Vitest and Playwright.
- Build/typecheck passes when a script exists.
