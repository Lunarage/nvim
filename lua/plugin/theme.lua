local hi_overrides = function(colors)
  return {
    NormalFloat = { bg = colors.base },
    ["@comment.todo"] = { bg = colors.mauve },
    ["@function.builtin"] = { fg = colors.blue, italic = true },
    ["@lsp.type.interface"] = { fg = colors.flamingo, italic = true },
    ["@lsp.type.type"] = { fg = colors.yellow, italic = true },
    ["@module"] = { fg = colors.yellow, italic = true },
    ["@parameter"] = { fg = colors.maroon, italic = true },
    ["@variable.jsdoc"] = { fg = colors.maroon, italic = true },
    ["@property"] = { fg = colors.lavender },
    ["@tag.attribute.tsx"] = { fg = colors.yellow, style = {} },
    ["@tag.builtin.tsx"] = { fg = colors.blue },
    ["@type.builtin"] = { fg = colors.mauve },
    Function = { fg = colors.blue, italic = true },
    FloatBorder = { bg = colors.base, fg = colors.text },
    dcDiffAdd = { bg = colors.base, fg = colors.green },
    DiffAdd = { bg = colors.base, fg = colors.green },
    DiffAdded = { bg = colors.base, fg = colors.green },
    dcDiffDelete = { bg = colors.base, fg = colors.red },
    DiffDelete = { bg = colors.base, fg = colors.red },
    dcDiffDelEdge = { bg = colors.base, fg = colors.red },
    dcDiffChange = { bg = colors.base, fg = colors.peach },
    DiffChange = { bg = colors.base, fg = colors.peach },
    DiffChanged = { bg = colors.base, fg = colors.peach },
    dcDiffText = { bg = colors.base, fg = colors.overlay2 },
    DiffText = { bg = colors.base, fg = colors.overlay2 },
    dcDiffLine = { bg = colors.base, fg = colors.overlay2 },
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
    NvimTreeGitNewIcon = { fg = colors.yellow },
    NvimTreeGitRenamedIcon = { fg = colors.yellow },
    NvimTreeGitDeletedIcon = { fg = colors.red },
    NvimTreeGitMergeIcon = { fg = colors.peach },
    NvimTreeGitDirtyIcon = { fg = colors.peach },
    NvimTreeGitStagedIcon = { fg = colors.green },
    NvimTreeGitIgnoredIcon = { fg = colors.overlay1 },
  }
end

return {
  {
    "catppuccin/nvim",
    config = function()
      local colors = require("catppuccin.palettes").get_palette("macchiato")
      require("catppuccin").setup({
        flavour = "macchiato",
        transparent_background = true,
        no_italic = false,
        no_bold = false,
        no_underline = false,
        color_overrides = hi_overrides(colors),
        custom_highlights = hi_overrides,
        default_integrations = true,
        integrations = {
          cmp = true,
          gitsigns = true,
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
