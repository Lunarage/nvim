return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-writer.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>" },
      { "<leader>fr", "<cmd>Telescope lsp_references<cr>" },
      { "gd", "<cmd>Telescope lsp_implementations<cr>" },
      { "gD", "<cmd>Telescope lsp_definitions<cr>" },
      { "z=", "<cmd>Telescope spell_suggest<cr>" },
    },
    config = function()
      local telescope = require("telescope")
      local lga_actions = require("telescope-live-grep-args.actions")

      telescope.setup({
        extensions = {
          live_grep_args = {
            auto_quoting = true, -- enable/disable auto-quoting
            -- define mappings, e.g.
            mappings = { -- extend mappings
              i = {
                ["<C-k>"] = lga_actions.quote_prompt(),
                ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                -- freeze the current list and start a fuzzy search in the frozen list
                -- ["<C-space>"] = actions.to_fuzzy_refine,
              },
            },
            -- ... also accepts theme settings, for example:
            -- theme = "dropdown", -- use dropdown theme
            -- theme = { }, -- use own theme spec
            -- layout_config = { mirror=true }, -- mirror preview pane
          },
        },
      })

      telescope.load_extension("live_grep_args")
    end,
  },
  {
    "aznhe21/actions-preview.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      vim.keymap.set({ "n" }, "L", require("actions-preview").code_actions)
    end,
  },
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

          -- Text object
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
        end,
      })
    end,
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
    "b0o/incline.nvim",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
      "lewis6991/gitsigns.nvim",
    },
    config = function()
      local helpers = require("incline.helpers")
      local navic = require("nvim-navic")
      local devicons = require("nvim-web-devicons")
      local colors = require("catppuccin.palettes").get_palette("macchiato")
      local U = require("../utils")
      local h, _, _ = U.rgbToHsl(U.hexToRgb(colors.blue))
      local bg = U.rgbToHex(U.hslToRgb(h, 0.25, 0.25))

      require("incline").setup({
        window = {
          padding = 0,
          margin = { horizontal = 0, vertical = 0 },
          placement = { horizontal = "left" },
          width = "fill",
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if filename == "" then
            filename = "[No Name]"
          end
          local ft_icon, ft_color = devicons.get_icon_color(filename)

          local function get_git_diff()
            local icons = { removed = " ", changed = " ", added = " " }
            local signs = vim.b[props.buf].gitsigns_status_dict
            local labels = {}
            if signs == nil then
              return labels
            end
            for name, icon in pairs(icons) do
              if tonumber(signs[name]) and signs[name] > 0 then
                table.insert(labels, { icon .. signs[name] .. " ", group = "Diff" .. name })
              end
            end
            if #labels > 0 then
              table.insert(labels, { "┊ " })
            end
            return labels
          end

          local modified = vim.bo[props.buf].modified
          local res = {
            { get_git_diff() },
            ft_icon
                and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) }
              or "",
            " ",
            { filename, gui = modified and "bold,italic" or "bold" },
            guibg = bg,
          }
          if props.focused and navic.is_available(props.buf) then
            for _, item in ipairs(navic.get_data(props.buf) or {}) do
              vim.api.nvim_win_get_width(0)
              table.insert(res, {
                { " > ", group = "NavicSeparator" },
                { item.icon, group = "NavicIcons" .. item.type },
                { item.name, group = "NavicText" },
              })
            end
          end
          table.insert(res, " ")
          return res
        end,
      })
    end,
  },
}
