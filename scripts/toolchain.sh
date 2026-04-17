#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BIN_DIR="$ROOT_DIR/bin"

ASW=()
P2BIN=()

pick_tool() {
  local env_name="$1"
  local native_names_csv="$2"
  local exe_name="$3"
  local -n out_ref="$4"
  local env_value="${!env_name:-}"
  local native_name

  if [[ -n "$env_value" ]]; then
    out_ref=("$env_value")
    return 0
  fi

  IFS=',' read -r -a native_names <<<"$native_names_csv"
  for native_name in "${native_names[@]}"; do
    if command -v "$native_name" >/dev/null 2>&1; then
      out_ref=("$native_name")
      return 0
    fi
  done

  if [[ "${ALLOW_WINE_FALLBACK:-0}" == "1" ]] && command -v wine >/dev/null 2>&1 && [[ -f "$BIN_DIR/$exe_name" ]]; then
    out_ref=("wine" "$BIN_DIR/$exe_name")
    return 0
  fi

  return 1
}

if ! pick_tool "ASW_BIN" "asw,asl" "ASW.EXE" ASW; then
  cat >&2 <<'EOF'
ERROR: Could not find assembler tool.
- Install native 'asw' or 'asl' and put it on PATH (recommended for Linux amd64/arm64), OR
- Set ASW_BIN to a custom executable path.
Optional amd64 fallback:
- Set ALLOW_WINE_FALLBACK=1 and install wine with bin/ASW.EXE available.
EOF
  exit 1
fi

if ! pick_tool "P2BIN_BIN" "p2bin" "P2BIN.EXE" P2BIN; then
  cat >&2 <<'EOF'
ERROR: Could not find p2bin tool.
- Install native 'p2bin' and put it on PATH (recommended for Linux amd64/arm64), OR
- Set P2BIN_BIN to a custom executable path.
Optional amd64 fallback:
- Set ALLOW_WINE_FALLBACK=1 and install wine with bin/P2BIN.EXE available.
EOF
  exit 1
fi
