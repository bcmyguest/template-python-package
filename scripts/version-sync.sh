#!/usr/bin/env bash
# Checks the package version agrees in pyproject.toml and uv.lock, and, given a
# tag, that the tag names that version. release.yml and prepare-release.yml run
# it before anything is built or pushed.
#
#   scripts/version-sync.sh           # pyproject.toml == uv.lock
#   scripts/version-sync.sh v0.2.0    # ... and == the tag
set -euo pipefail
cd "$(dirname "$0")/.."

name=$(sed -n 's/^name = "\(.*\)"$/\1/p' pyproject.toml | head -n 1)
toml=$(sed -n 's/^version = "\([^"]*\)".*/\1/p' pyproject.toml | head -n 1)
lock=$(awk -v n="$name" '$0 == "name = \"" n "\"" { getline; gsub(/version = |"/, ""); print; exit }' uv.lock)

echo "pyproject.toml: $toml"
echo "uv.lock:        $lock"
rc=0
[ "$toml" = "$lock" ] || { echo "error: uv.lock has $lock, pyproject.toml has $toml (run uv lock)" >&2; rc=1; }
if [ $# -ge 1 ]; then
    echo "tag:            ${1#v}"
    [ "$toml" = "${1#v}" ] || { echo "error: tag $1 does not match pyproject.toml $toml" >&2; rc=1; }
fi
[ $rc -eq 0 ] && echo "ok: $toml"
exit $rc
