local tab_width = 2

vim.opt_local.tabstop = tab_width
vim.opt_local.softtabstop = tab_width
vim.opt_local.shiftwidth = tab_width

vim.opt_local.colorcolumn = "100"

vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt_local.foldmethod = "expr"

vim.opt_local.spell = true
vim.opt_local.conceallevel = 2
