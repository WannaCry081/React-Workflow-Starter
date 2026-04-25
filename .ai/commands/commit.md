# Commit

Create atomic commits from active changes with Conventional Commits.
Follow `.ai/commands/_shared.md`.

## Inputs

- `baseRef` (optional, default: `HEAD`)
- `maxCommits` (optional, default: `5`)
- `includeUntracked` (optional, default: `true`)

## Spec

- Source: https://www.conventionalcommits.org/en/v1.0.0/
- Header: `<type>[optional scope][!]: <description>`
- Types: `feat|fix|docs|style|refactor|perf|test|build|ci|chore|revert`
- Breaking change: `!` and/or `BREAKING CHANGE:` footer

## Workflow

1. Read changes: `git status --short`, `git diff --name-status`, `git diff`.
2. Group into atomic concerns (split by hunk when needed).
3. For each group: choose `type/scope/description` per spec.
4. Stage only that group.
5. Commit with Conventional Commit header.
6. Repeat until done or `maxCommits` reached.
7. Print summary: `git log --oneline -n <count>`.

## Rules

- Do not mix unrelated concerns.
- Keep `style`, refactor, config/deps (`build|ci|chore`) separate.
- Subject: imperative, concise, no trailing period.
- Use body/footer only when needed.
- If grouping intent is unclear, ask one blocking question.

## Output

- Created commits in order: message + grouped files
- Remaining uncommitted files (if any)

## Success

- All commits are Conventional Commits 1.0.0 compliant.
- Commits are atomic and independently reversible.
