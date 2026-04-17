# himage

Rebuild tooling for the i-Cybie HIMAGE ROM.

This repository supports Linux-first builds on both `amd64` and `arm64`.

## Quickstart

```bash
make install-asl
export PATH="$HOME/.local/bin:$PATH"
make toolchain-check
make build
make check
```

Expected outputs:
- `out/newcart.ic3`
- `rel/generic202-l.bin`
- `rel/generic202-h.bin`
- `out/exact.ic3` (exact match checked against `src/walkup8a.car`)

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
