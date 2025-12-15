#!/usr/bin/env bash
set -e

DOTFILES="$HOME/Dotfiles"
echo "Using dotfiles directory: $DOTFILES"

# Neovim btw
echo "Setting up Neovim..."
mkdir -p "$HOME/.config"
ln -sfn "$DOTFILES/nvim" "$HOME/.config/nvim"

# tmux btw
echo "Setting up tmux..."
ln -sfn "$DOTFILES/tmux/.tmux.conf" "$HOME/.tmux.conf"

# Install TPM if missing
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing TPM (Tmux Plugin Manager)..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# ZSH + Oh-My-Zsh
echo "Setting up Zsh..."
ln -sfn "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"

# Install Oh My Zsh if missing
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Ghostty
echo "Setting up Ghostty..."
mkdir -p "$HOME/.config/ghostty"
ln -sfn "$DOTFILES/ghostty/config.yaml" "$HOME/.config/ghostty/config.yaml"
ln -sfn "$DOTFILES/ghostty/theme" "$HOME/.config/ghostty/theme"

# SwayWM
echo "Setting up Sway and Sway utilities"
mkdir -o "$HOME/.config"
ln -sfn "$DOTFILES/sway" "$HOME/.config/sway"
ln -sfn "$DOTFILES/swaylock" "$HOME/.config/swaylock"
ln -sfn "$DOTFILES/waybar" "$HOME/.config/waybar"
ln -sfn "$DOTFILES/wofi" "$HOME/.config/wofi"
ln -sfn "$DOTFILES/wlogout" "$HOME/.config/wlogout"

# Finished
echo "Dotfiles installation complete!"
echo "- Restart your shell to apply Zsh config"
echo "- Open tmux and press prefix + I to install plugins"
echo "- Open Neovim to allow plugin manager to install plugins"

