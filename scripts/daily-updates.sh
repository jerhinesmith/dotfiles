#!/bin/zsh

function check_for_appstore_updates {
  [[ $(softwareupdate --list 1> /dev/null) != "No new software available." ]] && echo "** App Store Updates Available"
}

source $HOME/.zshrc
omz update > /dev/null &
brew update > /dev/null
brew doctor
brew outdated
wait
# check_for_appstore_updates
