#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC_DIR="$ROOT_DIR/src"
OUT_DIR="$ROOT_DIR/out"
REL_DIR="$ROOT_DIR/rel"
LOG_FILE="$OUT_DIR/asw.log"

mode="release"
defines="NEWFEAT,SERIAL"
out_name="newcart.ic3"

if [[ "${1:-}" == "--exact" ]]; then
  mode="exact"
  defines="EXACT"
  out_name="exact.ic3"
elif [[ -n "${1:-}" ]]; then
  echo "usage: $0 [--exact]" >&2
  exit 2
fi

source "$ROOT_DIR/scripts/toolchain.sh"

mkdir -p "$OUT_DIR" "$REL_DIR"
rm -f "$OUT_DIR/$out_name" "$LOG_FILE"

(
  cd "$SRC_DIR"
  "${ASW[@]}" -cpu 93C141 -L -A -D "$defines" newcart.asm >"$LOG_FILE"
)

if [[ ! -f "$SRC_DIR/newcart.p" ]]; then
  echo "ERROR: assembler did not produce $SRC_DIR/newcart.p" >&2
  exit 1
fi

(
  cd "$SRC_DIR"
  "${P2BIN[@]}" -r 0x200000-0x23FFFF newcart.p "$OUT_DIR/$out_name"
)

rm -f "$SRC_DIR/newcart.p"

if [[ "$mode" == "release" ]]; then
  python3 "$ROOT_DIR/scripts/splitic3.py" \
    "$OUT_DIR/$out_name" \
    "$REL_DIR/generic202-l.bin" \
    "$REL_DIR/generic202-h.bin"
fi

echo "Built $OUT_DIR/$out_name"
