#!/bin/bash

function check_email() {
  email="$(cat ~/.unread_email | xargs)"
  if [ -z "$email" ]
  then
    printf "%s" "#[fg=brightwhite]  X"
  else
    printf "%s" "#[fg=brightwhite] ${email}"
  fi
}

function _date() {
  printf "%s" "#[fg=brightwhite, bg=#1F2335]  $(date +'%b %d %y')"
}

function _time() {
  printf "%s" "#[fg=brightwhite]  $(date +'%H:%M:%S %Z') #[fg=brightwhite, bg=#1F2335]"
}

function main() {
  check_email
  _date
  _time
}

main
