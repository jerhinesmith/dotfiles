#!/bin/zsh

source $HOME/.zshrc
upgrade_oh_my_zsh > /dev/null &
brew update > /dev/null
brew doctor &
brew outdated
wait

