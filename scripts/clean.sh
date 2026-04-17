#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

rm -f "$ROOT_DIR/src"/*.p "$ROOT_DIR/src"/*.lst
rm -f "$ROOT_DIR/src"/1 "$ROOT_DIR/src"/2
rm -f "$ROOT_DIR/out"/*.ic3 "$ROOT_DIR/out"/*.bin "$ROOT_DIR/out"/*.log
rm -f "$ROOT_DIR/rel"/*.bin
