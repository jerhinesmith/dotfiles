# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="dirty-rhino"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Change this value to set how frequently ZSH updates¬
export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git history)

source ~/.profile
source $ZSH/oh-my-zsh.sh

function devdep {
  # cap doadev deploy -s branch=fix-armor-use-for -s targets=doadev6.colo
  bundle exec cap doadev deploy -s branch=$(current_branch) -s targets=doadev$1.colo
}

alias ggc='git push -u origin $(current_branch)'
compdef ggc=git

# RVM Integration
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# Customize to your needs...
# export PATH=/Users/jrhinesmith/bin:/Users/jrhinesmith/.rvm/gems/ruby-1.9.2-p180/bin:/Users/jrhinesmith/.rvm/gems/ruby-1.9.2-p180@global/bin:/Users/jrhinesmith/.rvm/rubies/ruby-1.9.2-p180/bin:/Users/jrhinesmith/.rvm/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/jrhinesmith/bin:/Users/jrhinesmith/.rvm/gems/ruby-1.9.2-p180/bin:/Users/jrhinesmith/.rvm/gems/ruby-1.9.2-p180@global/bin:/Users/jrhinesmith/.rvm/rubies/ruby-1.9.2-p180/bin:/Users/jrhinesmith/.rvm/bin:/Users/jrhinesmith/.rvm/bin:/Users/jrhinesmith/.rvm/bin
