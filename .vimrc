set nocompatible
set foldmethod=marker
set clipboard=unnamed,autoselect
" neobundle
" {{{
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))
filetype plugin indent on

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'

" neocomplete
NeoBundle has('lua') ? 'Shougo/neocomplete' : 'Shougo/neocomplcache'
if neobundle#is_installed('neocomplete')
    " neocomplete用設定
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_ignore_case = 1
    let g:neocomplete#enable_smart_case = 1
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns._ = '\h\w*'
elseif neobundle#is_installed('neocomplcache')
    " neocomplcache用設定
    let g:neocomplcache_enable_at_startup = 1
    let g:neocomplcache_enable_ignore_case = 1
    let g:neocomplcache_enable_smart_case = 1
    if !exists('g:neocomplcache_keyword_patterns')
        let g:neocomplcache_keyword_patterns = {}
    endif
    let g:neocomplcache_keyword_patterns._ = '\h\w*'
    let g:neocomplcache_enable_camel_case_completion = 1
    let g:neocomplcache_enable_underbar_completion = 1
endif
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

" coffeescript
NeoBundle 'kchmck/vim-coffee-script'
au BufRead,BufNewFile,BufReadPre *.coffee set filetype=coffee
autocmd FileType coffee setlocal sw=2 sts=2 ts=2 et
" au BufWritePost *.coffee silent CoffeeMake! -b | cwindow | redraw!
" nnoremap <silent> <C-C> :CoffeeCompile vert <CR><C-w>h

" lightline.vim
NeoBundle 'itchyny/lightline.vim'
let g:lightline = { 'colorscheme': 'wombat' }

NeoBundle 'tpope/vim-surround'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'kana/vim-operator-replace'
NeoBundle 'kana/vim-operator-user.git'

" }}}

" setting encodings
" {{{
set encoding=utf-8
set fileencoding=utf-8
set fileformats=unix,mac,dos
" }}}

" setting backups
" {{{
" set backup
" set backupdir=~/backup
" }}}

" setting search histories
" {{{
set history=50
set ignorecase
set smartcase
set hlsearch
set incsearch
" }}}

" setting appearance
" {{{
" autocmd ColorScheme * highlight LineNr ctermfg=23 guifg=#880000
set relativenumber number
set showmatch
set cursorline
set cursorcolumn
" colorscheme hybrid
colorscheme iceberg
syntax on
set wrap
" status line
set laststatus=2
" 行末の空白文字を可視化
highlight WhitespaceEOL cterm=underline ctermbg=red guibg=#FF0000
au BufWinEnter * let w:m3 = matchadd("WhitespaceEOL", '\s\+$')
au WinEnter * let w:m3 = matchadd("WhitespaceEOL", '\s\+$')
" 行頭のTAB文字を可視化
highlight TabString cterm=underline ctermfg=darkgrey gui=underline guifg=#AAAAAA
au BufWinEnter * let w:m2 = matchadd("TabString", '^\ \+')
au WinEnter * let w:m2 = matchadd("TabString", '^\ \+')
" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermbg=red guibg=#666666
au BufWinEnter * let w:m3 = matchadd("ZenkakuSpace", '　')
au WinEnter * let w:m3 = matchadd("ZenkakuSpace", '　')
" .mdファイルをmarkdownとして扱うように
autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
" }}}

" setting tabs
" {{{
set expandtab
set autoindent
set smartindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
" }}}

" setting cursor move
" {{{
" set backspace=indent,eol,start
" set whichwrap=b,s,h,l,<,>,[,]
" }}}

" key map
" {{{
nnoremap <C-j> ddp
nnoremap <C-h> yypk
nnoremap <C-k> kddpk
nnoremap <C-c><C-c> :<C-u>nohlsearch<cr><Esc>
nnoremap <C-l><C-l> :%s/\s\+$//g<CR>
nnoremap <C-g><C-g> :%s/　/ /g<CR>

inoremap {<CR> {}<LEFT><CR><Esc>O
inoremap /**/ /*  */<LEFT><LEFT><LEFT>

nnoremap <C-e> :NERDTree<CR>
map R <Plug>(operator-replace)

"
" tab
"

" Anywhere SID.
function! s:SID_PREFIX()
    return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
    let s = ''
    for i in range(1, tabpagenr('$'))
        let bufnrs = tabpagebuflist(i)
        let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
        let no = i  " display 0-origin tabpagenr.
        let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
        let title = fnamemodify(bufname(bufnr), ':t')
        let title = '[' . title . ']'
        let s .= '%'.i.'T'
        let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
        let s .= no . ':' . title
        let s .= mod
        let s .= '%#TabLineFill# '
    endfor
    let s .= '%#TabLineFill#%T%=%#TabLine#'
    return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
    execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ
" }}}
