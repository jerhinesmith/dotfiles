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

# rbenv stuff
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
if [ -f '.ruby-version' ]; then cd .; fi

