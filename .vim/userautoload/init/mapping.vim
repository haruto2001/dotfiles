" 折り返しがあっても上下の移動を1行にする
noremap j gj
noremap k gk

" H,Lで行頭，行末に移動する
noremap <S-h> 0
noremap <S-l> $

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