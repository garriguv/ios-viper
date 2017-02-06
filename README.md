# ios-viper

Code generation for (B)VIPER modules.

This cli is distributed using [Docker](https://hub.docker.com/r/garriguv/ios-viper/).

## Installing

    $ make install

## Usage

    $ ios-viper --help

```
(B)VIPER module template generator

Usage:
  ios-viper [flags]

Examples:
  ios-viper -m MyModule -t UIView -d /path/to/module

Flags:
  -d, --directory string  The directory in which to create the module (required)
  -m, --module string     The name of the module (required)
  -t, --type string       The type of the module (required)
  -v, --version           Prints the version

Use "ios-viper [command] --help" for more information about a command.
```

## Publishing a new version

1. Update `VERSION` in `Makefile` **and** `main.swift`
1. Tag the commit with the version number
1. Run `make publish`
