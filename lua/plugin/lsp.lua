return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "SmiteshP/nvim-navic",
      "williamboman/mason-lspconfig.nvim",
      "lukas-reineke/lsp-format.nvim",
    },
    config = function()
      local navic = require("nvim-navic")
      local lspconfig = require("lspconfig")
      local capabilities =
        require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

      local lsp_list = {
        "bashls",
        "clangd",
        "cmake",
        "cssls",
        "dockerls",
        "eslint",
        "golangci_lint_ls",
        "gopls",
        "html",
        "jedi_language_server",
        "jsonls",
        "lua_ls",
        "markdown_oxide",
        "nginx_language_server",
        "tailwindcss",
        "taplo",
        "vimls",
      }
      local navic_list = {
        "bashls",
        "clangd",
        "cssls",
        "dockerls",
        "gopls",
        "html",
        "jedi_language_server",
        "jsonls",
        "lua_ls",
        "markdown_oxide",
        "taplo",
        "vimls",
      }
      for _, lsp in pairs(lsp_list) do
        if lsp == "markdown_oxide" then
          lspconfig[lsp].setup({
            capabilities = {
              "force",
              capabilities,
              {
                workspace = {
                  didChangeWatchedFiles = {
                    dynamicRegistration = true,
                  },
                },
              },
            },
            on_attach = function(client, bufnr)
              navic.attach(client, bufnr)
            end,
            settings = {},
          })
        else
          lspconfig[lsp].setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
              for _, navic_support in pairs(navic_list) do
                if navic_support == lsp then
                  navic.attach(client, bufnr)
                end
              end
              -- lspformat.on_attach(client, bufnr)
            end,
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
              },
              gopls = {
                gofumpt = true,
              },
            },
          })
        end
      end
    end,
  },
  {
    "SmiteshP/nvim-navic",
    config = function()
      local navic = require("nvim-navic")
      navic.setup({
        icons = {
          File = " ",
          Module = " ",
          Namespace = " ",
          Package = " ",
          Class = " ",
          Method = " ",
          Property = " ",
          Field = " ",
          Constructor = " ",
          Enum = " ",
          Interface = " ",
          Function = " ",
          Variable = " ",
          Constant = " ",
          String = " ",
          Number = " ",
          Boolean = " ",
          Array = " ",
          Object = " ",
          Key = " ",
          Null = " ",
          EnumMember = " ",
          Struct = " ",
          Event = " ",
          Operator = " ",
          TypeParameter = " ",
        },
        lsp = {
          auto_attach = true,
          preference = nil,
        },
        highlight = true,
        separator = "  ",
        depth_limit = 6,
        depth_limit_indicator = "…",
        safe_output = true,
        lazy_update_context = false,
        click = false,
        format_text = function(text)
          return text
        end,
      })
    end,
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "SmiteshP/nvim-navic",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local navic = require("nvim-navic")
      local on_attach = function(client, bufnr)
        navic.attach(client, bufnr)
      end
      require("typescript-tools").setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          -- spawn additional tsserver instance to calculate diagnostics on it
          separate_diagnostic_server = true,
          -- "change"|"insert_leave" determine when the client asks the server about diagnostic
          publish_diagnostic_on = "insert_leave",
          -- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
          -- "remove_unused_imports"|"organize_imports") -- or string "all"
          -- to include all supported code actions
          -- specify commands exposed as code_actions
          expose_as_code_action = {},
          -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
          -- not exists then standard path resolution strategy is applied
          tsserver_path = nil,
          -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
          -- (see 💅 `styled-components` support section)
          tsserver_plugins = {},
          -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
          -- memory limit in megabytes or "auto"(basically no limit)
          tsserver_max_memory = "auto",
          -- described below
          tsserver_format_options = {},
          tsserver_file_preferences = {},
          -- locale of all tsserver messages, supported locales you can find here:
          -- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
          tsserver_locale = "en",
          -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
          complete_function_calls = false,
          include_completions_with_insert_text = true,
          -- CodeLens
          -- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
          -- possible values: ("off"|"all"|"implementations_only"|"references_only")
          code_lens = "off",
          -- by default code lenses are displayed on all referencable values and for some of you it can
          -- be too much this option reduce count of them by removing member references from lenses
          disable_member_code_lens = true,
          -- JSXCloseTag
          -- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-ts-autotag,
          -- that maybe have a conflict if enable this feature. )
          jsx_close_tag = {
            enable = true,
            filetypes = { "javascriptreact", "typescriptreact" },
          },
        },
      })
    end,
  },
  {
    "luckasRanarison/tailwind-tools.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("tailwind-tools").setup({})
    end,
  },
  {
    "nvimdev/lspsaga.nvim",
    config = function()
      require("lspsaga").setup({
        symbol_in_winbar = {
          enable = false,
        },
        lightbulb = {
          enable = false,
        },
        rename = {
          in_select = false,
        }
      })
      vim.api.nvim_set_keymap("n", "L", "<cmd>Lspsaga code_action<cr>", { noremap = true })
      vim.api.nvim_set_keymap("n", "K", "<cmd>Lspsaga hover_doc<cr>", { noremap = true })
      vim.api.nvim_set_keymap("n", "Ø", "<cmd>Lspsaga diagnostic_jump_next<cr>", { noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>lf", "<cmd>Lspsaga finder<cr>", { noremap = true })
      vim.api.nvim_set_keymap("n", "<F2>", "<cmd>Lspsaga rename<cr>", { noremap = true })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional
      "nvim-tree/nvim-web-devicons", -- optional
    },
  },
}
