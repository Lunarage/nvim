return {
  {
    "nvim-tree/nvim-tree.lua",
    keys = {
      { "<leader>n", "<cmd>NvimTreeToggle<cr>" },
      { "<leader>N", "<cmd>NvimTreeFindFile<cr>" },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function ()
      require('nvim-tree').setup()
    end
  },
}
