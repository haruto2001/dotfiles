# #!/bin/zsh

# 未定義な変数があったら途中で終了する
set -eu

# dotfilesディレクトリのPathを取得
DOTFILES_DIR=$(cd $(dirname $0); pwd)
# dotfilesディレクトリに移動する
cd $DOTFILES_DIR

echo "Creating symbolic links ..."
# .から始まるファイルやフォルダに対して
for f in .??*; do
    # シンボリックリンクを作りたくないファイルやディレクトリを除外
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".gitignore" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    [[ "$f" == ".vim" ]] && continue

    # シンボリックリンクを作成
    ln -snfv ${DOTFILES_DIR}/$f ~
done
echo "Success!"
