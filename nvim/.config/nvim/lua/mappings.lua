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

local function find_live_terminal()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(bufnr)
      and vim.api.nvim_buf_get_option(bufnr, "buftype") == "terminal"
    then
      local chan = vim.b[bufnr].terminal_job_id
      if chan and vim.fn.jobwait({ chan }, 0)[1] == -1 then
        return bufnr, chan
      end
    end
  end
  return nil, nil
end

local function get_project_root()
  return vim.loop.cwd()
end

local function write_and_launch()
  vim.cmd("wa")

  local root = get_project_root()
  local script = root .. "/launch.sh"

  local term_buf, chan = find_live_terminal()

  if term_buf and chan then
    -- Reuse the terminal
    vim.fn.chansend(chan, script .. "\n")

    -- Focus the terminal window
    -- If the terminal buffer is not in any window, open it
    local win = vim.fn.bufwinnr(term_buf)
    if win == -1 then
      vim.cmd("botright split")
      vim.cmd("buffer " .. term_buf)
    else
      vim.cmd(win .. "wincmd w")
    end

  else
    -- Create a new terminal and run script
    vim.cmd("botright split")
    vim.cmd("terminal " .. script)

    -- Focus is already on the new terminal window
  end
end

map("n", "<leader>rr", write_and_launch, { desc = "Write all and run launch script" })

