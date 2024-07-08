return {
  {
    "nvim-tree/nvim-tree.lua",
    keys = {
      { "<leader>n", "<cmd>NvimTreeToggle<cr>" },
      { "<leader>N", "<cmd>NvimTreeFindFile<cr>" },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        diagnostics = {
          enable = true,
        },
        view = {
          signcolumn = "yes",
        },
        renderer = {
          indent_width = 2,
          highlight_git = "name",
          highlight_diagnostics = "name",
          highlight_opened_files = "name",
          highlight_modified = "name",
          highlight_bookmarks = "name",
          indent_markers = {
            enable = true,
            inline_arrows = true,
            icons = {
              corner = "└",
              edge = "│",
              item = "│",
              bottom = "─",
              none = " ",
            },
          },
          icons = {
            web_devicons = {
              file = {
                enable = true,
                color = true,
              },
              folder = {
                enable = true,
                color = true,
              },
            },
            git_placement = "signcolumn",
            modified_placement = "signcolumn",
            diagnostics_placement = "signcolumn",
            bookmarks_placement = "signcolumn",
            padding = " ",
            symlink_arrow = " ➛ ",
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
              modified = true,
              diagnostics = true,
              bookmarks = true,
            },
            glyphs = {
              default = "",
              symlink = "",
              bookmark = "󰆤",
              modified = "●",
              folder = {
                arrow_closed = "",
                arrow_open = "",
                default = "",
                open = "",
                empty = "",
                empty_open = "",
                symlink = "",
                symlink_open = "",
              },
              git = {
                unstaged = "●",
                staged = "●",
                unmerged = "",
                renamed = "➜",
                untracked = "★",
                deleted = "●",
                ignored = "◌",
              },
            },
          },
        },
      })
    end,
  },
}
