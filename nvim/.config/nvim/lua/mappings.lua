require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<leader>tt", "o<Esc>o")

map("n", "<leader>pp", function()
  -- First check if clipboard has image data
  local check = vim.fn.system('wl-paste --list-types 2>/dev/null | grep -q "image/png"')
  local exit_code = vim.v.shell_error
  
  if exit_code == 0 then
    -- Get current file name without extension
    local current_file = vim.fn.expand('%:t:r')
    if current_file == '' then
      current_file = 'unnamed'
    end
    
    -- Create directory if it doesn't exist
    local dir = current_file
    vim.fn.mkdir(dir, 'p')
    
    local filename = vim.fn.input('Filename: ')
    if filename ~= '' then
      local filepath = dir .. '/' .. filename .. '.png'
      -- Use shell command directly to preserve binary data
      local result = vim.fn.system('wl-paste --type image/png > ' .. vim.fn.shellescape(filepath))
      if vim.v.shell_error == 0 then
        vim.api.nvim_put({'![' .. filename .. '](' .. filepath .. ')'}, 'c', true, true)
      else
        vim.api.nvim_err_writeln('Error: Failed to save image')
        -- Clean up the file if it was created
        os.remove(filepath)
      end
    end
  else
    vim.api.nvim_err_writeln('Error: No image data in clipboard')
  end
end, { desc = "Paste image from clipboard" })
