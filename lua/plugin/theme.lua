local hi_overrides = function(colors)
  -- local tint_transforms = require("tint.transforms")
  -- local tint_colors = require("tint.colors")
  -- local dim_color = function(hex_color, tint, saturate)
  --   local transform_tint = tint_transforms.tint(tint)
  --   local transform_saturate = tint_transforms.saturate(saturate)
  --   return tint_colors.rgb_to_hex(
  --     transform_saturate(transform_tint(tint_colors.hex_to_rgb(hex_color)))
  --   )
  -- end
  -- local dimmed_diff_red = dim_color(colors.red, -90, 0.4);
  -- local dimmed_diff_green = dim_color(colors.green, -95, 0.5);
  -- local dimmed_diff_yellow = dim_color(colors.yellow, -95, 0.5);
  -- local dimmed_diff_text = dim_color(colors.yellow, -80, 0.45);
  return {
    WhiteSpace = { fg = colors.surface0, bold = false },
    NormalFloat = { bg = colors.base },
    FloatBorder = { bg = colors.base, fg = colors.text },
    GitGutterAdd = { fg = colors.green, bold = true },
    GitGutterChange = { fg = colors.yellow, bold = true },
    GitGutterDelete = { fg = colors.red, bold = true },
    GitGutterChangeDeleteLine = {
      fg = colors.red,
      bold = true,
    },
    -- DiffAdd = { bg = dimmed_diff_green},
    -- DiffDelete = { bg = dimmed_diff_red },
    -- DiffChange = { bg = dimmed_diff_yellow},
    -- DiffText = { bg = dimmed_diff_text },
    Folded = { fg = colors.mauve },
    IlluminatedWordText = { underline = true },
    IlluminatedWordWrite = { underline = true },
    IlluminatedWordRead = { underline = true },
    RainbowDelimiterRed = { fg = colors.red },
    RainbowDelimiterYellow = { fg = colors.yellow },
    RainbowDelimiterBlue = { fg = colors.blue },
    RainbowDelimiterOrange = { fg = colors.peach },
    RainbowDelimiterGreen = { fg = colors.green },
    RainbowDelimiterViolet = { fg = colors.mauve },
    RainbowDelimiterCyan = { fg = colors.sky },
    NavicIconsFile = { fg = colors.mauve, bg = nil },
    NavicIconsModule = { fg = colors.mauve, bg = nil },
    NavicIconsNamespace = { fg = colors.mauve, bg = nil },
    NavicIconsPackage = { fg = colors.mauve, bg = nil },
    NavicIconsClass = { fg = colors.mauve, bg = nil },
    NavicIconsMethod = { fg = colors.mauve, bg = nil },
    NavicIconsProperty = { fg = colors.red, bg = nil },
    NavicIconsField = { fg = colors.mauve, bg = nil },
    NavicIconsConstructor = { fg = colors.mauve, bg = nil },
    NavicIconsEnum = { fg = colors.mauve, bg = nil },
    NavicIconsInterface = { fg = colors.yellow, bg = nil },
    NavicIconsFunction = { fg = colors.mauve, bg = nil },
    NavicIconsVariable = { fg = colors.mauve, bg = nil },
    NavicIconsConstant = { fg = colors.mauve, bg = nil },
    NavicIconsString = { fg = colors.mauve, bg = nil },
    NavicIconsNumber = { fg = colors.mauve, bg = nil },
    NavicIconsBoolean = { fg = colors.mauve, bg = nil },
    NavicIconsArray = { fg = colors.mauve, bg = nil },
    NavicIconsObject = { fg = colors.mauve, bg = nil },
    NavicIconsKey = { fg = colors.mauve, bg = nil },
    NavicIconsNull = { fg = colors.mauve, bg = nil },
    NavicIconsEnumMember = { fg = colors.mauve, bg = nil },
    NavicIconsStruct = { fg = colors.mauve, bg = nil },
    NavicIconsEvent = { fg = colors.mauve, bg = nil },
    NavicIconsOperator = { fg = colors.mauve, bg = nil },
    NavicIconsTypeParameter = { fg = colors.mauve, bg = nil },
    NavicText = { fg = colors.text, bg = nil },
    NavicSearator = { fg = colors.text, bg = nil },
  }
end

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
          all = hi_overrides,
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
        tint = -50,                                                                -- Darken colors, use a positive value to brighten
        saturation = 0.4,                                                          -- Saturation to preserve
        transforms = require("tint").transforms.SATURATE_TINT,                     -- Showing default behavior, but value here can be predefined set of transforms
        -- tint_background_colors = true, -- Tint background portions of highlight groups
        highlight_ignore_patterns = { "WinSeparator", "Status.*", "BufferLine*" }, -- Highlight group patterns to ignore, see `string.find`
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
