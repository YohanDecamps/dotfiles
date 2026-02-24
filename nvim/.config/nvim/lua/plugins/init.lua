return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = function(_, opts)
      opts.view = opts.view or {}
      opts.view.adaptive_size = true
      opts.view.width = { min = 25, max = 80 }
      return opts
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      return require "configs.telescope"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
        ensure_installed = {
            "c_sharp",
            "lua",
            "vim",
            "vimdoc",
            "html",
            "css",
            "javascript",
            "typescript",
            "c",
            "cpp",
            "rust",
            "glsl",
        },
    },
    init = function()
        vim.opt.tabstop = 2
        vim.opt.shiftwidth = 2
        vim.opt.softtabstop = 2
        vim.opt.expandtab = true

        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "c", "cpp", "cs" },
            callback = function()
                vim.opt_local.tabstop = 4
                vim.opt_local.shiftwidth = 4
                vim.opt_local.softtabstop = 4
            end,
        })
    end,
  },
}
