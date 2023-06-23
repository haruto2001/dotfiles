#! /usr/bin/zsh

echo "Start setup."

# MacOSとUbuntuに対応
if [ "$(uname)" == "Darwin" ]; then
    # MacOSの場合
    . ./install.sh
elif [ -f /etc/os-release ] && grep -q "Ubuntu" /etc/os-release; then
    # Ubuntuの場合
    . ./install_for_ubuntu.sh
else
    # 未対応のOSまたはディストリビューションの場合
    echo "This OS or distribution is not supported."
    exit 1
fi

# シンボリックリンクの作成
. ./link.sh

echo "Setup is complete."