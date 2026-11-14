# .github (organization defaults)

Files here apply to every Arcay AI repository that doesn't define its own:

- `profile/README.md` is the public organization page
- `PULL_REQUEST_TEMPLATE.md`, `CONTRIBUTING.md`, `SECURITY.md`, `CODE_OF_CONDUCT.md` are default community files
- `ISSUE_TEMPLATE/config.yml` points people to Linear instead of GitHub Issues
- `.github/workflows/linear-check.yml` is a reusable workflow that checks for a Linear issue key
- `.github/workflows/claude-review.yml` is a reusable workflow: Claude reviews a pull request when someone comments `@claude review`
- `skills/arcay-review/SKILL.md` is the review guide that workflow follows, also usable locally as a Claude Code skill
- `workflow-templates/` adds "Arcay AI CI" and "Claude review" to every repo's Actions > New workflow page

This repository must be **public** for the defaults to apply, so never put anything confidential here.

## Claude review

Comment on a pull request:
- `@claude review`: a quick review (Sonnet).
- `@claude review deep`: a deep one (Opus).
- `@claude <question>`: asks about the change.

Changes that touch auth, the database, migrations, infra, CI workflows or secrets, or that are large, get the deep
review on their own.

**What Claude reads:**
- the diff and the code around it;
- the PR's Linear issue (What, Done when, status, blockers, latest comments);
- the repo's `CLAUDE.md` and `REVIEW.md`;
- its own last review.

**What it posts:** one comment, updated in place on every run, with:
- a verdict;
- blockers and issues (`path:line`, the problem, the fix);
- a Done-when checklist;
- merge risk;
- suggestions from experience (simpler designs, better patterns, pitfalls), none of them blocking;
- questions for the author.

It never approves or blocks.

**Who and what it runs on:**
- Only org members and collaborators can ask, and pull requests from forks are skipped.
- Claude gets the context as files and read-only tools; the workflow posts the comment.
- It runs on the Claude subscription behind `CLAUDE_CODE_OAUTH_TOKEN`, and on GitHub Actions minutes.

**Add it to a repo:**
1. Actions > New workflow > "Claude review". This adds `.github/workflows/claude-review.yml`, which calls the
   reusable workflow here. Merge it to the default branch.
2. Set the secrets: run `scripts/set-claude-secrets.sh <repo>`, or run it with no arguments for every repo.
   - `CLAUDE_CODE_OAUTH_TOKEN` comes from `claude setup-token`.
   - `LINEAR_API_KEY` is a Linear personal API key with read access.

   GitHub Free doesn't share organization secrets with private repos, so each repo holds its own copy. Run the script
   again after rotating a token.
3. Optional: add a `REVIEW.md` at the repo root with what reviews in that repo must check, such as client data,
   contracts or deploy order.

**Locally:** copy `skills/arcay-review` into `~/.claude/skills/` and run `/arcay-review 123` in the repo. It reads
the PR with `gh` and the issue with the Linear connector.

