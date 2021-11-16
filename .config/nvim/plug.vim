
" Plugged calls "{{{
" ---------------------------------------------------------------------

call plug#begin(stdpath('data') . '/plugged')
  
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
  Plug 'gruvbox-community/gruvbox'
  Plug 'junegunn/seoul256.vim'
  Plug 'jnurmine/Zenburn'
  Plug 'andreasvc/vim-256noir'
  Plug 'folke/tokyonight.nvim'
  Plug 'sainnhe/gruvbox-material'
  Plug 'shaunsingh/nord.nvim'
  Plug 'RRethy/nvim-base16'

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
"}}}

" Theme "{{{
" ---------------------------------------------------------------------

filetype plugin indent on

set termguicolors
let ayucolor="mirage"
let g:seoul256_background = 235
set background=dark

let g:tokyonight_style = "night"


colorscheme tokyonight
highlight Comment cterm=italic gui=italic

"}}}

" Imports "{{{
" ---------------------------------------------------------------------
runtime ./treesitter.lua
runtime ./lsp.lua
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
runtime ./cmp.lua

"}}}
