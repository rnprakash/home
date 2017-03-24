set nocompatible
filetype off
filetype plugin indent on

set ts=4
set sw=4
set ai
set smarttab
set smartindent
set expandtab
syntax on
set number
se nojoinspaces
nnoremap <space> :noh<return><space>
map <Up> gk
map <Down> gj
se formatoptions+=r

set history=50
set ruler
set incsearch
set backspace=2 " make backspace work like most other apps

" Note, perl automatically sets foldmethod in the syntax file
autocmd Filetype c,cpp,vim,xml,html,xhtml setlocal foldmethod=indent
autocmd Filetype c,cpp,vim,xml,html,xhtml,perl normal zR

" Paste plain - don't auto indent or comment
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ""
endfunction

"autocmd vimenter * NERDTree
autocmd vimenter * wincmd p
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

function! LatexFormat(start, end)
    silent execute a:start.','.a:end.'s/[.!?]\zs /\r/g'
endfunction

"au BufRead,BufNewFile *.tex set textwidth=80
au Filetype tex,md set formatexpr=LatexFormat(v:lnum,v:lnum+v:count-1)
au BufRead,BufNewFile *.md,*.txt setlocal spell spelllang=en_us

syntax on
colorscheme molokai
