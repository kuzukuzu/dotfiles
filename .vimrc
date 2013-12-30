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
" }}}

" coffeescript
" {{{
NeoBundle 'kchmck/vim-coffee-script'

au BufRead,BufNewFile,BufReadPre *.coffee set filetype=coffee
autocmd FileType coffee setlocal sw=2 sts=2 ts=2 et
" au BufWritePost *.coffee silent CoffeeMake! -b | cwindow | redraw!
" nnoremap <silent> <C-C> :CoffeeCompile vert <CR><C-w>h
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
colorscheme hybrid
syntax on
set wrap
" status line
set laststatus=2
" lightline.vim
NeoBundle 'itchyny/lightline.vim'
let g:lightline = { 'colorscheme': 'wombat' }
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
set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,]
" }}}

" key map
" {{{
nnoremap <C-c><C-c> :<C-u>nohlsearch<cr><Esc>
inoremap <C-j> <ESC>

inoremap {<CR> {}<LEFT><CR><Esc>O
inoremap /**/ /*  */<LEFT><LEFT><LEFT>

inoremap acom<CR> /*<CR>1w120495-7 桝冨 祐樹, <C-R>=strftime("%Y.%m.%d")<CR><CR>仕様:<CR>説明:<CR>*/
inoremap main<CR> #include<stdio.h><CR><CR>int main()<CR>{}<LEFT><CR><Esc>Oreturn 0;<ESC>0<ESC>O<ESC>O
inoremap test<CR> if (DEBUG) printf("aa\n");

" neocomplcache
NeoBundle 'Shougo/neocomplcache'
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : ''
    \ }

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" }}}
