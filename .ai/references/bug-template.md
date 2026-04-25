# Bug Template

# <Bug Title>

## Summary

<1-2 sentences describing what is broken and where it is observed>

## Symptom

<What the user sees or experiences — error message, incorrect behavior, crash, etc.>

## Root Cause

<Why this is happening — the underlying reason, not just the surface error. Include the mechanism if known (e.g., race condition, wrong variable scope, missing null check, incorrect API response handling).>

## Root Cause Files

| File | Reason |
|------|--------|
| `<file path>` | <why this file is responsible> |
| `<file path>` | <why this file is responsible> |

## Steps to Reproduce

1. <Step>
2. <Step>
3. <Step>

## Expected Behavior

<What should happen instead>

## Actual Behavior

<What currently happens>

## Fix Checklist

- [ ] <Locate the specific line or block causing the issue>
- [ ] <Apply the fix>
- [ ] <Add a guard or test to prevent regression>
- [ ] <Verify fix does not break adjacent behavior>

## Affected Area

- Component / Route / Feature: `<name>`
- Severity: `low | medium | high | critical`
- Environment: `<local | staging | production | all>`

## Notes

<Any additional context, workarounds, related issues, or links>

## Done Criteria

- [ ] Bug no longer reproduces following steps above
- [ ] No regressions introduced
- [ ] Fix checklist completed
