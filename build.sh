#!/usr/bin/env bash
set -euo pipefail

ROOT="$(pwd)"
OUTDIR="$ROOT/ocio_output"
pip install opencolorio
ociocpuinfo
chmod +x ghq
./ghq
mkdir -p "$OUTDIR"

echo "== Cloning repositories =="
while read -r repo; do
  [ -z "$repo" ] && continue
  name=$(basename "$repo" .git)

  if [[ ! -d "$name" ]]; then
    echo "Cloning $repo"
    ./ghq get "$repo"
  fi
done < repos.txt

echo
echo "== Searching for .ocio files =="

find . -type f -name "*.ocio" \
  ! -path "./.git/*" \
  ! -path "./ocio_output/*" \
  | sort | while read -r ocio; do

    # Normalize name
    relpath="${ocio#./}"
    safe_name=$(echo "$relpath" | sed 's|/|__|g' | sed 's|\.ocio$||')

    echo "→ Processing $relpath"

    ocioarchive "$safe_name" --iconfig "$ocio" \
      && mv "$safe_name.ocioz" "$OUTDIR/" \
      || echo "⚠️  Failed: $relpath"
done

echo
echo "✔ Completed. Output in: $OUTDIR"
