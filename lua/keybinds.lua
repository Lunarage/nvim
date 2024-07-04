local utils = require("utils")

local nnoremap = utils.nnoremap
-- local vnoremap = Utils.vnoremap
-- local xnoremap = Utils.xnoremap
-- local inoremap = Utils.inoremap

nnoremap("<Up>", "<NOP>")
nnoremap("<Down>", "<NOP>")
nnoremap("<Left>", "<NOP>")
nnoremap("<Right>", "<NOP>")

nnoremap("<C-j>", "<C-W>j")
nnoremap("<C-k>", "<C-W>k")
nnoremap("<C-h>", "<C-W>h")
nnoremap("<C-l>", "<C-W>l")

nnoremap("j", "gj")
nnoremap("k", "gk")

nnoremap("<Left>", ":bprev<CR>")
nnoremap("<Right>", ":bnext<CR>")

nnoremap("<C-Space>", "za")

nnoremap("<c-h>", "<cmd>TmuxNavigateLeft<cr>")
nnoremap("<c-j>", "<cmd>TmuxNavigateDown<cr>")
nnoremap("<c-k>", "<cmd>TmuxNavigateUp<cr>")
nnoremap("<c-l>", "<cmd>TmuxNavigateRight<cr>")
nnoremap("<c-\\>", "<cmd>TmuxNavigatePrevious<cr>")

nnoremap("<leader>f", ":Format<CR>")
nnoremap("<leader>bd", ":bp|bd #<CR>")

nnoremap("<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>")
nnoremap("L", "<cmd>lua vim.lsp.buf.code_action()<cr>")

vim.api.nvim_set_keymap(
    "n",
    "gD",
    "<cmd>lua vim.lsp.buf.declaration()<CR>",
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "n",
    "gd",
    "<cmd>lua vim.lsp.buf.definition()<CR>",
    { noremap = true, silent = true }
)
