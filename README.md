# razer-cli for macOS

`razer-cli` is a macOS command line tool for controlling Razer Chroma RGB peripherals, based on [librazermacos](https://github.com/1kc/librazermacos).

Currently only supports mice and mouse mats because I didn't have anything else to test with. Currently sets all devices to the same mode / color (possible to add individual device listing / control later, but not there currently).

## Building

1. After checking out, run `git submodule update --init --recursive` to fetch the librazermacos submodule.
2. Open the xcworkspace
3. Build the razer-cli target.

## Usage

```
USAGE: razer-cli <mode> [--debug] [<color>] [<color2>]

ARGUMENTS:
  <mode>                  The mode to set all devices to. (off | spectrum | color | breath)
  <color>                 The color to use when setting devices to color or breath mode.
  <color2>                The second color to use when setting devices to breath dual color
                          mode.

OPTIONS:
  --debug                 Whether to output debugging information
  -h, --help              Show help information.
```

### Examples

- `razer-cli spectrum` - set all devices to spectrum mode.
- `razer-cli off` - turn all devices RGB off.
- `razer-cli color red` - set all devices to static red.
- `razer-cli color green` - set all devices to static green.
- `razer-cli color 0000FF` - set all devices to static blue (from hex color code).
- `razer-cli breath green` - set all devices to breathing mode in green.
- `razer-cli breath green red` - set all devices to breathing mode with green and red.
