" LeaderをSpaceキーに設定
let mapleader = "\<Space>"

" Space wで保存
nnoremap <Leader>w :w<CR>
" Space qで通常終了
nnoremap <Leader>q :q<CR>
" Space fqで強制終了
nnoremap <Leader>fq :q!<CR>

" Space hで行頭に移動
nnoremap <Leader>h ^
" Space lで行末に移動
nnoremap <Leader>l $l

" 折り返しがあっても上下の移動を1行にする
noremap j gj
noremap k gk

" controlキーを押しながら、h,j,k,lでカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" controlキーを押しながら、f,b,p,nでカーソル移動
inoremap <C-n> <Down>
inoremap <C-p> <Up>
inoremap <C-b> <Left>
inoremap <C-f> <Right>

" 貼り付けたテキストの末尾へ自動的に移動
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Escキーの代わりにjjでインサートモードを抜ける
inoremap <silent> jj <ESC>