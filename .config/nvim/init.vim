"
" .vimrc file.
" Written by: Milo Gertjejansen
"

" Set the leader key to space.
let mapleader = " "

set background=dark

" vim-plug
call plug#begin('~/.config/nvim/plugged')
Plug 'elmcast/elm-vim'
Plug 'w0rp/ale'
Plug 'python/black'
Plug 'rust-lang/rust.vim'
Plug 'roxma/python-support.nvim'
Plug 'vim-python/python-syntax'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
call plug#end()


" ALE
let g:ale_completion_enabled = 1

" Splitting.
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

" Enable modelines.
set nocompatible
filetype plugin on
set modeline

" Enable syntax highlighting.
"colorscheme nofrils-dark

" Encoding.
set encoding=utf-8

" Set line numbers.
set number
set relativenumber

" Setup proper tabs.
set expandtab
set tabstop=4 shiftwidth=4
set softtabstop=4

" Searching.
set hlsearch
set incsearch
set ignorecase
set smartcase

" Remap the arrow keys to do nothing.
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>

" Remap j/k to gj/gk but only when we are not counting.
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Folding.
set foldmethod=indent   " Fold based on indent.
set foldnestmax=10      " Deepest fold is 10 levels.
set nofoldenable        " Don't fold by default.
set foldlevel=1         " This is just what I use.

" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
        \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

" Twiddle case by highlighting text and hitting ~
function! TwiddleCase(str)
  if a:str ==# toupper(a:str)
    let result = tolower(a:str)
  elseif a:str ==# tolower(a:str)
    let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
  else
    let result = toupper(a:str)
  endif
  return result
endfunction
vnoremap ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv

" Special language stuff.
autocmd! BufNewFile,BufReadPre,FileReadPre Makefile source ~/.vim/langs/makefile.vim
autocmd BufWritePre *.py execute ':Black'
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2

" Backspace.
set backspace=2

" Undo file to maintain undo's between runs.
set undodir=~/.config/nvim/undodir
set undofile

" y/p uses system clipboard now.
set clipboard+=unnamed

" True colors.
set termguicolors

" ALE nav to next errors
nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>

" Black location
let g:black_virtualenv = "~/.config/nvim/blackvenv"

" Python syntax
let g:python_highlight_all = 1
