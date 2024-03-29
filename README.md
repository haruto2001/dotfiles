[![MacOS](https://github.com/haruto2001/dotfiles/actions/workflows/macos.yml/badge.svg)](https://github.com/haruto2001/dotfiles/actions/workflows/macos.yml)
[![Ubuntu](https://github.com/haruto2001/dotfiles/actions/workflows/ubuntu.yml/badge.svg)](https://github.com/haruto2001/dotfiles/actions/workflows/ubuntu.yml)
![](https://img.shields.io/github/languages/code-size/haruto2001/dotfiles?color=success)
# My dotfiles


## Components

- `.vim`: This is a directory containing files that define vim settings. Plugin information is also located in this directory.

- `.p10k.zsh`: This is a [Powerlevel10k](https://github.com/romkatv/powerlevel10k) configuration file. This includes information on appearance, colors, prompt display items, Git information, directory display format, prompt style, etc.

- `.tmux.conf`: This is a file containing the tmux settings.

- `.vimrc`: This is used to load vim settings. Detailed settings are defined in various files in `vim` directory.

- `.zprofile`: This is a file containing information required by the login shell. This is read only once at login.

- `.zshrc`: This is read in the case of the login shell or interactive shells.

- `install_for_mac.sh`: This is a script for the installation of various tools in MacOS.

- `install_for_ubuntu.sh`: This is a script for the installation of various tools in Ubuntu.

- `link_for_bash.sh`: This is a script to create symbolic links in Bash to the `$HOME` directory of various configuration files.

- `link_for_zsh.sh`: This is a script to create symbolic links in Zsh to the `$HOME` directory of various configuration files.

- `setup.sh`: This is a script to install tools and create symbolic links.


## Installation

>**Note**
>This is only for MacOS and Ubuntu Linux. Please note that using it on other OS or distributions may destroy the environment.

Run this:

```sh
cd ~
git clone https://github.com/haruto2001/dotfiles.git
cd ~/dotfiles
sh setup.sh
```

First, run git clone to create a dotfiles directory in the home directory. \
Next, run setup.sh to install Homebrew and other tools and files, and create symbolic links to their home directories.

> **Note**
> If a file or directory with the same name already exists in the home directory, an error may occur when creating symbolic links. In this case, manually create symbolic links other than the existing file or directory, or delete the existing file or directory, and then run the following command.
>
> ```sh
> sh link.sh
> ```

If the settings are not reflected, restart the terminal or run the following commands to apply the changes.

```sh
source ~/.zshrc
```

## Improvements

If you find any bugs or suggestions for improvement, please let me know!