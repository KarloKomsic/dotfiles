#!/usr/bin/env bash
set -e

DOTFILES="$HOME/Dotfiles"
echo "Using dotfiles directory: $DOTFILES"

# Installing packages for Arch btw
if command -v pacman >/dev/null 2>&1; then
  echo "Arch Linux detected"

  PKG_FILE="$DOTFILES/scripts/packages-arch.txt"

  if [ -f "$PKG_FILE" ]; then
    sudo pacman -S --needed --noconfirm $(grep -v '^#' "$PKG_FILE")
  fi
else
  echo "pacman not found, skipping Arch package install"
fi

# Installing yay AUR helper
if command -v pacman >/dev/null 2>&1; then
  if ! command -v yay >/dev/null 2>&1; then
    echo "Installing yay (AUR helper)..."
    sudo pacman -S --needed --noconfirm base-devel git
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
  fi
fi

# Installing AUR packages
AUR_PKG_FILE="$DOTFILES/scripts/packages-aur.txt"

if command -v yay >/dev/null 2>&1 && [ -f "$AUR_PKG_FILE" ]; then
  yay -S --needed --noconfirm $(grep -v '^#' "$AUR_PKG_FILE")
fi

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
echo "- Open tmux and press ctrl+a + I to install plugins"
echo "- Open Neovim to allow Lazy.nvim to install plugins"

