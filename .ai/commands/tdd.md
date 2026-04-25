# TDD

Toggle test-first workflow mode.
Follow `.ai/commands/_shared.md`.

## Input

- `mode`: `on|off`

Reject any input other than exactly one argument: `on` or `off`.

## Steps

1. Parse `mode` from the command input.
2. If `mode` is not exactly `on` or `off`, stop and report: `Usage: /tdd on` or `Usage: /tdd off`.
3. Ensure `.ai/config/` exists.
4. Replace `.ai/config/workflow-mode.md` with:

```text
TDD_MODE: <mode>
```

5. Report the resulting mode and how it affects future planning and implementation.

## Output

- Updated `.ai/config/workflow-mode.md`
- Current mode: `TDD_MODE: on|off`

## Success

- `/tdd on` writes `TDD_MODE: on`.
- `/tdd off` writes `TDD_MODE: off`.
- Invalid input does not change the config file.
