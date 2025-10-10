return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            local defaults = require("nvchad.configs.lspconfig")
            defaults.defaults()

            -- Clangd configuration

            local clangd_config =
                vim.tbl_deep_extend(
                "force",
                {cmd = {"clangd", "--background-index", "--clang-tidy"}, filetypes = {"c", "cpp", "objc", "objcpp"}},
                {on_attach = defaults.on_attach, capabilities = defaults.capabilities}
            )
            
            -- Setup LSPs depending on Neovim version

            if vim.lsp and vim.lsp.start then
                vim.lsp.config("clangd", clangd_config)
                vim.lsp.enable("clangd")
                
            else
                local lspconfig = require("lspconfig")
                lspconfig.clangd.setup(clangd_config)
            end
        end
    }
}

