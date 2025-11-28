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
            
            -- TypeScript configuration
            local ts_config = {
                on_attach = defaults.on_attach,
                capabilities = defaults.capabilities,
                filetypes = {"typescript", "typescriptreact", "javascript", "javascriptreact"},
                cmd = {"typescript-language-server", "--stdio"}
            }
            
            -- rust-analyzer configuration
            local rust_config = {
                on_attach = defaults.on_attach,
                capabilities = defaults.capabilities,
                filetypes = {"rust"},
                settings = {
                    ["rust-analyzer"] = {
                        cargo = {
                            allFeatures = true,
                        },
                    }
                }
            }

            -- glsl_analyzer configuration
            local glsl_config = {
                on_attach = defaults.on_attach,
                capabilities = defaults.capabilities,
                filetypes = {"glsl", "vert", "frag", "geom", "tesc", "tese"},
            }

            -- Setup LSPs depending on Neovim version
            if vim.lsp and vim.lsp.start then
                vim.lsp.config("clangd", clangd_config)
                vim.lsp.enable("clangd")
                
                vim.lsp.config("ts_ls", ts_config)
                vim.lsp.enable("ts_ls")

                vim.lsp.config("rust_analyzer", rust_config)
                vim.lsp.enable("rust_analyzer")
        
                vim.lsp.config("glsl_analyzer", glsl_config)
                vim.lsp.enable("glsl_analyzer")
            else
                local lspconfig = require("lspconfig")
                lspconfig.clangd.setup(clangd_config)
                lspconfig.ts_ls.setup(ts_config)
                lspconfig.rust_analyzer.setup(rust_config)
                lspconfig.glsl_analyzer.setup(glsl_config)

            end
        end
    }
}
