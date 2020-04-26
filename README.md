# dotfiles

This repository holds user-level configurations for my machines.

## Automatic installation

Just run `./install` and select what to stow. Any specific configurations for the machine will be installed automatically.

## Directory structure

Each directory holds a set of cumulative settings. The installation is done with GNU Stow. For example, to install my cli and gui configs:

```
stow -t ~ cli gui
```

Machine specific configuration is placed under `hosts`.

The directory `dconf` is not _stowable_. It holds gsettings configurations in plain text, and you can run this command to load them:

```
cat dconf/*.conf | dconf load /
```

## License

Licensed under [GPLv3](LICENSE)

Copyright (C) 2018-2020 [Rafael Cavalcanti](https://rafaelc.org/)
