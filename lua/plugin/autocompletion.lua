return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-path",
      "ray-x/cmp-treesitter",
    },
    config = function()
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.setup({
        sources = {
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "nvim_lsp_signature_help" },
          { name = "treesitter" },
        },
        mapping = cmp.mapping.preset.insert({
          ["<TAB>"] = cmp.mapping.select_next_item(),
          ["<S-TAB>"] = cmp.mapping.select_prev_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          -- ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
      })
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  -- "ervandew/supertab",
}
