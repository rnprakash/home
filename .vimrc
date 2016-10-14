set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdcommenter'
Plugin 'valloric/youcompleteme'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tomasr/molokai'

call vundle#end()
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
se breakindent

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
"map <C-n>n :NERDTreeToggle<CR>
:command Files NERDTreeToggle

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:airline#extensions#tabline#enabled = 1

colorscheme molokai
let g:molokai_original = 1
"let g:rehash256 = 1

"colorscheme desert
