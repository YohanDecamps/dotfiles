vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.softtabstop = 4
vim.opt.completeopt = { "menuone", "noinsert", "popup" }
vim.opt.clipboard = "unnamedplus"

local undo_dir = vim.fn.stdpath("state") .. "/undo"
vim.fn.mkdir(undo_dir, "p")
vim.opt.undofile = true
vim.opt.undodir = undo_dir .. "//"

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua", "typescript", "typescriptreact" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "svelte",
  callback = function(args)
    vim.treesitter.start(args.buf)
  end,
})

require("config.lazy")
require("config.keymaps")
require("config.lsp")
