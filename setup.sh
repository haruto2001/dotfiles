#! /usr/bin/zsh

echo "Start setup."

# 各種ツールのインストール
# MacOSとUbuntuに対応
if [ "$(uname)" == "Darwin" ]; then
  # MacOSの場合
  . ./install_for_mac.sh
elif [ -f /etc/os-release ] && grep -q "Ubuntu" /etc/os-release; then
  # Ubuntuの場合
  . ./install_for_ubuntu.sh
else
  # 未対応のOSまたはディストリビューションの場合
  echo "This OS or distribution is not supported."
  exit 1
fi

# シンボリックリンクの作成
# シェルによって文字列比較の表記が異なるので別のファイルを使う
if [ $SHELL == "$(command -v zsh)" ]; then
  . ./link_for_zsh
elif [ $SHELL == "$(command -v bash)" ]; then
  . ./link_for_bash.sh
else
  echo "This shell is not supported."
  exit 1
fi

echo "Setup is complete."