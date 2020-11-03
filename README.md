# Setting Up a New Machine

## Homebrew

Install homebrew using this command from the terminal

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

## Generate New SSH Keys

Generate a new SSH key

```
ssh-keygen -t ed25519 -C "your_email@example.com"
```

Add the key to the keychain

```
vim ~/.ssh/config
```

Paste in the following

```
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed2551
```

Finally, run this command

```
ssh-add -K ~/.ssh/id_ed25519
```

## Set up Zsh / Oh-My-Zshell

```
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Install Inconsolata

https://fonts.google.com/specimen/Inconsolata

## Clone dotfiles

```
cd ~
mkdir Projects
cd Projects
git clone git@github.com:jerhinesmith/dotfiles.git
```

## Symlink dotfiles

```
ln -s /Users/justin/Projects/dotfiles/aliases .aliases
ln -s /Users/justin/Projects/dotfiles/profile .profile
ln -s /Users/justin/Projects/dotfiles/variables .variables
mv .zshrc .zshrc.old
ln -s /Users/justin/Projects/dotfiles/zshrc .zshrc
ln -s /Users/justin/Projects/dotfiles/vimrc .vimrc
ln -s /Users/justin/Projects/dotfiles/settings.json /Users/justin/Library/Application\ Support/Code/User/settings.json
ln -s /Users/justin/Projects/dotfiles/dirty-rhino.zsh-theme .oh-my-zsh/themes/dirty-rhino.zsh-theme
```

## Other Utilities

* KeepingYouAwake - `brew cask install keepingyouawake`