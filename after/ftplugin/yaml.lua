local Utils = require("../../utils")

vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt_local.foldmethod = 'expr'

vim.opt_local.colorcolumn = "100"

Utils.nnoremap("<leader>f", ":Format<CR>")
