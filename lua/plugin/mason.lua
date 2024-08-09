return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "cssls",
          "dockerls",
          "eslint",
          "gopls",
          "html",
          "jsonls",
          "tsserver",
          "lua_ls",
          "nginx_language_server",
          "jedi_language_server",
          "taplo",
          "tailwindcss",
          "vimls",
        },
      })
    end,
  },
}
