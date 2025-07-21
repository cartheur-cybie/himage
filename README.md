# himage

Image-creator for new images that resembles ordering of the original. When built using `check.bat` it should produce the exact same binary as the original binary from SilverLit. Requires the `ASW` assembler to build. This is provided in the `BIN` subdirectory.

* See `make.bat` for build operation.
* See `check.bat` for base comparison.

_Interesting files_

* newcart.asm - main assembly file, includes all the rest
    - `*.i` - includes
	- `*.a_` - continuation of assembler code
	- `*.dat` - data structures
    - `bin\*.*` - tools needed to build
    - `walkup8a.car` - original cartridge for comparison (see check.bat)
