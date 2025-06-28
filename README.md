# 💻 Terminal Setup

This repository contains my effort to create a fully reproducible macOS environment that feels familiar! It includes customizable dotfiles, a Hammerspoon toggle script for WezTerm, and some lovely color themes to work in.

---
## ✨ Features
This setup brings together Zsh, WezTerm, Hammerspoon, and Starship into a cohesive and beautiful terminal environment, with:
- 🎨 Catppuccin Theming
Consistent, pastel-friendly color themes applied across the entire terminal experience
- 💡 Dynamic Status Bar in WezTerm
Displays workspace, time, and hostname using a custom Powerline-style right status bar, color-matched to your theme.
- 🚀 Hammerspoon Toggle Shortcut
Press Cmd + Enter to instantly toggle WezTerm — similar to the hotkey shortcut in iTerm2
-	📁 Project Launcher
Leader + p opens a fuzzy launcher for quickly jumping between pre-defined project directories.
- 🛠️ Minimal, Reproducible Dotfiles
All config files are tracked and symlinked using a simple setup script — easy to clone and get going on any Mac.
- ⭐ Starship Prompt
Fast, informative, and beautiful prompt that integrates seamlessly with the theme and shell.

<img width="1470" alt="image" src="https://github.com/user-attachments/assets/205a1b38-afb8-40fc-9dcf-6d39d8c48194" />



## ⚡️ Quick Start


### 1. Make sure you have all necessary prerequisites downloaded

- [Zsh](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH) - The shell that all of this is built on
- [Hammerspoon](https://www.hammerspoon.org/) – MacOS automation tool (used for keyboard shortcuts and toggling WezTerm)
- [WezTerm](https://wezfurlong.org/wezterm/) –  Terminal emulator
- [MapleMono NF](https://github.com/subframe7536/maple-font?tab=readme-ov-file) – Font used in terminal
- [Starship](https://starship.rs) - For a nice looking prompt

### 2. Clone this repo and run the setup script

```bash
git clone https://github.com/yourname/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x ./setup.zsh
./setup.zsh
```

### 3. Enjoy your new terminal experience!

