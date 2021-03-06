" common config {{{
set nocompatible

set number
set relativenumber
set signcolumn=yes

syntax on
set showmode
set showcmd
set ttymouse=sgr
set mouse=a
set encoding=utf-8
set t_Co=256
filetype plugin indent on

set autoindent
set smartindent
set expandtab
set smarttab
set tabstop=4
set shiftwidth=4
set softtabstop=4

set backspace=indent,eol,start
set cursorline
set textwidth=120
set ruler
set showmatch

set incsearch
set ignorecase
set smartcase
set hlsearch
set magic
set re=0

set history=800
set hidden
set updatetime=300
set shortmess+=c
set noswapfile
" }}}

" async task {{{
let g:asyncrun_open = 6
let g:asyncrun_rootmarks = ['.git', 'package.json', 'pyproject.toml', 'cargo.toml']
noremap <silent><f5> :AsyncTask run<cr>
" }}}

" visual search {{{
xnoremap * :<C-u>call vsearch#VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call vsearch#VSetSearch('?')<CR>?<C-R>=@/<CR><CR>
" }}}

" vista {{{
let g:vista_default_executive = 'coc'
" }}}
