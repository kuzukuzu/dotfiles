set nocompatible
set foldmethod=marker
set clipboard=unnamed,autoselect

" release autogroup in MyAutoCmd
augroup MyAutoCmd
  autocmd!
augroup END
" make, grepなどの後にQuickFixを開く
autocmd MyAutoCmd QuickfixCmdPost make,grep,grepadd,vimgrep copen
" QuickFixおよびHelpでは q でバッファを閉じる
autocmd MyAutoCmd FileType help,qf nnoremap <buffer> q <C-w>c

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
set infercase

" coffeescript
NeoBundle 'kchmck/vim-coffee-script'
au BufRead,BufNewFile,BufReadPre *.coffee set filetype=coffee
autocmd FileType coffee setlocal sw=2 sts=2 ts=2 et
au BufWritePost *.coffee :silent !coffee -cb %
" nnoremap <silent> <C-C> :CoffeeCompile vert <CR><C-w>h

" lightline.vim
NeoBundle 'itchyny/lightline.vim'
let g:lightline = { 'colorscheme': 'wombat' }

NeoBundle 'tpope/vim-surround'
NeoBundle 'kana/vim-operator-replace'
NeoBundle 'kana/vim-operator-user.git'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'bkad/CamelCaseMotion'

map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
sunmap w
sunmap b
sunmap e

NeoBundle "tyru/caw.vim.git"
nmap <C-c> <Plug>(caw:i:toggle)
vmap <C-c> <Plug>(caw:i:toggle)

NeoBundle "Shougo/unite.vim"
NeoBundle "Shougo/vimfiler"
nnoremap <C-e> :VimFilerExplorer<CR>
" close vimfiler automatically when there are only vimfiler open
autocmd MyAutoCmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif
let s:hooks = neobundle#get_hooks("vimfiler")
function! s:hooks.on_source(bundle)
  let g:vimfiler_as_default_explorer = 1
  let g:vimfiler_enable_auto_cd = 1
  
  " .から始まるファイルおよび.pycで終わるファイルを不可視パターンに
  " 2013-08-14 追記
  let g:vimfiler_ignore_pattern = "\%(^\..*\|\.pyc$\)"

  " vimfiler specific key mappings
  autocmd MyAutoCmd FileType vimfiler call s:vimfiler_settings()
  function! s:vimfiler_settings()
    " ^^ to go up
    nmap <buffer> ^^ <Plug>(vimfiler_switch_to_parent_directory)
    " use R to refresh
    nmap <buffer> R <Plug>(vimfiler_redraw_screen)
    " overwrite C-l
    nmap <buffer> <C-l> <C-w>l
  endfunction
endfunction
NeoBundle "tpope/vim-fugitive"
NeoBundle "gregsexton/gitv"
" }}}

" setting encodings
" {{{
set encoding=utf-8
set fileencoding=utf-8
set fileformats=unix,mac,dos
" }}}

" setting backups
" {{{
set nowritebackup
set nobackup
set noswapfile
set hidden
set switchbuf=useopen
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
set matchtime=3
set matchpairs& matchpairs+=<:>
set list
set cursorline
set cursorcolumn
colorscheme hybrid
" colorscheme molokai
syntax on
set wrap
set textwidth=0
set colorcolumn=80
set t_vb=
set novisualbell
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲
" status line
set laststatus=2
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
set shiftround
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
nmap <silent> <Esc><Esc> :nohlsearch<CR>
nnoremap <C-l><C-l> :%s/\s\+$//g<CR>
nnoremap <C-g><C-g> :%s/　/ /g<CR>

inoremap {<CR> {}<LEFT><CR><Esc>O
inoremap /**/ /*  */<LEFT><LEFT><LEFT>

map R <Plug>(operator-replace)

inoremap jj <Esc>

" 検索したら結果を真ん中に
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

nnoremap j gj
nnoremap k gk

vnoremap v $h

" Tabで対応する括弧に移動
nnoremap <Tab> %
vnoremap <Tab> %
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

" kkhshine
autocmd BufNewFile,BufRead *.wl set filetype=c
