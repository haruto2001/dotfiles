#! /bin/zsh

# 未定義な変数があったら途中で終了する
set -eu

# GirHub Actions用の設定
if [ $CI = "true" ]; then
  HOME="$HOME/work/dotfiles"
fi

# Zshに変更
if [ -z "$SHELL" ] || ! [ "$SHELL" = "$(command -v zsh)" ]; then
  if command -v zsh >/dev/null 2>&1; then
    exec zsh
  else
    echo "Zsh is not installed."
    exit 1
  fi
fi

# dotfilesディレクトリのPath
DOTFILES_DIR="$HOME/dotfiles"
# dotfilesディレクトリに移動する
cd $DOTFILES_DIR

echo "Creating symbolic links ..."
# .から始まるファイルやフォルダに対して
for f in .??*; do
    # シンボリックリンクを作りたくないファイルやディレクトリを除外
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".gitignore" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    [[ "$f" == ".oh-my-zsh" ]] && continue
    [[ "$f" == ".p10k.zsh" ]] && continue
    [[ "$f" == ".vim" ]] && continue

    # シンボリックリンクを作成
    ln -snfv ${DOTFILES_DIR}/$f $HOME
done
echo "Success!"
