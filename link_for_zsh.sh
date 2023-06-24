#! /bin/zsh

# ローカルではCIが存在しない場合があるのでset -uはここでは実行しない
set -e

# GirHub Actions用の設定
if [[ $CI == "true" ]]; then
  HOME="$HOME/work/dotfiles"
fi

# 未定義な変数があったら途中で終了する
set -u

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
