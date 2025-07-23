#!/usr/bin/env zsh

export DOTFILES="$HOME/.dotfiles"
export STOW_FOLDERS="zsh,tmux,nvim,alacritty,xprofile,i3,personal"

pushd $DOTFILES

for folder in ${(s:,:)STOW_FOLDERS}; do
  echo "Stowing $folder"
  stow -D $folder
  stow $folder
done

popd

