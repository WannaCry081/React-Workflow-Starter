#!/usr/bin/env bash

set -euo pipefail

current_dir="$(cd "$(dirname "$0")" && pwd)"
parent_dir="$(dirname "$current_dir")"

cd "$current_dir"

rm -f README.md index.html install.sh
rm -rf .git

for doc in AGENTS.md CLAUDE.md; do
	if [[ ! -e "$parent_dir/$doc" ]]; then
		rm -f "$doc"
	fi
done

shopt -s dotglob nullglob

for entry in *; do
	mv "$entry" "$parent_dir/"
done
