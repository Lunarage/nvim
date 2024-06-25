require("catppuccin").setup({
	flavour = "macchiato",
	transparent_background = true,
	no_italic = false,
	no_bold = false,
	no_underline = false,
	highlight_overrides = {
		all = function(colors)
			return {
				NormalFloat = { bg = colors.base },
				FloatBorder = { bg = colors.base, fg = colors.text },
				GitGutterAdd = { bg = colors.green, fg = colors.crust, bold = true  },
				GitGutterChange = { bg = colors.yellow, fg = colors.crust, bold = true },
				GitGutterDelete = { bg = colors.red, fg = colors.crust, bold = true  },
				GitGutterChangeDeleteLine = { bg = colors.red, fg = colors.crust, bold = true  },
			}
		end,
	},
	default_integrations = true,
	integrations = {
		cmp = true,
		nvimtree = true,
		treesitter = true,
		rainbow_delimiters = true,
		lsp_trouble = true,
		illuminate = {
			enabled = true,
			lsp = true,
		},
		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
				ok = { "italic" },
			},
			underlines = {
				errors = { "undercurl" },
				hints = { "undercurl" },
				warnings = { "undercurl" },
				information = { "undercurl" },
				ok = { "undercurl" },
			},
			inlay_hints = {
				background = true,
			},
		},
	},
})

vim.cmd.colorscheme("catppuccin")
