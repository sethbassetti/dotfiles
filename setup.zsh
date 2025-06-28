#!/usr/bin/env zsh

echo "⚠️  This script will overwrite existing dotfiles in your home directory with symlinks from ~/dotfiles."
echo "Proceeding is destructive. You may lose changes in files like ~/.zshrc or ~/.gitconfig."
read "choice?Type 'y' to continue, or anything else to cancel: "

if [[ "$choice" != "y" ]]; then
    echo "Aborted."
    exit 1
fi

# -----------------------
# Download Zsh Plugins
# -----------------------
# Make the .zsh folder if it doesn't already exist
ZSH_PLUGIN_DIR="$(pwd)/.zsh"
mkdir -p "$ZSH_PLUGIN_DIR"

plugin_repos=(
    "https://github.com/zsh-users/zsh-autosuggestions.git"
    "https://github.com/zsh-users/zsh-syntax-highlighting.git"
    "https://github.com/agkozak/zsh-z.git"
)

echo -e "\n📦 Installing Zsh plugins into $ZSH_PLUGIN_DIR..."

cd "$ZSH_PLUGIN_DIR"
for repo in "${plugin_repos[@]}"; do
    git clone "$repo"
done
cd ..


# -----------------------------
# Define the dotfiles we want to copy over
# -----------------------------
dotfiles=(
    ".zshrc"
    ".hammerspoon"
    ".config/wezterm"
    ".zsh"
)

# Create the config directory if it doesn't already exist
mkdir -p "$HOME/.config"

# ------------------------------
# Clean up active configuration files and symlink new ones
# ------------------------------
for item in "${dotfiles[@]}"; do
    if [[ -e "$HOME/$item" || -L "$HOME/$item" ]]; then
        rm -rf "$HOME/$item"
    fi

    ln -s "$(pwd)/$item" "$HOME/$item" 
done

source $HOME/.zshrc

echo -e "\n✅ Dotfiles and plugins installed successfully."


