#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC_CAR="$ROOT_DIR/src/walkup8a.car"
OUT_EXACT="$ROOT_DIR/out/exact.ic3"
TMP_LOW="$ROOT_DIR/out/exact-l.bin"
TMP_HIGH="$ROOT_DIR/out/exact-h.bin"

"$ROOT_DIR/scripts/build.sh" --exact

if ! cmp -s "$SRC_CAR" "$OUT_EXACT"; then
  echo "Exact image mismatch:" >&2
  echo "  expected: $SRC_CAR" >&2
  echo "  actual:   $OUT_EXACT" >&2
  exit 1
fi

python3 "$ROOT_DIR/scripts/splitic3.py" "$OUT_EXACT" "$TMP_LOW" "$TMP_HIGH"

if ! cmp -s "$TMP_LOW" "$ROOT_DIR/walkup/walkup8a-l.bin"; then
  echo "Low-byte split mismatch against walkup/walkup8a-l.bin" >&2
  exit 1
fi

if ! cmp -s "$TMP_HIGH" "$ROOT_DIR/walkup/walkup8a-h.bin"; then
  echo "High-byte split mismatch against walkup/walkup8a-h.bin" >&2
  exit 1
fi

echo "Exact check passed: out/exact.ic3 matches src/walkup8a.car"
