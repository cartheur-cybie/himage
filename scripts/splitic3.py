#!/usr/bin/env python3
"""Split an interleaved IC3 image into low/high byte streams.

low  = even-indexed bytes (byte 0, 2, 4, ...)
high = odd-indexed bytes  (byte 1, 3, 5, ...)
"""

from __future__ import annotations

import pathlib
import sys


def main() -> int:
    if len(sys.argv) != 4:
        print("usage: splitic3.py <input.ic3> <out-low.bin> <out-high.bin>", file=sys.stderr)
        return 2

    src = pathlib.Path(sys.argv[1])
    out_low = pathlib.Path(sys.argv[2])
    out_high = pathlib.Path(sys.argv[3])

    data = src.read_bytes()
    out_low.parent.mkdir(parents=True, exist_ok=True)
    out_high.parent.mkdir(parents=True, exist_ok=True)
    out_low.write_bytes(data[0::2])
    out_high.write_bytes(data[1::2])
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
