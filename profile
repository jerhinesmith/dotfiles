# Change the prompt
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}
export PS1='\a\[\033[1;33m\]\w\[\033[0m\]$(parse_git_branch)$ '

# Change the colors (these work better on a darker background)
export LSCOLORS=gxfxcxdxbxegedabagacad

# Set up the aliases
if [ -f ~/.aliases ]; then
  . ~/.aliases
fi

# Add in the git autocomplete stuff
if [ -f ~/git-completion.bash ]; then
  source ~/git-completion.bash
fi

# rbenv init
eval "$(rbenv init -)"

# Some path stuff
PATH=$PATH:/usr/local/mysql/bin
