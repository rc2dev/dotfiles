# dotfiles

This repository holds user-level configurations for my machines.

## Installation

Each directory holds the settings for a software or a specific host. The installation is done with GNU Stow.

For example, to install my Bash config:

```
stow -t ~ bash
```

As an alternative, run `./install` and pick a group of directories to stow.

## License

Released under [GNU GPL v3](LICENSE).

Copyright 2018 Rafael Cavalcanti
