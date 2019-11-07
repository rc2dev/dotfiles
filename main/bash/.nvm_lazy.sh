# This is sourced by Bash to lazily load NVM.
#
# Adapted from <https://old.reddit.com/r/node/comments/4tg5jg/lazy_load_nvm_for_faster_shell_start/d5hwwy7/>
#
# Rafael Cavalcanti

load_nvm() {
  unset -f nvm node npm npx
  export NVM_DIR=~/.nvm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

nvm() {
  load_nvm
  nvm $@
}

node() {
  load_nvm
  node $@
}

npm() {
  load_nvm
  npm $@
}

npx() {
  load_nvm
  npx $@
}
