return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>" },
    },
  },
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
  {
    "airblade/vim-gitgutter",
    init = function()
      vim.cmd([[let g:gitgutter_sign_added = '▕']])
      vim.cmd([[let g:gitgutter_sign_modified = '▕']])
      vim.cmd([[let g:gitgutter_sign_removed = '▕']])
      vim.cmd([[let g:gitgutter_sign_removed_first_line = '▕']])
      vim.cmd([[let g:gitgutter_sign_removed_above_and_below = '▕']])
      vim.cmd([[let g:gitgutter_sign_modified_removed = '▕']])
    end,
  },
  { "windwp/nvim-autopairs", event = "insertEnter", config = true },
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")
      require("rainbow-delimiters.setup").setup({
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          javascript = rainbow_delimiters.strategy["local"],
          typescriptreact = rainbow_delimiters.strategy["local"],
          typescript = rainbow_delimiters.strategy["local"],
          vim = rainbow_delimiters.strategy["local"],
          lua = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
          tsx = "rainbow-parens",
          typescript = "rainbow-parens",
          javascript = "rainbow-parens",
        },
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin/nvim", "SmiteshP/nvim-navic" },
    config = function()
      local navic = require('nvim-navic')
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
        winbar = {
          lualine_c = {
            {
              function()
                return navic.get_location()
              end,
              cond = function()
                return navic.is_available()
              end
            },
          },
        },
      })
    end,
  },
}
