#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WORK_DIR="${WORK_DIR:-$ROOT_DIR/.build/asl}"
PREFIX="${PREFIX:-$HOME/.local}"
ASL_URL="${ASL_URL:-http://john.ccac.rwth-aachen.de:8000/ftp/as/source/c_version/asl-current.tar.gz}"
JOBS="${JOBS:-$(nproc 2>/dev/null || echo 1)}"

download() {
  local url="$1"
  local out="$2"
  if command -v curl >/dev/null 2>&1; then
    curl -fL "$url" -o "$out"
    return
  fi
  if command -v wget >/dev/null 2>&1; then
    wget -O "$out" "$url"
    return
  fi
  echo "ERROR: need curl or wget to download $url" >&2
  exit 1
}

echo "Installing Macroassembler AS into: $PREFIX"
echo "Source URL: $ASL_URL"

mkdir -p "$WORK_DIR"
TARBALL="$WORK_DIR/asl-current.tar.gz"
SRC_ROOT="$WORK_DIR/src"
rm -rf "$SRC_ROOT"
mkdir -p "$SRC_ROOT"

download "$ASL_URL" "$TARBALL"
tar -xzf "$TARBALL" -C "$SRC_ROOT"

ASL_SRC="$(find "$SRC_ROOT" -mindepth 1 -maxdepth 1 -type d | head -n1)"
if [[ -z "$ASL_SRC" ]]; then
  echo "ERROR: failed to locate extracted source directory" >&2
  exit 1
fi

cd "$ASL_SRC"
if [[ -f Makefile.def.tmpl && ! -f Makefile.def ]]; then
  cp Makefile.def.tmpl Makefile.def
fi

make -j"$JOBS" binaries

# Upstream "make install" depends on docs and may require a full LaTeX setup.
# Install binaries/includes/messages/manpages directly to keep this lightweight.
INSTROOT="$PREFIX" ./install.sh "bin" "include/asl" "share/man" "lib/asl" ""

if [[ -x "$PREFIX/bin/asl" && ! -e "$PREFIX/bin/asw" ]]; then
  ln -s "$PREFIX/bin/asl" "$PREFIX/bin/asw"
fi

echo "Installed binaries:"
ls -l "$PREFIX/bin/asl" "$PREFIX/bin/asw" "$PREFIX/bin/p2bin" 2>/dev/null || true
echo "Done."
