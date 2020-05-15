#!/usr/bin/env bash
#
# Copyright (C) %YEAR% Rafael Cavalcanti - rafaelc.org
# Licensed under GPLv3

set -euo pipefail

readonly script_name=$(basename "$0")
readonly script_dir="$(dirname "$(readlink -f "$0")")"

main() {
  # check_args "${@}"
  :%HERE%
}

# Helper functions

main "$@"
