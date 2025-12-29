#!/usr/bin/env bash
set -euo pipefail

ROOT="$(pwd)"
OUTDIR="$ROOT/ocio_output"
pip install opencolorio
ociocpuinfo
chmod +x ghq
./ghq help
mkdir -p "$OUTDIR"
mkdir /home/runner/ghq/
echo "== Cloning repositories =="
cd /home/runner/ghq/
mkdir blender
wget https://download.blender.org/release/Blender5.0/blender-5.0.1-linux-x64.tar.xz
tar -xf blender-5.0.1-linux-x64.tar.xz -C blender-5.0.1
wget https://download.blender.org/release/Blender5.0/blender-5.0.0-linux-x64.tar.xz
tar -xf blender-5.0.0-linux-x64.tar.xz -C blender-5.0.0
wget https://download.blender.org/release/Blender4.5/blender-4.5.5-linux-x64.tar.xz
tar -xf blender-4.5.5-linux-x64.tar.xz -C blender-4.5.5
wget https://download.blender.org/release/Blender4.5/blender-4.5.4-linux-x64.tar.xz
tar -xf blender-4.5.4-linux-x64.tar.xz -C blender-4.5.4
wget https://download.blender.org/release/Blender4.5/blender-4.5.3-linux-x64.tar.xz
tar -xf blender-4.5.3-linux-x64.tar.xz -C blender-4.5.3
wget https://download.blender.org/release/Blender4.5/blender-4.5.2-linux-x64.tar.xz
tar -xf blender-4.5.2-linux-x64.tar.xz -C blender-4.5.2
wget https://download.blender.org/release/Blender4.5/blender-4.5.1-linux-x64.tar.xz
tar -xf blender-4.5.1-linux-x64.tar.xz -C blender-4.5.1
wget https://download.blender.org/release/Blender4.5/blender-4.5.0-linux-x64.tar.xz
tar -xf blender-4.5.0-linux-x64.tar.xz -C blender-4.5.0
wget https://download.blender.org/release/Blender3.6/blender-3.6.23-linux-x64.tar.xz
tar -xf blender-3.6.23-linux-x64.tar.xz -C blender-3.6.23
wget https://download.blender.org/release/Blender3.6/blender-3.6.22-linux-x64.tar.xz
tar -xf blender-3.6.22-linux-x64.tar.xz -C blender-3.6.22
wget https://download.blender.org/release/Blender3.6/blender-3.6.21-linux-x64.tar.xz
tar -xf blender-3.6.21-linux-x64.tar.xz -C blender-3.6.21
wget https://download.blender.org/release/Blender3.6/blender-3.6.20-linux-x64.tar.xz
tar -xf blender-3.6.20-linux-x64.tar.xz -C blender-3.6.20
wget https://download.blender.org/release/Blender3.2/blender-3.2.0-linux-x64.tar.xz
tar -xf blender-3.2.0-linux-x64.tar.xz -C blender-3.2.0
wget https://download.blender.org/release/Blender3.2/blender-3.2.1-linux-x64.tar.xz
tar -xf blender-3.2.1-linux-x64.tar.xz -C blender-3.2.1
wget https://download.blender.org/release/Blender3.2/blender-3.2.2-linux-x64.tar.xz
tar -xf blender-3.2.2-linux-x64.tar.xz -C blender-3.2.2

echo
echo "== Searching for .ocio files =="
ls
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
