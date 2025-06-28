#!/bin/bash

# Get the absolute path of the dotfiles repo (assumes the script is run inside it)
DOTFILES_DIR=$(pwd)

echo "⚠️  This script will overwrite existing dotfiles in your home directory with symlinks from ~/dotfiles."
echo "Proceeding is destructive. You may lose changes in files like ~/.zshrc or ~/.gitconfig."
read -p "Type 'y' to continue, or anything else to cancel: " choice

if [[ "$choice" != "y" ]]; then
    echo "Aborted."
    exit 1
fi

# Symlink the dotfiles
ln -sf zshrc ~/.zshrc
ln -sf hammerspoon ~/.hammerspoon

# Symlink each dotfile in the .config directory
mkdir -p ~/.config

for item in "$DOTFILES_DIR"/config/*; do
    name=$(basename "$item")
    target="$HOME/.config/$name"
    echo "-> $target"
    ln -sf "$item" "$target"
done

echo "✅ Dotfiles symlinked successfully."
