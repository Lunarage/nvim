local Utils = require("utils")

local nnoremap = Utils.nnoremap
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

nnoremap("<Left>", ":tabp<CR>")
nnoremap("<Right>", ":tabn<CR>")

-- Remove highlight with enter
nnoremap("<CR>", ":noh<CR><CR>")

nnoremap("<Space>", "za")

nnoremap("<c-h>", "<cmd>TmuxNavigateLeft<cr>")
nnoremap("<c-j>", "<cmd>TmuxNavigateDown<cr>")
nnoremap("<c-k>", "<cmd>TmuxNavigateUp<cr>")
nnoremap("<c-l>", "<cmd>TmuxNavigateRight<cr>")
nnoremap("<c-\\>", "<cmd>TmuxNavigatePrevious<cr>")

nnoremap("<leader>f", ":Format<CR>")
