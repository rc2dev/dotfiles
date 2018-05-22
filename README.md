# dotfiles
This repository holds user-level dotfiles for my machines.


## Directory structure

Each directory holds the settings for a group of machines I admin.
For instance, `fam` contains the dotfiles for my family members boxes, while `pi` has my Raspberry Pis'.

Then, the subdirectories have each software's configs.


## Installation

The installation is done with GNU Stow. First, `cd` to the chosen group, then apply stow to whatever software you want, targetting the home directory.

For example, if you want to install my Arch's Bash configs:

```
cd arch
stow -t ~ bash
```

Or if you want to install my whole Pi configs:

```
cd pi
stow -t ~ *
```


## License

Released under [GNU GPL v3](LICENSE).

Copyright 2018 Rafael Cavalcanti
