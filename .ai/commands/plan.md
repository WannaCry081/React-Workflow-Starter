# Plan

Create an implementation-ready plan from a user request.
Follow `.ai/commands/_shared.md`.

## Inputs

- `request`: feature or problem statement
- `scopeConstraints` (optional)
- `technicalConstraints` (optional)
- `successDefinition` (optional)

## Workflow

1. Parse request into objective, users, outcome, constraints, risks, and dependencies.
2. Clarify only missing blocking details.
3. Read `.ai/config/workflow-mode.md` and resolve `TDD_MODE` (`off` if missing).
4. Draft plan using `.ai/references/plan-template.md`.
5. In the plan, state testing strategy from mode: test-first when `TDD_MODE: on`, implementation-first with deferred tests when `TDD_MODE: off` unless user requests immediate tests.
6. Run a quality pass for clarity and testability.
7. Save to `docs/tasks/plan/<number>-<plan-name>.md`.

## Output

- One markdown plan file following the template
- Clear scope and ordered implementation steps
- Testable acceptance criteria

## Success Criteria

- Plan is concise and unambiguous.
- Steps are executable.
- Acceptance criteria are measurable.
