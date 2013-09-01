set nocompatible               " Be iMproved

if has('vim_starting')
set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Recommended to install
" After install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
NeoBundle 'Shougo/vimproc'

" My Bundles here:
"
" Note: You don't set neobundle setting in .gvimrc!
" Original repos on github
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'rstacruz/sparkup', {'rtp': 'vim/'}
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'Lokaltog/powerline', { 'rtp' : 'powerline/bindings/vim'}
NeoBundle 'airblade/vim-gitgutter'
" vim-scripts repos
NeoBundle 'L9'
NeoBundle 'FuzzyFinder'
NeoBundle 'rails.vim'
NeoBundle 'savevers.vim'
NeoBundle 'Align'
" Non github repos
NeoBundle 'git://git.wincent.com/command-t.git'
" gist repos
"NeoBundle 'gist:Shougo/656148', {
"	\ 'name': 'everything.vim',
"	\ 'script_type': 'plugin'}
" Non git repos
NeoBundle 'http://svn.macports.org/repository/macports/contrib/mpvim/'
NeoBundle 'https://bitbucket.org/ns9tks/vim-fuzzyfinder'

" ...

filetype plugin indent on     " Required!
"
" Brief help
" :NeoBundleList          - list configured bundles
" :NeoBundleInstall(!)    - install(update) bundles
" :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles

" Installation check.
NeoBundleCheck


"========================
set mouse=niv "or set mouse=a
set clipboard=unnamed

" for mac clipboard
vmap <C-c> y:call system("pbcopy", getreg("\""))<CR>
nmap <Space><C-v> :call setreg("\"",system("pbpaste"))<CR>p

" colorschme
:colorscheme ron

" for savevers.vim
set patchmode=.bak
set backupdir=~/.vim/bak
" カンマで区切られたバックアップを作成するファイル名
let savevers_types = "*"
" バージョン管理ファイルを保存するディレクトリ
let savevers_dirs  = &backupdir
" Diff表示の際にウィンドウをリサイズしない
let versdiff_no_resize=1
" パッチモードでバージョン管理する最大数
let savevers_max = 1000
" :Purgeでカレントファイルの全てのバックアップを削除
let savevers_purge = 0
" <F4>でひとつ前のバックアップを復元
nmap <silent> <F4> :1,$+1diffget <CR>
" <F5>でひとつ前のバックアップと比較
nmap <silent> <F5> :VersDiff -<CR>
" <F6>でひとつ後のバックアップと比較
nmap <silent> <F6> :VersDiff +<CR>
" <F8>でVersDiffから抜ける
nmap <silent> <F8> :VersDiff -c<CR>

set backup
set foldmethod=marker
set runtimepath+=/home/nyoshiza/.vim
set incsearch
set number
set tabstop=4
set autoindent
set showmatch
set backspace=indent,eol,start
set smartindent
set shiftwidth=4
set hlsearch
set cindent
set ruler
set t_kD=
set laststatus=2
if !has('gui_running')
  set t_Co=256
endif
syntax on
filetype plugin on
filetype indent on


" esc2回で消してくれる
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" 履歴で補完
hi Pmenu ctermbg=4
hi PmenuSel ctermbg=1
hi PMenuSbar ctermbg=4

" Window分割をinsert modeでも可能にする
map <C-W><C-V> :Vexplore!<CR>
map <C-W><C-H> :Hexplore<CR>
map! <C-W><C-V> <Esc>:Vexplore!<CR>
map! <C-W><C-H> <Esc>:Hexplore<CR>

if &encoding !=# 'utf-8'
set encoding=japan
set fileencoding=japan
endif
if has('iconv')
    let s:enc_euc = 'euc-jp'
    let s:enc_jis = 'iso-2022-jp'
    " iconvがeucJP-msに対応しているかをチェック
    if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
    " iconvがJISX0213に対応しているかをチェック
    elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
let s:enc_euc = 'euc-jisx0213'
let s:enc_jis = 'iso-2022-jp-3'
endif
" fileencodingsを構築
if &encoding ==# 'utf-8'
let s:fileencodings_default = &fileencodings
let &fileencodings = s:enc_jis .','. s:enc_euc
let &fileencodings = &fileencodings .','. s:fileencodings_default
unlet s:fileencodings_default
else
let &fileencodings = &fileencodings .','. s:enc_jis
set fileencodings+=utf-8,ucs-2le,ucs-2
if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
"set fileencodings+=cp932
set fileencodings-=euc-jp
set fileencodings-=euc-jisx0213
set fileencodings-=eucjp-ms
let &encoding = s:enc_euc
let &fileencoding = s:enc_euc
else
let &fileencodings = &fileencodings .','. s:enc_euc
endif
    endif
       " 定数を処分
       unlet s:enc_euc
       unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
function! AU_ReCheck_FENC()
if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
let &fileencoding=&encoding
endif
endfunction
autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
    set ambiwidth=double
endif

" vim -b : edit binary using xxd-format!
augroup Binary  
au!
au BufReadPre  *.so,*.bin let &bin=1  
au BufReadPost *.so,*.bin if &bin | %!xxd   
au BufReadPost *.so,*.bin set ft=xxd | endif 
au BufWritePre *.so,*.bin if &bin | %!xxd -r
au BufWritePre *.so,*.bin endif
au BufWritePost *.so,*.bin if &bin | %!xxd 
au BufWritePost *.so,*.bin set nomod | endif 
augroup END

" for lightline
let g:Powerline_symbols = 'fancy'
set guifont=Ricty\ Regular\ for\ Powerline
let g:lightline = {
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'modified': 'MyModified',
      \   'readonly': 'MyReadonly',
      \   'fugitive': 'MyFugitive',
      \   'filename': 'MyFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',
      \   'mode': 'MyMode',
      \ },
      \ 'separator': { 'left': '>', 'right': '<' },
      \ 'subseparator': { 'left': '>', 'right': '<' }
      \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() : 
        \  &ft == 'unite' ? unite#get_status_string() : 
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? '⭠ '._ : ''
  endif
  return ''
endfunction

function! MyFileformat()
  return winwidth('.') > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth('.') > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth('.') > 60 ? lightline#mode() : ''
endfunction

" for gitgutter
let g:gitgutter_sign_added = '✚'
let g:gitgutter_sign_modified = '➜'
let g:gitgutter_sign_removed = '✘'

autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
