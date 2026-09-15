#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PACKAGES_DIR="$SCRIPT_DIR/../packages"

mkdir -p "$PACKAGES_DIR"

pacman -Qqen > "$PACKAGES_DIR/pacman.txt"
pacman -Qqem > "$PACKAGES_DIR/aur.txt"
