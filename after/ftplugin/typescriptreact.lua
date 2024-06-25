local Utils = require("../../utils")

local tab_width = 2

vim.opt_local.tabstop = tab_width
vim.opt_local.softtabstop = tab_width
vim.opt_local.shiftwidth = tab_width

vim.opt.colorcolumn = "100"
-- vim.opt_local.foldmethod = 'syntax'

vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.opt_local.foldtext = "v:lua.vim.treesitter.foldtext()"
vim.opt_local.foldmethod = "expr"

Utils.nnoremap("<leader>f", ":EslintFixAll<CR>")
