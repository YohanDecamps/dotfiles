-- y3k colorscheme entry point (see lua/lush_theme/y3k.lua).
-- Standard Lush colorscheme loader: https://github.com/rktjmp/lush.nvim
if vim.g.colors_name then
  vim.cmd("hi clear")
end
vim.opt.background = "dark"
vim.g.colors_name = "y3k"

require("lush")(require("lush_theme.y3k"))
