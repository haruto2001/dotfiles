#! /bin/zsh

function install_Homebrew () {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  return 0
}

function install_OhMyZsh () {
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  return 0
}

function install_with_brew () {
  local _package=$1

  if command -v brew >/dev/null 2>&1; then
    if brew list --formula | grep -q "^$_package\$"; then
      echo "$_package is already installed."
    else
      echo "Installing $_package..."
      brew install "$_package"
      echo "$_package installation is complete."
    fi
  else
    echo "Homebrew is not installed. Install Homebrew first."
  fi
  return 0
}

# link.shでも使うためにreadonlyにしていない
DOTFILES_DIR="$HOME/dotfiles"

# Homebrewのインストール
if ! command -v brew >/dev/null 2>&1; then
  echo "Installing Homebrew..."
  install_homebrew
  echo "Homebrew installation is complete."
else
  echo "Homebrew is already installed."
fi

# Oh My Zshのインストール
readonly OH_MY_ZSH_DIR="$DOTFILES_DIR/.oh-my-zsh"
if ! [ -d "$OH_MY_ZSH_DIR" ]; then
  echo "installing Oh My Zsh..."
  install_OhMyZsh
  echo "Oh My Zsh installation is complete."
  # $HOME/.oh-my-zsh -> $DOTFILES_DIR/.oh-my-zsh
  mv $HOME/.oh-my-zsh $DOTFILES_DIR/.oh-my-zsh
else
  echo "Oh My Zsh is already installed."
fi

# Vimのインストール
readonly HOMEBREW_VIM_DIR="/opt/homebrew/bin/vim"
if [ -x "$HOMEBREW_VIM_DIR" ]; then
  echo "Vim with Homebrew is already installed."
else
  install_with_brew vim
fi
