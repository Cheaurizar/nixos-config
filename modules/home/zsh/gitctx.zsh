gitctx() {
  local out="${1:-/tmp/git-context.md}"
  {
    echo "# Git Commit Context"
    echo
    echo "## My motivation"
    echo
    echo '<!-- Describe the why behind these changes -->'
    echo '<!-- Mention if you want one or several commits -->'
    echo
    echo
    echo "---"
    echo
    echo "## Staged files"
    git diff --staged --stat
    echo
    echo "## Staged diff"
    echo '```diff'
    git diff --staged
    echo '```'
    echo
    echo "---"
    echo
    cat <<'PROMPT'
## Instructions

You are helping me write a commit message for the staged changes above. Follow these rules **exactly**.

### Output Format

Every commit message MUST follow this exact structure:

```
<type>(<scope>): <subject>

<body>
```

- `<type>` is mandatory, picked from the allowed list below
- `<scope>` is optional, lowercase, in parentheses — only when it adds clarity
- `<subject>` is a short imperative sentence, lowercase, no trailing period, ≤ 72 chars
- One blank line separates subject and body — mandatory
- `<body>` explains the **what** and **why** (not the how), wrapped at ~72 chars

### Allowed Types

| Type       | When to use                                                          |
|------------|----------------------------------------------------------------------|
| `feat`     | A new feature for the user                                           |
| `fix`      | A bug fix for the user                                               |
| `docs`     | Documentation only (README, comments, JSDoc, etc.)                   |
| `style`    | Formatting, whitespace — no logic change                             |
| `refactor` | Code change that neither fixes a bug nor adds a feature              |
| `test`     | Adding or correcting tests                                           |
| `chore`    | Maintenance: deps bumps, config tweaks, housekeeping                 |
| `perf`     | Performance improvement                                              |
| `build`    | Build system, packaging, bundler config                              |
| `ci`       | CI/CD config (GitHub Actions, GitLab CI, etc.)                       |
| `revert`   | Reverts a previous commit — body MUST reference the reverted hash    |

**Tie-breakers when multiple types could apply:**
- New user-visible behavior → `feat`, even if tests/docs are touched
- Fixes broken behavior → `fix`, even if refactored along the way
- Dependency upgrade for security/maintenance → `chore`
- Dependency upgrade enabling a new feature → `feat`
- Touching `.github/workflows/`, `.gitlab-ci.yml` → `ci`
- Touching build configs, Dockerfile, package.json scripts → `build`

### Scopes (optional)

Include a scope when:
- The project has clearly separated modules and the change is localized to one
- It helps a reader scan the git log faster

Skip the scope when:
- The change spans multiple modules
- The project is small/single-module and a scope would be noise
- You cannot pick a scope clearly more useful than nothing

Format: lowercase, single word or kebab-case (`auth`, `user-profile`, `api`, `db`).

### Subject Rules

1. Imperative mood: "If applied, this commit will ___"
   - OK: `add password reset endpoint`
   - NO: `added password reset endpoint`
   - NO: `adds password reset endpoint`
2. Lowercase first letter after the colon
3. No trailing period
4. ≤ 72 characters total (including type, scope, colon)
5. Be specific — `fix: bug` is useless; `fix: prevent null deref in user lookup` is useful

### Body Rules (mandatory)

The body is **always required**, even for small commits. It must:
- Be separated from the subject by **one blank line**
- Explain the **what** changed and **why** — not the implementation details
- Use full sentences with proper punctuation and capitalization
- Wrap lines at roughly 72 characters
- Reference issues/PRs at the end if relevant (`Closes #42`)

For trivial commits where there is genuinely nothing to add, still write at least one sentence explaining the motivation or context.

### Breaking Changes

If the commit introduces a breaking change:
- Add `!` after the type/scope: `feat(api)!: rename /users endpoint to /accounts`
- AND include a `BREAKING CHANGE:` footer in the body explaining the migration path

### Workflow

1. Read the staged diff above
2. Identify the primary intent → map it to one of the 11 allowed types
3. Decide on a scope (skip when in doubt)
4. Draft the subject — imperative, lowercase, ≤ 72 chars, specific
5. Write the body — what and why, never how. Wrap at 72 chars.
6. Output the full message inside a code block so I can copy it directly
7. **If the diff mixes unrelated concerns, propose a split into multiple commits**

### Anti-patterns to Reject

Flag and rewrite if you see these problems:
- Vague subjects (`update stuff`, `fix bug`, `wip`, `misc changes`)
- Past tense or gerund (`added X`, `adding X`)
- Missing body — never accept a one-line commit
- Wrong type (e.g. `feat` for a pure refactor, `fix` for a new feature)
- Sentence-case or title-case subjects after the colon

Output the commit message(s) only, in code blocks. No preamble, no explanation of the rules.
PROMPT
  } > "$out"
  nvim "+/Describe the why" "$out"
  echo "→ $out"
}
