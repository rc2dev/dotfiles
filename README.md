# dotfiles

This repository holds user-level configurations for my machines.

## Manual installation

First, initialize the submodules:

```
git submodule update --init --recursive
```

Each directory holds a set of cumullative settings. The installation is done with GNU Stow.

For example, to install my cli and gui configs:

```
stow -t ~ cli gui
```

The `hosts` directory holds host specific configuration.


## Automatic installation

Just run `./install` and select what to stow. Any specific configurations for the machine will be installed automatically.

## License

Released under [GNU GPL v3](LICENSE).

Copyright 2018 Rafael Cavalcanti
