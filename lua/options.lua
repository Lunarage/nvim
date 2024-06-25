if IS_WINDOWS then
	vim.cmd("language en_US")
end
local tab_width = 2

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.tabstop = tab_width
vim.opt.softtabstop = tab_width
vim.opt.shiftwidth = tab_width
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.relativenumber = true
vim.opt.wildmode = "longest,list"
vim.opt.cc = "120"
vim.opt.foldlevel = 99

vim.opt.clipboard = "unnamedplus"

vim.opt.list = true

vim.opt.updatetime = 500

local space = "·"
vim.opt.listchars:append({
	space = space,
	multispace = space,
	lead = space,
	trail = space,
	nbsp = space,
	tab = "|-",
	extends = "›",
	precedes = "‹",
})

local _border = "single"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = _border,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = _border,
})

vim.diagnostic.config({
	float = { border = _border },
})
