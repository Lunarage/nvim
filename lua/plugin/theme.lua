return {
  {
    "catppuccin/nvim",
    config = function()
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
              GitGutterAdd = { fg = colors.green, bold = true },
              GitGutterChange = { fg = colors.yellow, bold = true },
              GitGutterDelete = { fg = colors.red, bold = true },
              GitGutterChangeDeleteLine = {
                fg = colors.red,
                bold = true,
              },
              Folded = { fg = colors.mauve },
              IlluminatedWordText = { underline = true },
              IlluminatedWordWrite = { underline = true },
              IlluminatedWordRead = { underline = true },
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
    end,
  },
  {
    "levouh/tint.nvim",
    config = function()
      require("tint").setup({
        tint = -50, -- Darken colors, use a positive value to brighten
        saturation = 0.4, -- Saturation to preserve
        transforms = require("tint").transforms.SATURATE_TINT, -- Showing default behavior, but value here can be predefined set of transforms
        -- tint_background_colors = true, -- Tint background portions of highlight groups
        highlight_ignore_patterns = { "WinSeparator", "Status.*" }, -- Highlight group patterns to ignore, see `string.find`
        window_ignore_function = function(winid)
          local bufid = vim.api.nvim_win_get_buf(winid)
          local buftype = vim.api.nvim_buf_get_option(bufid, "buftype")
          local floating = vim.api.nvim_win_get_config(winid).relative ~= ""

          -- Do not tint `terminal` or floating windows, tint everything else
          return buftype == "terminal" or floating
        end,
      })
    end,
  },
}
