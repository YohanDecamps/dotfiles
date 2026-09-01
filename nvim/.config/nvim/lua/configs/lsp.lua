-- /home/gaia/dotfiles/nvim/.config/nvim/lua/config/lsp.lua

-- ts_ls
vim.lsp.config('ts_ls', {
  settings = {
    typescript = {
      inlayHints = { includeInlayParameterNameHints = 'all' },
    },
    javascript = {
      inlayHints = { includeInlayParameterNameHints = 'all' },
    },
  },
})
vim.lsp.enable('ts_ls')

-- clangd
vim.lsp.config('clangd', {
  settings = {
    clangd = {
      inlayHints = { enable = true },
    },
  },
})
vim.lsp.enable('clangd')

-- biome
vim.lsp.config('biome', {
  root_markers = { { 'biome.json', 'biome.jsonc' }, '.git' },
})
vim.lsp.enable('biome')

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    local opts = { buffer = bufnr }

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>lf', function()
      vim.lsp.buf.format({
        bufnr = bufnr,
        filter = function(client)
          return client.name == 'biome'
        end,
      })
    end, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  end,
})
