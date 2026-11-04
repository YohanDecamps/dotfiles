vim.keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle Nvim Tree"})

vim.keymap.set("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>x", "<cmd>bdelete<cr>", { desc = "Close current buffer" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to up window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to down window" })

vim.keymap.set("n", "<leader>sv", "<cmd>vsplit<cr>", {
  desc = "Create vertical split",
})
vim.keymap.set("n", "<leader>sh", "<cmd>split<cr>", {
  desc = "Create horizontal split",
})
