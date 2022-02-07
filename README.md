# razer-cli for macOS

`razer-cli` is a macOS command line tool for controlling Razer Chroma RGB peripherals, based on [librazermacos](https://github.com/1kc/librazermacos).

Currently only supports mice and mouse mats because I didn't have anything else to test with.

## Building

1. After checking out, run `git submodule update --init --recursive` to fetch the librazermacos submodule.
2. Open the xcworkspace
3. Build the razer-cli target.

## Usage

```
USAGE: razer-command --mode <mode> [--debug] [--color <color>]

OPTIONS:
  --mode <mode>           The mode to set all devices to.
  --debug                 Whether to output debugging information
  --color <color>         The color to use when setting devices to a color mode.
  -h, --help              Show help information.
```

Examples:

`razer-cli --mode spectrum` - set all devices to spectrum mode.
`razer-cli --mode off` - turn all devices RGB off.
`razer-cli --mode color --color red` - set all devices to static red.
`razer-cli --mode color --color green` - set all devices to static green.
`razer-cli --mode color --color 0000FF` - set all devices to static blue (from hex color code).