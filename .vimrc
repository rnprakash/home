au BufRead,BufNewFile *.tex set textwidth=80
au BufRead,BufNewFile *.txt setlocal spell spelllang=en_us
colorscheme desert
se expandtab
se shiftwidth=4
se backspace=2
se tabstop=4
se nu
se nowrap
se nojoinspaces
nnoremap <space> :noh<return><space>
map <Up> gk
map <Down> gj
se formatoptions+=r
se breakindent
syntax on
