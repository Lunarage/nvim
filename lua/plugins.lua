local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Colorscheme
	{ "catppuccin/nvim" },

	-- LSP
	"neovim/nvim-lspconfig",
	-- "nvim-lua/lsp-status.nvim",
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		init = function()
			vim.cmd.normal("TSUpdate")
		end,
	},

	-- Autocompletion
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"ervandew/supertab",

	-- Formatting
	"mhartington/formatter.nvim",

	-- Trouble
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},

	-- Hover
	{ "lewis6991/hover.nvim" },

	-- Tree
	{
		"nvim-tree/nvim-tree.lua",
		keys = { { "<leader>n", "<cmd>NvimTreeToggle<cr>" }, { "<leader>N", "<cmd>NvimTreeFindFile<cr>" } },
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- Tpope
	"tpope/vim-sensible",
	"tpope/vim-commentary",
	"tpope/vim-surround",
	"tpope/vim-fugitive",

	-- Misc
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
	},

  "airblade/vim-gitgutter",

	{ "windwp/nvim-autopairs", event = "insertEnter", config = true },
	{ "HiPhish/rainbow-delimiters.nvim" },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{ "RRethy/vim-illuminate" },
	-- 'folke/which-key.nvim',
})

-- nvim-tree
require("nvim-tree").setup()

-- Lualine
require("lualine").setup({
	options = {
		theme = "catppuccin",
		icons_enabled = true,
		disabled_filetypes = {
			"NvimTree",
			"trouble",
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})

-- Formatter
require("formatter").setup({
	filetype = {
		lua = {
			require("formatter.filetypes.lua").stylua,
		},
	},
})

-- Hover
require("hover").setup({
	init = function()
		require("hover.providers.lsp")
		require("hover.providers.fold_preview")
    require('hover.providers.dictionary')
	end,
  preview_opts = { border = "single"},
  preview_window=false,
  title=true,
})
