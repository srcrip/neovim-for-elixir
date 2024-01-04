-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    "vim-test/vim-test",
    config = function()
      vim.cmd([[
        function! BufferTermStrategy(cmd)
          exec 'te ' . a:cmd
        endfunction

        let g:test#custom_strategies = {'bufferterm': function('BufferTermStrategy')}
        let g:test#strategy = 'bufferterm'
      ]])
    end,
    keys = {
      { "<leader>Tf", "<cmd>TestFile<cr>",    silent = true, desc = "Run this file" },
      { "<leader>Tn", "<cmd>TestNearest<cr>", silent = true, desc = "Run nearest test" },
      { "<leader>Tl", "<cmd>TestLast<cr>",    silent = true, desc = "Run last test" },
    },
  },
  {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
    },
  },
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        elixir = { 'credo' }
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "lua_ls" },
        javascript = { { "prettierd", "prettier" }, { "eslint_d", "eslint" } },
        typescript = { { "prettierd", "prettier" }, { "eslint_d", "eslint" } },
      },
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },
}
