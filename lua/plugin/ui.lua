return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-writer.nvim",
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>" },
      { "<leader>fg", "<cmd>Telescope live_grep glob_pattern=!node_modules/**/*<cr>" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>" },
      { "<leader>fr", "<cmd>Telescope lsp_references<cr>" },
      { "gd", "<cmd>Telescope lsp_implementations<cr>" },
      { "gD", "<cmd>Telescope lsp_definitions<cr>" },
      { "z=", "<cmd>Telescope spell_suggest<cr>" },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({})
    end,
  },
  -- {
  --   "aznhe21/actions-preview.nvim",
  --   dependencies = { "nvim-telescope/telescope.nvim" },
  --   config = function()
  --     vim.keymap.set({ "n" }, "L", require("actions-preview").code_actions)
  --   end,
  -- },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "┃" },
          change = { text = "┋" },
          delete = { text = "▁" },
          topdelete = { text = "▔" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        signs_staged = {
          add = { text = "┃" },
          change = { text = "┋" },
          delete = { text = "▁" },
          topdelete = { text = "▔" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        on_attach = function(bufnr)
          local gitsigns = require("gitsigns")

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then
              vim.cmd.normal({ "]c", bang = true })
            else
              gitsigns.nav_hunk("next")
            end
          end)

          map("n", "[c", function()
            if vim.wo.diff then
              vim.cmd.normal({ "[c", bang = true })
            else
              gitsigns.nav_hunk("prev")
            end
          end)

          -- Actions
          map("n", "<leader>hs", gitsigns.stage_hunk)
          map("n", "<leader>hr", gitsigns.reset_hunk)
          map("v", "<leader>hs", function()
            gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end)
          map("v", "<leader>hr", function()
            gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end)
          map("n", "<leader>hS", gitsigns.stage_buffer)
          map("n", "<leader>hu", gitsigns.undo_stage_hunk)
          map("n", "<leader>hR", gitsigns.reset_buffer)
          map("n", "<leader>hp", gitsigns.preview_hunk)
          map("n", "<leader>hb", function()
            gitsigns.blame_line({ full = true })
          end)
          map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
          map("n", "<leader>hd", gitsigns.diffthis)
          map("n", "<leader>hD", function()
            gitsigns.diffthis("~")
          end)
          map("n", "<leader>td", gitsigns.toggle_deleted)
          map("n", "<leader>tw", gitsigns.toggle_word_diff)
          map("n", "<Down>", gitsigns.next_hunk)
          map("n", "<Up>", gitsigns.prev_hunk)

          -- Text object
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
        end,
      })
    end,
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      -- "sindrets/diffview.nvim",        -- optional - Diff integration
      "nvim-telescope/telescope.nvim",
    },
    config = true,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin/nvim", "SmiteshP/nvim-navic" },
    config = function()
      local navic = require("nvim-navic")
      local icon_filename = require("lualine.components.filename"):extend()
      icon_filename.apply_icon = require("lualine.components.filetype").apply_icon
      icon_filename.icon_hl_cache = {}

      require("lualine").setup({
        options = {
          theme = "catppuccin",
          icons_enabled = true,
          disabled_filetypes = {
            "NvimTree",
            "trouble",
            "neotest-summary",
            "neotest-output-panel",
            "sagaoutline",
            "",
          },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = { "diagnostics" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        winbar = {
          lualine_c = {
            { icon_filename, colored = true },
            {
              function()
                return navic.get_location()
              end,
              cond = function()
                return navic.is_available()
              end,
            },
          },
        },
      })
    end,
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin/nvim", "levouh/tint.nvim" },
    config = function()
      local tint_transforms = require("tint.transforms")
      local tint_colors = require("tint.colors")
      local bufferline = require("bufferline")
      local colors = require("catppuccin.palettes").get_palette("macchiato")
      local transform_tint = tint_transforms.tint(-50)
      local transform_saturate = tint_transforms.saturate(0.4)
      local dim_color = function(hex_color)
        return tint_colors.rgb_to_hex(
          transform_saturate(transform_tint(tint_colors.hex_to_rgb(hex_color)))
        )
      end

      local error_color = colors.red
      local error_color_dim = dim_color(colors.red)
      local warning_color = colors.yellow
      local warning_color_dim = dim_color(colors.yellow)
      local info_color = colors.sapphire
      local info_color_dim = dim_color(colors.sapphire)
      local hint_color = colors.teal
      local hint_color_dim = dim_color(colors.teal)

      bufferline.setup({
        options = {
          mode = "buffers", -- set to "tabs" to only show tabpages instead
          style_preset = bufferline.style_preset.no_italic,
          themable = true,
          numbers = "none",
          indicator = {
            style = "underline",
          },
          diagnostics = "nvim_lsp",
          offsets = {
            {
              filetype = "NvimTree",
              text = "NvimTree",
              text_align = "left",
              separator = true,
            },
          },
          color_icons = true,
          separator_style = "slant",
          diagnostics_indicator = function(_, level)
            local icon = level:match("error") and " "
              or level:match("warning") and " "
              or level:match("info") and " "
              or level:match("hint") and " "
              or " "
            return " " .. icon
          end,
        },
        highlights = {
          fill = { fg = colors.text, bg = colors.mantle },
          background = { bg = colors.base },
          buffer_visible = { bg = colors.base },
          buffer_selected = { bg = colors.surface0, bold = true, italic = false },
          tab = { bg = colors.base },
          tab_selected = { bg = colors.surface0, bold = true, italic = false },
          tab_separator = { fg = colors.mantle, bg = colors.base },
          tab_separator_selected = { fg = colors.mantle, bg = colors.surface0, bold = true },
          tab_close = { bg = colors.base },
          close_button = { bg = colors.base },
          close_button_visible = { bg = colors.base },
          close_button_selected = { bg = colors.surface0 },
          modified = { bg = colors.base },
          modified_visible = { bg = colors.base },
          modified_selected = { bg = colors.surface0 },
          duplicate = { fg = colors.surface2, bg = colors.base },
          duplicate_visible = { fg = colors.surface2, bg = colors.base },
          duplicate_selected = { fg = colors.subtext0, bg = colors.surface0, bold = true },
          diagnostic = { bg = colors.base },
          diagnostic_visible = { bg = colors.base },
          diagnostic_selected = { bg = colors.surface0, bold = true },
          error = { bg = colors.base, fg = error_color_dim },
          error_visible = { bg = colors.base, fg = error_color_dim },
          error_selected = { bg = colors.surface0, fg = error_color, bold = true },
          error_diagnostic = { bg = colors.base, fg = error_color_dim },
          error_diagnostic_visible = { bg = colors.base, fg = error_color_dim },
          error_diagnostic_selected = { bg = colors.surface0, fg = error_color, bold = true },
          warning = { bg = colors.base, fg = warning_color_dim },
          warning_visible = { bg = colors.base, fg = warning_color_dim },
          warning_selected = { bg = colors.surface0, fg = warning_color, bold = true },
          warning_diagnostic = { bg = colors.base, fg = warning_color_dim },
          warning_diagnostic_visible = { bg = colors.base, fg = warning_color_dim },
          warning_diagnostic_selected = { bg = colors.surface0, fg = warning_color, bold = true },
          info = { bg = colors.base, fg = info_color_dim },
          info_visible = { bg = colors.base, fg = info_color_dim },
          info_selected = { bg = colors.surface0, fg = info_color, bold = true },
          info_diagnostic = { bg = colors.base, fg = info_color_dim },
          info_diagnostic_visible = { bg = colors.base, fg = info_color_dim },
          info_diagnostic_selected = { bg = colors.surface0, fg = info_color, bold = true },
          hint = { bg = colors.base, fg = hint_color_dim },
          hint_visible = { bg = colors.base, fg = hint_color_dim },
          hint_selected = { bg = colors.surface0, fg = hint_color, bold = true },
          hint_diagnostic = { bg = colors.base, fg = hint_color_dim },
          hint_diagnostic_visible = { bg = colors.base, fg = hint_color_dim },
          hint_diagnostic_selected = { bg = colors.surface0, fg = hint_color, bold = true },
          separator = { fg = colors.mantle, bg = colors.base },
          separator_visible = { fg = colors.mantle, bg = colors.base },
          separator_selected = { fg = colors.mantle, bg = colors.surface0, bold = true },
        },
      })
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        "*",
        css = { names = true },
        html = { names = true },
      }, {
        RGB = true,
        RRGGBB = true,
        names = false,
        RRGGBBAA = true,
        rgb_fn = true,
        hsl_fn = true,
        css = true,
        css_fn = true,
      })
    end,
  },
  {
    "nvim-zh/colorful-winsep.nvim",
    config = true,
    event = { "WinLeave" },
  },
}
