return {
  {
    "lewis6991/hover.nvim",
    config = function()
      local hover = require("hover")
      hover.setup({
        init = function()
          require("hover.providers.lsp")
          -- require('hover.providers.gh')
          -- require('hover.providers.gh_user')
          require('hover.providers.jira')
          require("hover.providers.dap")
          -- require('hover.providers.fold_preview')
          require("hover.providers.diagnostic")
          -- require('hover.providers.man')
          -- require('hover.providers.dictionary')
        end,
        preview_opts = { border = "single" },
        preview_window = true,
        title = true,
        mouse_providers = {
          "LSP",
        },
        mouse_delay = 500,
      })

      local async = require("hover.async")
      local h = require("helpers");

      local git_blame_provider = {
        name = "Blame",
        priority = 500,
        enabled = function(bufnr)
          local cwd = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":p:h")
          local Job = require("plenary.job")
          local success = ""
          Job:new({
            command = "git",
            args = { "rev-parse", "--is-inside-work-tree" },
            cwd = cwd,
            on_stdout = function(_, return_val)
              success = return_val
            end,
          }):sync()
          if success ~= "true" then
            return false
          end
          return true
        end,
        execute = async.void(function(_, done)
          local parse_blame = function(input, stderr)
            local stderr_count = 0
            for _ in pairs(stderr) do
              stderr_count = stderr_count + 1
            end
            if stderr_count > 0 then
              return stderr
            end

            local lines = {}

            for _, l in ipairs(input) do
              if l:find('author-date') then
                l:find()
                table.insert(lines, l)
              end
              table.insert(lines, l)
            end

            return lines
          end

          local bufnr = vim.api.nvim_get_current_buf()
          local file = vim.api.nvim_buf_get_name(bufnr)
          local row = vim.api.nvim_win_get_cursor(0)[1]
          local cwd = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":p:h")

          local Job = require("plenary.job")

          local output, stderr = {}, {}
          Job
            :new({
              command = "git",
              args = { "blame", "-L", string.format("%d,%d", row, row), "--porcelain", file },
              cwd = cwd,
              on_stdout = function(_, return_val)
                table.insert(output, return_val)
              end,
              on_stderr = function(_, return_val)
                table.insert(stderr, return_val)
              end,
            })
            :sync()

          local lines = parse_blame(output, stderr)
          done({ lines = lines, filetype = "markdown" })
        end),
      }
      hover.register(git_blame_provider)

      local git_diff_provider = {
        name = "Diff",
        priority = 500,
        enabled = function(bufnr)
          local cwd = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":p:h")
          local Job = require("plenary.job")
          local success = ""
          Job:new({
            command = "git",
            args = { "rev-parse", "--is-inside-work-tree" },
            cwd = cwd,
            on_stdout = function(_, return_val)
              success = return_val
            end,
          }):sync()
          if success ~= "true" then
            return false
          end
          return true
        end,
        execute = async.void(function(_, done)
          local bufnr = vim.api.nvim_get_current_buf()
          local file = vim.api.nvim_buf_get_name(bufnr)
          local row = vim.api.nvim_win_get_cursor(0)[1]
          local cwd = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":p:h")

          local Job = require("plenary.job")

          local output, stderr = {}, {}
          Job
            :new({
              command = "git",
              args = { "diff", '--no-color', '-U0', file },
              cwd = cwd,
              on_stdout = function(_, return_val)
                table.insert(output, return_val)
              end,
              on_stderr = function(_, return_val)
                table.insert(stderr, return_val)
              end,
            })
            :sync()

          local hunks, meta = h.parse_git_diff(output, stderr)
          local hunk = h.find_hunk(hunks, row)
          if hunk ~= nil then
            local filetype = vim.bo.filetype
            done({ lines = hunk.lines, filetype = "diff."..filetype })
          end
        end),
      }
      hover.register(git_diff_provider)
      vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
    end,
  },
}
