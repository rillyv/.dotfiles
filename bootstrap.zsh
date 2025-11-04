# Default folders if nothing passed
if [[ -z $STOW_FOLDERS ]]; then
    STOW_FOLDERS="alacritty,bin,keyboard-layout,nvim,personal,shell,tmux,work,zsh"
fi

if [[ -z $DOTFILES ]]; then
    DOTFILES="$HOME/.dotfiles"
fi

STOW_FOLDERS=$STOW_FOLDERS DOTFILES=$DOTFILES $DOTFILES/install

