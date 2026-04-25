# Bug

Generate a structured bug report file for a known or suspected issue.
Follow `.ai/commands/_shared.md`.

## Inputs

- `bugTitle`: short title describing the bug
- `bugDescription`: what the user observed or what is broken
- `affectedArea` (optional): component, route, feature, or module where the bug appears
- `stepsToReproduce` (optional): steps that trigger the bug
- `expectedBehavior` (optional): what should happen instead

## Workflow

1. Ask the user to describe the bug if `bugDescription` is missing. Ask only what is blocking.
2. Clarify affected area and reproduction steps if not provided and not inferrable.
3. Analyze the description to identify:
   - What is broken (symptom)
   - Why it is breaking (probable root cause)
   - Which files are most likely the root cause
4. Ensure `docs/tasks/todo/` exists.
5. Assign a sequential bug number by counting existing files in `docs/tasks/todo/` that match the `*-bug.md` pattern (start at 1 if none exist).
6. Slugify the bug title to kebab-case for the filename.
7. Save to `docs/tasks/todo/<number>-<bug-title>-bug.md` using `.ai/references/bug-template.md`.

## Output

- One bug report markdown file
- Clear root cause analysis
- Identified files responsible for the issue
- Actionable fix checklist

## Success Criteria

- Bug is clearly described with symptom and cause separated.
- Root cause files are listed with a brief reason for each.
- Fix checklist is ordered and executable.
- File is saved at the correct path and follows naming format.
