#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT_DIR/scripts/toolchain.sh"

echo "ASW:   ${ASW[*]}"
echo "P2BIN: ${P2BIN[*]}"
