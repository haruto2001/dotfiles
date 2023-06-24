#! /bin/bash

# 未定義の変数があったら途中で終了する
set -eu

command_exists() {
  command -v "$@" >/dev/null 2>&1
}

directory_exists() {
  [ -d "$1" ]
}

install_apt() {
  apt-get update
  apt-get install -y apt
}

install_OhMyZsh() {
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  return 0
}

install_powerlevel10k() {
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$OH_MY_ZSH_DIR/custom/themes/powerlevel10k"
}

install_tpm() {
  local INSTALL_DIR="$1"
  git clone https://github.com/tmux-plugins/tpm "$INSTALL_DIR"
}

# link.shでも使うためにreadonlyにしていない
DOTFILES_DIR="$HOME/dotfiles"

# aptのインストール
if ! command_exists apt; then
  echo "Installing apt..."
  install_apt
  echo "apt installation is complete."
  # aptがインストールされているかを再確認してインストールされていなければエラーを出力して終了
  if ! command_exists apt; then
    echo "apt is not installed."
    exit 1
  fi
else
  echo "apt is already installed."
fi

# Zshのインストール
if ! command_exists zsh; then
  echo "Installing Zsh..."
  apt install -y zsh
  echo "Zsh installation is complete."
  # zshがインストールされているかを再確認してインストールされていなければエラーを出力して終了
  if ! command_exists zsh; then
    echo "Zsh is not installed."
    exit 1
  fi
fi

# デフォルトシェルをzshに変更
if ! [ "$SHELL" = "$(command -v zsh)" ]; then
  sudo chsh $USER -s $(which zsh)
  echo "Default shell has been changed to Zsh."
fi

# Gitのインストール
if ! command_exists git; then
  echo "Installing Git..."
  apt install -y git
  echo "Git installation is complete."
else
  echo "Git is already installed."
fi

# Oh My Zshのインストール
readonly OH_MY_ZSH_DIR="$DOTFILES_DIR/.oh-my-zsh"  # ここはDOTFILES_DIRの代わりにHOMEを使ったほうが良いかも
if ! directory_exists "$OH_MY_ZSH_DIR"; then
  echo "installing Oh My Zsh..."
  install_OhMyZsh
  echo "Oh My Zsh installation is complete."
  # $HOME/.oh-my-zsh -> $DOTFILES_DIR/.oh-my-zsh
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
if ! command_exists vim; then
  echo "Installing Vim..."
  apt install -y vim
  echo "Vim installation is complete."
else
  echo "Vim is already installed."
fi

#tmuxのインストール
if ! command_exists tmux; then
  echo "Installing tmux..."
  apt install -y tmux
  echo "tmux installation is complete."
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
