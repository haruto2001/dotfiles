#! /bin/zsh

set -e

function command_exists() {
  command -v "$@" >/dev/null 2>&1
}

function directory_exists() {
  [ -d "$1" ]
}

function install_Homebrew() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  return 0
}

function install_OhMyZsh() {
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  return 0
}

function install_powerlevel10k() {
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$OH_MY_ZSH_DIR/custom/themes/powerlevel10k"
}

function install_tpm() {
  local -r INSTALL_DIR="$1"
  git clone https://github.com/tmux-plugins/tpm "$INSTALL_DIR"
}

function install_with_brew() {
  local _package=$1

  if command_exists /opt/homebrew/bin/brew; then
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

echo "$HOME"
# link.shでも使うためにreadonlyにしていない
DOTFILES_DIR="$HOME/dotfiles"

# Homebrewのインストール
if ! command_exists brew; then
  echo "Installing Homebrew..."
  install_homebrew
  echo "Homebrew installation is complete."
else
  echo "Homebrew is already installed."
fi

# Homebrewがインストールされているかを確認
if command_exists brew; then
  echo "Homebrew is already installed."
else
  echo "Homebrew is not installed."
  exit 1
fi

# Gitのインストール
# MacにはデフォルトでGitがインストールされているが，Homebrewで入れ直す
readonly HOMEBREW_GIT_DIR="/opt/homebrew/bin/git"
if ! [ -x "$HOMEBREW_GIT_DIR" ]; then
  install_with_brew git
else
  echo "Git with Homebrew is already installed."
fi

# Oh My Zshのインストール
readonly OH_MY_ZSH_DIR="$DOTFILES_DIR/.oh-my-zsh"  # ここはDOTFILES_DIRの代わりにHOMEを使ったほうが良いかも
if ! directory_exists "$OH_MY_ZSH_DIR"; then
  echo "installing Oh My Zsh..."
  install_OhMyZsh
  echo "Oh My Zsh installation is complete."
  # $HOME/.oh-my-zsh -> $DOTFILES_DIR/.oh-my-zsh
  find $HOME -name .oh-my-zsh
  find $HOME -name dotfiles
  mv $HOME/.oh-my-zsh $DOTFILES_DIR/.oh-my-zsh
else
  echo "Oh My Zsh is already installed."
fi

# Oh My Zshのインストール時に作成された~/.zshrcを削除
if [ -f "$HOME/.zshrc" ]; then
  echo "Removing existing ~/.zshrc..."
  rm "$HOME/.zshrc"
  echo "~/.zshrc removal is complete."
fi

# Powerlevel10kのインストール
readonly POWERLEVEL10K_DIR="$OH_MY_ZSH_DIR/custom/themes/powerlevel10k"
if ! directory_exists "$POWERLEVEL10K_DIR"; then
  echo "Installing Powerlevel10k..."
  install_powerlevel10k
  echo "Powerlevel10k installation is complete."
else
  echo "Powerlevel10k is already installed."
fi

# Vimのインストール
# MacにはデフォルトでVimがインストールされているが，Homebrewで入れ直す
readonly HOMEBREW_VIM_DIR="/opt/homebrew/bin/vim"
if ! [ -x "$HOMEBREW_VIM_DIR" ]; then
  install_with_brew vim
else
  echo "Vim with Homebrew is already installed."
fi

#tmuxのインストール
if ! command_exists tmux; then
  install_with_brew tmux
else
  echo "tmux is already installed."
fi

# TPM（tmux plugin manager）のインストール
readonly TPM_DIR="$DOTFILES_DIR/.tmux/plugins/tpm"
if ! directory_exists "$TPM_DIR"; then
  echo "Installing tmux plugin manager (tpm)..."
  install_tpm "$TPM_DIR"
  echo "tmux plugin manager (tpm) installation is complete."
else
  echo "tmux plugin manager (tpm) is already installed."
fi
