# dotfiles

User-level configuration for my machines.

## Directory structure

The directory structure currently follows the [yadm](https://yadm.io/) specification.

Besides that, the [dconf directory](../.config/yadm/dconf) contains my gsettings configurations in plain text. Those are automatically loaded on bootstrapping.

## Installation

Use yadm to clone and bootstrap:

```sh
yadm clone --bootstrap https://github.com/rccavalcanti/dotfiles.git
```

## License

Licensed under [GPLv3](LICENSE)

Copyright (C) 2018-2020 [Rafael Cavalcanti](https://rafaelc.org/)
