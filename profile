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

