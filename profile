# Variables
if [ -f ~/.variables ]; then
  . ~/.variables
fi

# Set up the aliases
if [ -f ~/.aliases ]; then
  . ~/.aliases
fi

# SSH Functions
if [ -f ~/.ssh-functions ]; then
  . ~/.ssh-functions
fi

# Local Profile Overrides (Private/Work)
if [ -f ~/.profile.local ]; then
  . ~/.profile.local
fi

# rbenv stuff
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
eval "$(/opt/homebrew/bin/brew shellenv)"

# nvm stuff
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pyenv stuff
# export PYENV_ROOT="$HOME/.pyenv"
# command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"

