require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<leader>tt", "o<Esc>o")

map("n", "<leader>pi", function()
  local check = vim.fn.system('wl-paste --list-types 2>/dev/null | grep -q "image/png"')
  local exit_code = vim.v.shell_error
  
  if exit_code == 0 then
    local filename = vim.fn.input('Filename: ')
    if filename ~= '' then
      local result = vim.fn.system('wl-paste --type image/png > ' .. vim.fn.shellescape(filename .. '.png'))
      if vim.v.shell_error == 0 then
        vim.api.nvim_put({'![' .. filename .. '](' .. filename .. '.png)'}, 'c', true, true)
      else
        vim.api.nvim_err_writeln('Error: Failed to save image')
        os.remove(filename .. '.png')
      end
    end
  else
    vim.api.nvim_err_writeln('Error: No image data in clipboard')
  end
end, { desc = "Paste image from clipboard" })
