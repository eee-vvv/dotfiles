require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { "haskell" },
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
  autotag = {
    enable = true,
  },
}
