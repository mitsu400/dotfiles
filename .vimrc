"
" .vimrc file.
" Written by: Milo Gertjejansen
"

" vim-plug
call plug#begin('~/.vim/plugged')

" Enable modelines.
set nocompatible
filetype plugin on
set modeline

" Enable syntax highlighting.
colorscheme nofrils-dark

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

" Special language stuff.
autocmd! BufNewFile,BufReadPre,FileReadPre Makefile source ~/.vim/langs/makefile.vim

