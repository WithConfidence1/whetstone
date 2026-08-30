#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="${HOME}/.claude/skills"
mkdir -p "${SKILLS_DIR}"

for skill in whetstone whetstone-with-context; do
  src="${REPO_DIR}/skills/${skill}"
  dst="${SKILLS_DIR}/${skill}"
  if [ -e "${dst}" ] && [ ! -L "${dst}" ]; then
    echo "refusing to replace non-symlink ${dst}" >&2
    exit 1
  fi
  ln -sfn "${src}" "${dst}"
  echo "linked ${dst} -> ${src}"
done
