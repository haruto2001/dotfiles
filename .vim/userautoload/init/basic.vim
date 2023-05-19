"Character
"文字コードをUTF-8に設定
set fenc=utf-8

"File
"バックアップファイルを作成しない
set nowritebackup
set nobackup

"スワップファイルを作成しない
set noswapfile

"undoファイルを作成しない
set noundofile

"未保存のファイルを開いているときに別ファイルを開けるようにする
set hidden

"外部でファイルに変更が加えられたときに読み直す
set autoread


"Search
"検索文字列を強調
set hlsearch

"インクリメンタルサーチの有効化
set incsearch

"検索時に大文字・小文字を区別しない
set ignorecase

"検索に大文字・小文字が両方含まれているときのみignorecaseを無効化
set smartcase


"Display
"行番号を表示
set number

"現在の行を強調
set cursorline

"ステータスバーを常に表示
set laststatus=2

"コマンドステータスバーに表示
set showcmd

"カーソル位置をステータスバーに表示
set ruler

"タイトルバーにファイル名を表示
set title

"シンタックスハイライトを有効化
syntax enable

"ダークモード
set background=dark


"Edit
"タブの半角スペース数
set tabstop=4

"改行時にインデントするスペース数
"set shiftwidth=4

"タブを半角スペースに展開
set expandtab

"改行時に直前の行のインデントを継続
set autoindent

"長い行を折り返して表示
"set wrap

"バックスペースでインデントや改行を削除
set backspace=indent,eol,start

"対応する括弧を強調
set showmatch

"showmatchの継続時間(秒)
set matchtime=3

"対応する括弧に<>を追加
set matchpairs+=<:>

"コマンドライン補完を有効化
set wildmenu

"コマンドライン補完を強化
set wildmode=list:longest,full


"Cursor
"横移動で行をまたぐ
set whichwrap=b,s,h,l

"スクロール開始行数に余裕をもたせる
set scrolloff=3

"カーソルを行末の1行先まで移動可能にする
set virtualedit=onemore


"Mouse
"マウス操作を有効化
set mouse=a

"マウスによるドラッグを有効化
set ttymouse=xterm2


"Others
"ターミナル接続を高速化
set ttyfast

"コマンド履歴の保存上限
set history=500
