#!/usr/bin/env zsh

# Default folders if nothing passed
if [[ -z $STOW_FOLDERS ]]; then
    STOW_FOLDERS="zsh,tmux,nvim,alacritty,i3,personal,work,bin,shell,qmk,autorandr,etc"
fi

if [[ -z $DOTFILES ]]; then
    DOTFILES="$HOME/.dotfiles"
fi

STOW_FOLDERS=$STOW_FOLDERS DOTFILES=$DOTFILES $DOTFILES/install

