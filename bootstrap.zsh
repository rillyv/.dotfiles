#!/usr/bin/env zsh

if [[ -z $STOW_FOLDERS ]]; then
    STOW_FOLDERS="zsh,tmux,nvim,alacritty,xprofile,i3,personal,work,bin,shell"
fi

if [[ -z $DOTFILES ]]; then
    DOTFILES="$HOME/.dotfiles"
fi

# Run the install script
STOW_FOLDERS=$STOW_FOLDERS DOTFILES=$DOTFILES $DOTFILES/install

