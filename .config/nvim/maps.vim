"LEADER
nnoremap <SPACE> <Nop>
let mapleader=" "

" save buffer to disk
map <silent> <leader>s :w<CR>

" open init.vim quickly
map <leader>v :sp ~/.config/nvim/init.vim

" in : command-line prompt, expand to path of active buffer
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" switch between splits
nnoremap <leader>w <C-w>w

" paste from mac clipboard
nnoremap <silent> <leader>p "+gP

" remove highlights after searching
nnoremap <silent> <leader>h :noh<CR>

" open up two brackets, parens, etc. with space in the middle
nnoremap <silent> <leader>o i<cr><esc>O

" format current buffer
nnoremap <silent> ff <cmd>lua vim.lsp.buf.formatting()<CR>
" for REACT DEV
nnoremap <leader>fj :ALEFix<cr>
