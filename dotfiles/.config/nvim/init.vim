" Use space as leader
" Ref: https://stackoverflow.com/a/446293
noremap <SPACE> <Nop>
let mapleader=" "

" Moving up and down faster in normal mode
map J 5j
map K 5k
" Remap joining lines
noremap <Leader>j J

" Easier switching between splits
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Easier tab handling
nnoremap <Leader>tt :tabnew<cr>
nnoremap <Leader>tn :tabnext<cr>
nnoremap <Leader>tp :tabprevious<cr>
nnoremap <Leader>to :tabonly<cr>

" Clean highlighted text
nnoremap <Leader>/ :nohlsearch<cr>

" References:
" - https://www.barbarianmeetscoding.com/boost-your-coding-fu-with-vscode-and-vim/elevating-your-worflow-with-custom-mappings

