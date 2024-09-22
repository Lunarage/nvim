return {
  {
    "anuvyklack/pretty-fold.nvim",
    config = function()
      require("pretty-fold").setup({
        sections = {
          left = {
            "content",
            "├",
          },
          right = {
            "┤ ",
            "number_of_folded_lines",
            " : ",
            "percentage",
            " ├─",
            function(config)
              return config.fill_char:rep(3)
            end,
          },
        },
        fill_char = "─",

        remove_fold_markers = true,

        -- Keep the indentation of the content of the fold string.
        keep_indentation = true,

        -- Possible values:
        -- "delete" : Delete all comment signs from the fold string.
        -- "spaces" : Replace all comment signs with equal number of spaces.
        -- false    : Do nothing with comment signs.
        process_comment_signs = "delete",

        -- Comment signs additional to the value of `&commentstring` option.
        comment_signs = {},

        -- List of patterns that will be removed from content foldtext section.
        stop_words = {
          "@brief%s*", -- (for C++) Remove '@brief' and all spaces after.
        },

        add_close_pattern = "last_line", -- true, 'last_line' or false

        matchup_patterns = {
          -- Lua patterns
          { "^%s*do$", "end" },
          { "^%s*if", "end" },
          { "^%s*for", "end" },
          { "function%s*%(", "end" },

          -- Standard patterns
          { "%(", ")" }, -- % to escape lua pattern char
          { "%[", "]" }, -- % to escape lua pattern char
          { "{", "}" },
        },

        ft_ignore = { "neorg" },
      })
      vim.opt.foldcolumn="0"
    end,
  },
}
