# himage

Source code to HIMAGE. The code is arranged like the original binary image. When built using `check.bat` it should produce the exact same binary as the original binary from SilverLit. Requires the `ASW` assembler to build. This is provided in the `BIN` subdirectory.

* See `make.bat` for build operation.
* See `check.bat` for base comparison.

_Interesting files_

* newcart.a - main assembly file, includes all the rest
    - `*.i` - includes
	- `*.a`_ - continuation of code
	- `*.dat` - data structures
    - `bin\*.*` - tools needed to build
    - `walkup8a.car` - original cartridge for comparison (see check.bat)
