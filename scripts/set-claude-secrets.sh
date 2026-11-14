#!/usr/bin/env bash
# Sets the two secrets the Claude review needs on the org's repositories. GitHub Free doesn't share organization
# secrets with private repositories, so each repo gets its own copy. Run it again after rotating a token.
#
#   scripts/set-claude-secrets.sh                      every non-archived repo of Arcay-Ai
#   scripts/set-claude-secrets.sh Arcay-Studio other   only these repos
#
# Asks for the values and sends them to GitHub on stdin: they are never printed, logged, stored or put on a command
# line. Needs gh, logged in as an org admin.
#   CLAUDE_CODE_OAUTH_TOKEN: from `claude setup-token` (the Claude subscription the reviews run on)
#   LINEAR_API_KEY:          Linear > Settings > Security & access > Personal API keys, read access (leave empty to skip)
set -euo pipefail
ORG=${ORG:-Arcay-Ai}

if [ "$#" -gt 0 ]; then
  repos=$(printf "$ORG/%s\n" "$@")
else
  repos=$(gh repo list "$ORG" --limit 200 --no-archived --json nameWithOwner -q '.[].nameWithOwner' | grep -v "^$ORG/\.github$")
fi

read -rsp "CLAUDE_CODE_OAUTH_TOKEN: " claude_token; echo
[ -n "$claude_token" ] || { echo "No token given, nothing changed." >&2; exit 1; }
read -rsp "LINEAR_API_KEY (empty to skip): " linear_key; echo

for repo in $repos; do
  gh secret set CLAUDE_CODE_OAUTH_TOKEN --repo "$repo" < <(printf '%s' "$claude_token")
  [ -n "$linear_key" ] && gh secret set LINEAR_API_KEY --repo "$repo" < <(printf '%s' "$linear_key")
  echo "set: $repo"
done
unset claude_token linear_key
