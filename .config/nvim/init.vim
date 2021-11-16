" EVAN'S INIT.VIM


" Basics "{{{
" -------------------------------------------------------------------
" Disable compatibility with vi which can cause unexpected issues
set nocompatible

"Enable type file detection. Vim will be able to try to detect the type of the
"file in use.
filetype on

"Enable plugins and load plugin for the detected filetype
filetype plugin on

"Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on
syntax enable

" Add numbers to each line on the left-hand side
set number
set relativenumber
set signcolumn=yes

" Set shift width to 4 spaces.
set shiftwidth=2

" Set tab width to 4 columns.
set tabstop=2

" Use space characters instead of tabs
set expandtab

" >> indents to next multiple of 'shiftwidth'
set shiftround

set backspace   =indent,eol,start  " Make backspace work as you would expect.
set whichwrap+=<,>,h,l


set ttyfast                " Faster redrawing.
set lazyredraw             " Only redraw when necessary.

set wrapscan               " Searches wrap around end-of-file.

set report      =0         " Always report changed lines.

" Do not save backup files
set nobackup
set nowritebackup

" Do not wrap lines
set nowrap

" While searching through file, incrementally highlight matching characters as
" you type
set incsearch

" Ignore capital letters during search
set ignorecase

"Override above if searching for capitals
set smartcase
set smarttab
set smartindent
set autoindent
set showtabline=4

" Show partial command you type in the last line of the screen
set showcmd

" Show mode on last line
set showmode

" Show matching words during a search
set showmatch
" how many tenths of a second to blink when matching brackets
set mat=2

" Use highlighting when doing a search
set hlsearch

" for regular expressions turn magic on
set magic

set history=500

" File search autocompletion
set wildmenu
set wildmode=list:longest

" required to keep multiple buffers open
set hidden

set encoding=utf-8

set cmdheight=2

set splitbelow
set splitright

" support 256 colors
set t_Co=256

" Turn off backups, since most stuff is in SVN, git etc anyways
set nobackup
set nowb
set noswapfile

" linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indents

" always show 3 lines between cursor and top/bottom of view
set scrolloff=3

set cursorline

" HELPER FUNCTIONS

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction
"}}}


" Imports "{{{
" ---------------------------------------------------------------------
runtime ./plug.vim
if has("unix")
  let s:uname = system("uname -s")
  " Do Mac stuff
  if s:uname == "Darwin\n"
    runtime ./macos.vim
  endif
endif

runtime ./maps.vim
"}}}


" Plugins "{{{
" ---------------------------------------------------------------------

" git signs lua
lua << EOF
require('gitsigns').setup()
EOF

" Statusline and bufferline lua
lua << EOF
require('lualine').setup {
  options = {theme = 'tokyonight'}
}

require("bufferline").setup{}
EOF

" RUST LSP SETUP

"autocomplete stuff
set completeopt=menuone,noinsert,noselect
set shortmess+=c

" Code navigation shortcuts
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=1000
" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" nvim-tree setup
let g:nvim_tree_gitignore = 1 "0 by default

" default will show icon by default if no icon is provided
" default shows no icon by default
let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'arrow_open': "",
    \   'arrow_closed': "",
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   },
    \   'lsp': {
    \     'hint': "",
    \     'info': "",
    \     'warning': "",
    \     'error': "",
    \   }
    \ }

" nnoremap <C-n> :NvimTreeToggle<CR>
" " NvimTreeOpen, NvimTreeClose and NvimTreeFocus are also available if you need them

" lua <<EOF
" require'nvim-tree'.setup() 
" EOF

" glow config
let g:glow_binary_path = $HOME . "/bin"


" }}}


" VimScript "{{{
" ---------------------------------------------------------------------

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" More Vimscripts code goes here.

" }}}
