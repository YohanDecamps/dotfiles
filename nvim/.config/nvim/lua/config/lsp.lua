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

-- svelte-language-server
vim.lsp.config('svelte', {
  filetypes = { 'svelte' },
  root_markers = { { 'svelte.config.js', 'svelte.config.cjs' }, '.git' },
})
vim.lsp.enable('svelte')

-- prisma-language-server
vim.lsp.config('prismals', {
  filetypes = { 'prisma' },
  root_markers = { { 'prisma.config.ts' }, '.git' },
  settings = {
    prisma = {
      prismaFmtBinPath = "/usr/bin/prisma-language-server"
    },
  },
})
vim.lsp.enable('prismals')

-- glsl-analyzer
vim.lsp.config('glsl_analyzer', {
  filetypes = { 'glsl', 'vert', 'frag', 'geom', 'comp', 'tesc', 'tese' },
})
vim.lsp.enable('glsl_analyzer')

-- tailwind css
vim.lsp.config('tailwindcss', {
  filetypes = { 'html', 'css', 'scss', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue' },
  root_markers = { { 'tailwind.config.js', 'tailwind.config.cjs' }, '.git' },
})
vim.lsp.enable('tailwindcss')

-- lua-language-server (the nvim-lspconfig server name is `lua_ls`)
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim' } },
    },
  },
})
vim.lsp.enable('lua_ls')

-- Show diagnostics in a floating window
vim.diagnostic.config {
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "single",
    source = true,
    focusable = false,
    style = "minimal",
  },
}

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    local opts = { buffer = bufnr }
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client and client:supports_method('textDocument/completion', bufnr) then
      vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
      vim.keymap.set('i', '<C-Space>', vim.lsp.completion.get, opts)
      vim.keymap.set('i', '<Tab>', function()
        return vim.fn.pumvisible() == 1 and '<C-n>' or '<Tab>'
      end, { buffer = bufnr, expr = true, noremap = true })
      vim.keymap.set('i', '<S-Tab>', function()
        return vim.fn.pumvisible() == 1 and '<C-p>' or '<S-Tab>'
      end, { buffer = bufnr, expr = true, noremap = true })
    end

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
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
