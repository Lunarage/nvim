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
        reload_on_bufenter = true,
        -- hijack_unnamed_buffer_when_opening = true,
        sort = {
          sorter = "case_sensitive",
        },
        diagnostics = {
          enable = true,
        },
        view = {
          signcolumn = "auto",
          width = 32,
          preserve_window_proportions = true,
        },
        renderer = {
          add_trailing = true,
          indent_width = 1,
          special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "package.json" },
          symlink_destination = false,
          highlight_git = "name",
          highlight_diagnostics = "all",
          highlight_opened_files = "icon",
          highlight_modified = "name",
          highlight_bookmarks = "name",
          highlight_clipboard = "name",
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
            git_placement = "after",
            modified_placement = "after",
            diagnostics_placement = "after",
            bookmarks_placement = "signcolumn",
            padding = " ",
            symlink_arrow = " ➛ ",
            show = {
              file = true,
              folder = true,
              folder_arrow = false,
              git = true,
              modified = true,
              diagnostics = true,
            },
            glyphs = {
              default = " ",
              symlink = " ",
              bookmark = "󰆤 ",
              modified = "● ",
              folder = {
                arrow_closed = " ",
                arrow_open = " ",
                default = " ",
                open = " ",
                empty = " ",
                empty_open = " ",
                symlink = " ",
                symlink_open = " ",
              },
              git = {
                unstaged = "●",
                staged = "✓",
                unmerged = "",
                renamed = "➜",
                untracked = "★",
                deleted = "󰗨",
                ignored = "◌",
              },
            },
          },
        },
        filters = {
          enable = true,
          git_ignored = false,
          dotfiles = false,
          custom = { "^\\.git" },
        },
      })
    end,
  },
}
