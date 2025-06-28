#!/bin/bash

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

echo "✅ Dotfiles symlinked successfully."
