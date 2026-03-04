Perform a thorough code review of: $ARGUMENTS

If no files or PR are specified, review all staged and unstaged changes in the current git repository (use `git diff` and `git diff --cached`). If a PR number is given, fetch the diff with `gh pr diff`.

## Review Process

1. Read all code under review carefully before commenting
2. Identify the purpose and intent of the changes
3. Scan for automated issues: hardcoded credentials, TODO/FIXME/HACK comments, overly long files (>500 lines) or functions (>50 lines), commented-out code
4. Review systematically using the checklist below
5. Classify each finding by severity
6. Format output using the structure in "Output Format"

## Severity Classification

| Level | Label | Description |
|-------|-------|-------------|
| CRITICAL | Must fix before merge | Security vulnerabilities, data loss, crashes |
| HIGH | Should fix | Bugs, significant design issues, race conditions |
| MEDIUM | Recommended | Maintainability, minor bugs, test gaps |
| LOW | Suggestions | Style, minor improvements, documentation |
| POSITIVE | Good practices | Clean patterns, good test coverage, clear naming |

## Output Format

```
## Code Review Summary

**Files Reviewed**: [list files]
**Overall Assessment**: [APPROVE / REQUEST CHANGES / NEEDS DISCUSSION]

### Critical Issues (must fix)
- `filename:line` - [Issue description and fix suggestion]

### High Priority
- `filename:line` - [Issue description]

### Medium Priority
- `filename:line` - [Issue description]

### Suggestions
- `filename:line` - [Optional improvement]

### Positive Notes
- Good use of [pattern/practice] in `filename`

### Questions
- [Any clarifying questions about intent]
```

## Review Checklist

### Functionality & Correctness
- Does the code accomplish its stated purpose?
- Are edge cases handled (null, empty, boundary values)?
- Are error conditions handled appropriately?
- Are there logical errors or off-by-one bugs?
- Does it handle concurrent access correctly (if applicable)?

### Security
- Are all external inputs validated and sanitized?
- Are queries parameterized (no SQL/command injection)?
- Are permissions checked correctly?
- Any hardcoded credentials, API keys, or secrets?
- Is sensitive data logged, returned in errors, or exposed?

### Error Handling
- Are exceptions caught at appropriate levels?
- Are errors logged with sufficient context?
- Are resources cleaned up in error paths?
- Is there a catch-all that silently swallows exceptions?

### Performance
- Are there N+1 query patterns?
- Are there unnecessary loops or repeated computations?
- Are large collections loaded when only a subset is needed?
- Are database connections/file handles properly disposed?
- Are there blocking calls that should be async?

### Code Quality
- Are names descriptive and consistent?
- Are functions/methods focused (single responsibility)?
- Is there duplicated code that should be extracted?
- Are magic numbers/strings replaced with constants?
- Is there dead code or commented-out code?

### Testing
- Are there unit tests for new functionality?
- Do tests cover edge cases and error paths?
- Are tests testing behavior, not implementation?
- Is test coverage adequate for the risk level?

### Design & Architecture
- Does it follow existing patterns in the codebase?
- Is the coupling between components appropriate?
- Are abstractions at the right level (not over/under-engineered)?

## Language-Specific Concerns

Apply these checks based on the language detected:

**Python**: mutable default arguments, bare excepts, f-string SQL, pickle with untrusted data, missing context managers, `== None` instead of `is None`, modifying list while iterating, string concatenation in loops.

**C#**: undisposed IDisposable, async void, unawaited async calls, `.Result` deadlocks, `throw ex` losing stack trace, BinaryFormatter deserialization, path traversal.

**TypeScript/Angular**: `any` types, non-null assertions hiding bugs, innerHTML XSS, unsubscribed Observables, nested subscriptions, function calls in templates, mutating @Input properties.

## Review Guidelines

- **Always flag**: Security issues, bugs, crashes, data corruption risks
- **Flag with context**: Design concerns, performance issues (explain impact)
- **Suggest, don't demand**: Style preferences, minor refactoring
- **Skip**: Trivial formatting if a linter handles it
- If unsure about intent, ask rather than assume
- Include code examples in suggestions where helpful
- Acknowledge positive patterns
