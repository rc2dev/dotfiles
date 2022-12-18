# Simple section displaying if shell was spawned by ranger.
#
# Author: Rafael Cavalcanti <https://rafaelc.org/dev>

# Configuration
SPACESHIP_RANGER_SYMBOL=" "

spaceship_ranger() {
  if [[ -z "$RANGER_LEVEL" ]]; then
    return
  fi

  content="ranger"

  spaceship::section::v4 \
    --color "$SPACESHIP_RANGER_COLOR" \
    --prefix "$SPACESHIP_RANGER_PREFIX" \
    --suffix "$SPACESHIP_RANGER_SUFFIX" \
    --symbol "$SPACESHIP_RANGER_SYMBOL" \
    "$content"
}
