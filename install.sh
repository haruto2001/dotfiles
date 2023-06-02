#! /bin/zsh

function install_Homebrew () {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  return 0
}

function install_OhMyZsh () {
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  return 0
}

function install_tpm () {
  local -r INSTALL_DIR="$1"
  git clone https://github.com/tmux-plugins/tpm "$INSTALL_DIR"
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

# .zprofileの設定を反映させることでberwコマンドのpathを通す
source $HOME/.zprofile
echo ".zprofile has been sourced."

# Oh My Zshのインストール
readonly OH_MY_ZSH_DIR="$DOTFILES_DIR/.oh-my-zsh"  # ここはDOTFILES_DIRの代わりにHOMEを使ったほうが良いかも
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
# MacにはデフォルトでVimがインストールされているが，Homebrewで入れ直す
readonly HOMEBREW_VIM_DIR="/opt/homebrew/bin/vim"
if ! [ -x "$HOMEBREW_VIM_DIR" ]; then
  install_with_brew vim
else
  echo "Vim with Homebrew is already installed."
fi

#tmuxのインストール
if ! command -v tmux >/dev/null 2>&1; then
  install_with_brew tmux
else
  echo "tmux is already installed."
fi

# TPM（tmux plugin manager）のインストール
readonly TPM_DIR="$DOTFILES_DIR/.tmux/plugins/tpm"
if ! [[ -d "$TPM_DIR" ]]; then
  install_tpm "$TPM_DIR"
else
  echo "tmux plugin manager (tpm) is already installed."
fi
