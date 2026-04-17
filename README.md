# himage

Rebuild tooling for the i-Cybie HIMAGE ROM.

This repository now supports Linux-first builds on both `amd64` and `arm64` without relying on Windows batch files.

## Prerequisites (Linux)

Install a Macroassembler AS toolchain that provides:
- `asw` or `asl`
- `p2bin`

If your binaries are not named that way, set:
- `ASW_BIN=/path/to/asw-compatible-binary`
- `P2BIN_BIN=/path/to/p2bin-compatible-binary`

To install from source (official upstream tarball):

```bash
make install-asl
```

By default this installs into `~/.local` (override with `PREFIX=...`).

If needed, add user-local binaries to PATH:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

Optional fallback (primarily `amd64`):
- `ALLOW_WINE_FALLBACK=1` plus `wine` with `bin/ASW.EXE` and `bin/P2BIN.EXE`

Native Linux binaries are recommended for cross-arch portability.

## Build

```bash
make build
```

Outputs:
- `out/newcart.ic3`
- `rel/generic202-l.bin`
- `rel/generic202-h.bin`

## Build EXACT image

```bash
make exact
```

Output:
- `out/exact.ic3`

## Verify exact reconstruction

```bash
make check
```

This builds `EXACT` mode and verifies:
- `out/exact.ic3 == src/walkup8a.car`
- split output matches `walkup/walkup8a-l.bin` and `walkup/walkup8a-h.bin`

## Utility targets

```bash
make toolchain-check
make clean
```

## Source layout

- `src/newcart.asm`: top-level assembly source.
- `src/*.i`: include files.
- `src/*.a_`: assembly fragments.
- `src/*.dat`: data tables.
- `scripts/`: Linux build/check scripts.
