# dotfiles

This repository holds user-level configurations for my machines.

## Automatic installation

Just run `./install`. Any specific configurations for the machine will be installed automatically.

## Directory structure

The `home` directory holds my main configuration, while machine specific settings are placed under `hosts`.

The installation is done with GNU Stow. For example, to install my main configuration:

```
stow -t ~ home
```

The `dconf` directory holds gsettings configurations in plain text, and they can be load with this command:

```
cat dconf/*.conf | dconf load /
```

## License

Licensed under [GPLv3](LICENSE)

Copyright (C) 2018-2020 [Rafael Cavalcanti](https://rafaelc.org/)
