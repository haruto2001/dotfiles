if &compatible
  set nocompatible
endif

set rtp+=$HOME/dotfiles/.vim/

" 各種設定ファイルの読み込み
runtime! userautoload/init/*.vim
runtime! userautoload/dein/*.vim

" プラグインのインストール先
let s:dein_dir = expand('$HOME/dotfiles/.vim/dein')
"dein.vim本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

set rtp+=$HOME/dotfiles/.vim/dein/repos/github.com/Shougo/dein.vim

" dein.vimがなければ自動でGitHubからダウンロード
" ※もしもdein.vimがない状態でダウンロードが実行されなければ
"   if文を両方ともコメントアウトして2つのexecute文のみを実行文してみるとよい
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " tomlファイルのパス
  let s:toml_dir = expand('$HOME/dotfiles/.vim/userautoload/dein/')
  let s:toml = s:toml_dir . 'dein.toml'
  let s:toml_lazy = s:toml_dir . 'dein-lazy.toml'

  " tomlファイルの読み込み
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:toml_lazy, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" 未インストールを確認
if dein#check_install()
  call dein#install()
endif