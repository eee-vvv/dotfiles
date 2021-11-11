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


" PLUGINS ---------------------------------------------------------------- {{{


call plug#begin('~/.vim/plugged')

    " getting started with nvim lsp
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-buffer'

    " eslint + prettier
    Plug 'dense-analysis/ale'
    let g:ale_fixers = {
    \   'javascript': ['prettier'],
    \   'css': ['prettier'],
    \}
    let g:ale_javascript_prettier_options = '--single-quote --trailing-comma all'

    " emmet
    Plug 'mattn/emmet-vim'

    " vim fugitive
    Plug 'tpope/vim-fugitive'

    " treesitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

    Plug 'simrat39/rust-tools.nvim'

    Plug 'hrsh7th/vim-vsnip'

    Plug 'kyazdani42/nvim-tree.lua'

    " theme stuff
    Plug 'ayu-theme/ayu-vim'
    Plug 'rktjmp/lush.nvim'
    Plug 'ellisonleao/gruvbox.nvim'
    " Plug 'gruvbox-community/gruvbox'
    Plug 'junegunn/seoul256.vim'
    Plug 'jnurmine/Zenburn'
    Plug 'andreasvc/vim-256noir'
    Plug 'chase/focuspoint-vim'
    Plug 'YorickPeterse/happy_hacking.vim'
    Plug 'sts10/vim-pink-moon'
    Plug 'joshdick/onedark.vim'
    " Plug 'RRethy/nvim-base16'
    Plug 'sainnhe/sonokai'
    Plug 'folke/tokyonight.nvim'
    Plug 'sainnhe/gruvbox-material'
    Plug 'shaunsingh/nord.nvim'
    Plug 'dracula/vim'

    " tim pope plugins
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-unimpaired'
    Plug 'tpope/vim-commentary'

    " telescope 
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'

    " lualine
    Plug 'hoob3rt/lualine.nvim'
    Plug 'ryanoasis/vim-devicons'
    
    " a glow prview for markdown in buffer
    Plug 'ellisonleao/glow.nvim'

    Plug 'akinsho/bufferline.nvim'
    Plug 'lewis6991/gitsigns.nvim'

    " Autotags for html, jsx, tsx, etc.
    Plug 'windwp/nvim-ts-autotag'

call plug#end()

filetype plugin indent on

set termguicolors
let ayucolor="mirage"
let g:seoul256_background = 235
set background=dark

let g:tokyonight_style = "night"


colorscheme tokyonight
highlight Comment cterm=italic gui=italic

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

"Treesitter lua
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
  autotag = {
    enable = true,
  },
}
EOF

" RUST LSP SETUP

"autocomplete stuff
set completeopt=menuone,noinsert,noselect
set shortmess+=c

" configure LSP through rust-tools.nvim plugin
lua <<EOF
require'lspconfig'.tsserver.setup{}
require'lspconfig'.dockerls.setup{}
require'lspconfig'.pyright.setup{}
require'lspconfig'.html.setup{}
require'lspconfig'.cssls.setup{}
require'lspconfig'.diagnosticls.setup{}
require'lspconfig'.emmet_ls.setup{}
require'lspconfig'.eslint.setup{}
require'lspconfig'.graphql.setup{}
require'lspconfig'.jsonls.setup{}
require'lspconfig'.rls.setup{}
require'lspconfig'.tailwindcss.setup{}


local nvim_lsp = require'lspconfig'

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}

require('rust-tools').setup(opts)
EOF

" Setup Completion
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
lua <<EOF
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})
EOF

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
let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ] "empty by default
let g:nvim_tree_gitignore = 1 "0 by default
let g:nvim_tree_quit_on_open = 1 "0 by default, closes the tree when you open a file
let g:nvim_tree_highlight_opened_files = 1 "0 by default, will enable folder and file icon highlight for opened files/directories.
let g:nvim_tree_symlink_arrow = ' >> ' " defaults to ' ➛ '. used as a separator between symlinks' source and target.
" Dictionary of buffer option names mapped to a list of option values that
" indicates to the window picker that the buffer's window should not be
" selectable.

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

nnoremap <C-n> :NvimTreeToggle<CR>
" NvimTreeOpen, NvimTreeClose and NvimTreeFocus are also available if you need them

lua <<EOF
require'nvim-tree'.setup() 
EOF

" glow config
let g:glow_binary_path = $HOME . "/bin"


" }}}


" MAPPINGS --------------------------------------------------------------- {{{

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


" }}}


" VIMSCRIPT -------------------------------------------------------------- {{{

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" More Vimscripts code goes here.

" }}}


" STATUS LINE ------------------------------------------------------------ {{{

" Status bar code goes here.

" }}}

