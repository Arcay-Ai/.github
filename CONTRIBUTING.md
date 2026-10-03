# Contributing at Arcay AI

## 1. Start from a Linear issue
Every change starts with a Linear issue (for example `ALS-59`). If there isn't one, create it first.

## 2. Branch naming
Use the branch name Linear gives you (open the issue and press `Ctrl/Cmd + Shift + .` to copy it), for example:

```
salah/als-59-oci-network-setup
```

The `als-59` part is what links the branch and its pull request to the Linear issue automatically.

## 3. Commits
Short, present-tense messages: `Add OCI VCN module`, `Fix staging DB connection string`.

## 4. Pull requests
- Title starts with the key: `ALS-59: Add OCI VCN module`
- Fill in the PR template; write `Fixes ALS-59` to close the issue on merge
- At least one approving review is required before merging to `main`
- A CI check fails the PR if no Linear issue key is found in the title or branch

## 5. Merging
Squash-merge into `main` and delete the branch.

## 6. Architecture decisions
Significant technical decisions get an ADR in `docs/adr/` (copy `0000-template.md`).
