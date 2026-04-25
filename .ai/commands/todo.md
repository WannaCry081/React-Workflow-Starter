# Todo

Generate an implementation-ready TODO file.
Follow `.ai/commands/_shared.md`.

## Inputs

- `todoTitle`: short title
- `request`: feature, bug, or change
- `targetFiles` (optional)
- `dependencies` (optional)
- `constraints` (optional)

## Workflow

1. Parse request into objective, scope, deliverable, and constraints.
2. Identify impact: files to modify and dependencies to add or update.
3. Build an ordered checklist from setup through validation.
4. Read `.ai/config/workflow-mode.md` and resolve `TDD_MODE` (`off` if missing).
5. Add verification steps for behavior, regression, and lint/test/build when relevant.
6. If `TDD_MODE: on`, include explicit test-first checklist items. If `TDD_MODE: off`, mark new tests as optional/deferred unless requested.
7. Run a quality pass for clarity and executability.
8. Save to `docs/tasks/todo/<number>-<todo-name>.md` using `.ai/references/todo-template.md`.

## Output

- One TODO markdown file
- Explicit file and dependency impact
- Ordered checklist and validation section

## Success Criteria

- Output is concise and clear.
- Steps are executable.
- Validation and done criteria are present.
