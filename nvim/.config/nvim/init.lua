vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

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
