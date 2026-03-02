" ~/.vimrc — Cross-platform Vim configuration

" Auto-install vim-plug if missing
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'joshdick/onedark.vim'
Plug 'pangloss/vim-javascript'
Plug 'rust-lang/rust.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()

" Filetype & syntax
filetype on
filetype plugin on
filetype indent on
syntax on

" Theme
colorscheme onedark
let g:javascript_plugin_jsdoc = 1

" True color support
if (has("termguicolors"))
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Cursor: bar in insert mode, block otherwise
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Status line
function! s:statusline_expr()
  let mod = "%{&modified ? '[+] ' : !&modifiable ? '[x] ' : ''}"
  let ro  = "%{&readonly ? '[RO] ' : ''}"
  let ft  = "%{len(&filetype) ? '['.&filetype.'] ' : ''}"
  let fug = "%{exists('g:loaded_fugitive') ? fugitive#statusline() : ''}"
  let sep = ' %= '
  let pos = ' %-12(%l : %c%V%) '
  let pct = ' %P'
  return '[%n] %f %<'.mod.ro.ft.fug.sep.pos.'%*'.pct
endfunction
let &statusline = s:statusline_expr()

" General
set ruler
set autoindent
set cursorline
set cursorcolumn
set directory=/tmp//,.
set encoding=utf-8
set incsearch
set ignorecase
set smartcase
set hlsearch
set nocompatible
set backspace=2
set number
set relativenumber
set laststatus=2
set ttyfast
set undodir=/tmp
set undofile
set scrolloff=8
set matchpairs+={:}
set clipboard=unnamedplus,unnamed

" Remaps
nnoremap <Space> /
nnoremap <C-L> :nohlsearch<CR>
nnoremap <Leader>r :%s///g<Left><Left>
nnoremap <Leader>rc :%s///gc<Left><Left><Left>
vnoremap <Leader>n :s/\%V\n//g<Left><Left>

" Commands
command Terminal vert term
command! -nargs=0 ShowAll execute "set list" | execute "set lcs+=space:·"
command! -nargs=0 HideAll set nolist
command! -nargs=0 RemoveNewLines execute '%s/\\$//e | %s/\n//g'
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" Filetype-specific indentation
autocmd FileType yaml       setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType html       setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType sh         setlocal ts=4 sts=4 sw=4 expandtab
