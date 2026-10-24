#!/usr/bin/env bash
# One-shot: create PUBLIC GitHub repo with showcase only (no LearnUp source).
# Run on a machine where you are logged into GitHub as marfilip748:
#   gh auth login
#   ./publish-to-github.sh
set -euo pipefail
cd "$(dirname "$0")"

if ! command -v gh >/dev/null 2>&1; then
  echo "Install GitHub CLI: https://cli.github.com/" >&2
  exit 1
fi

gh auth status >/dev/null

REPO_NAME="${REPO_NAME:-LearnUp}"
VISIBILITY="${VISIBILITY:-public}"

# Guard: refuse if any .py slipped in
if find . -type f -name '*.py' ! -path './.git/*' | grep -q .; then
  echo "ABORT: .py files present — this showcase must stay source-free." >&2
  exit 1
fi

if [[ ! -d .git ]]; then
  git init
  git add .
  git commit -m "docs: LearnUp public product showcase (source private)"
  git branch -M main
fi

if gh repo view "marfilip748/${REPO_NAME}" >/dev/null 2>&1; then
  echo "Repo marfilip748/${REPO_NAME} already exists — pushing main…"
  git remote remove origin 2>/dev/null || true
  git remote add origin "https://github.com/marfilip748/${REPO_NAME}.git"
  git push -u origin main
else
  gh repo create "marfilip748/${REPO_NAME}" --"${VISIBILITY}" --source=. --remote=origin --push \
    --description "LearnUp — gamified CKE exam prep (product showcase; source private)"
fi

gh repo edit "marfilip748/${REPO_NAME}" \
  --add-topic edtech \
  --add-topic gamification \
  --add-topic python \
  --add-topic flet \
  --add-topic portfolio \
  --homepage "https://github.com/marfilip748/LearnUp" || true

echo
echo "Done → https://github.com/marfilip748/${REPO_NAME}"
echo "Next: paste PROFILE_README_SNIPPET.md into https://github.com/marfilip748/marfilip748"
