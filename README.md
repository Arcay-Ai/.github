# .github (organization defaults)

Files here apply to every Arcay Studio repository that doesn't define its own:

- `profile/README.md` is the public organization page
- `PULL_REQUEST_TEMPLATE.md`, `CONTRIBUTING.md`, `SECURITY.md`, `CODE_OF_CONDUCT.md` are default community files
- `ISSUE_TEMPLATE/config.yml` points people to Linear instead of GitHub Issues
- `.github/workflows/linear-check.yml` is a reusable workflow that checks for an ARC key
- `workflow-templates/` adds "Arcay Studio CI" to every repo's Actions > New workflow page

This repository must be **public** for the defaults to apply, so never put anything confidential here.
