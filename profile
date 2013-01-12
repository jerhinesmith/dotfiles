# Set up the aliases
if [ -f ~/.aliases ]; then
  . ~/.aliases
fi

# SSH Functions
if [ -f ~/.ssh-functions ]; then
  . ~/.ssh-functions
fi

# RVM stuff
[[ -s "/Users/jrhinesmith/.rvm/scripts/rvm" ]] && source "/Users/jrhinesmith/.rvm/scripts/rvm"  # This loads RVM into a shell session.

# rbenv stuff
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Gateway
export REMOTE_TUNNEL=jrhinesmith@tunnel.wonderhill.com:9590 

# Path
userbin=$HOME/bin
homebrew=/usr/local/bin:/usr/local/sbin
export PATH=$userbin:$homebrew:$PATH

# Some env variables
export NODE_PATH=/usr/local/lib/node_modules
export REDISTOGO_URL=redis://localhost:6379
