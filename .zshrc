# Starship
eval "$(starship init zsh)"

# --------------
# Source all plugins in .zsh directory
# --------------

for item in $HOME/.zsh/*; do
    name=$(basename "$item")
    source "$item/$name.plugin.zsh"
done


# ---------------
# Aliases
# ---------------
alias ls="ls -G"
alias cd="z"

# Manually call zsh-syntax-highlighting at the end
source "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh"
