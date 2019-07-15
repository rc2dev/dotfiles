# dotfiles
This repository holds user-level configurations and related scripts for my machines.


## Directory structure

Each root directory holds the settings for a group of machines. A level deeper, you find the directories for each software configuration.


## Installation

The installation is done with GNU Stow. First, `cd` to the chosen group, then apply stow to whatever software you want, targetting the home directory.

For example, if you want to install my Bash config:

```
cd main
stow -t ~ bash
```

Or if you want to install my whole Termux config:

```
cd termux
stow -t ~ *
```


## License

Released under [GNU GPL v3](LICENSE).

Copyright 2018 Rafael Cavalcanti
