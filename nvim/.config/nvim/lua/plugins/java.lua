return {
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    config = function()
      local jdtls = require("jdtls")
      local defaults = require("nvchad.configs.lspconfig")

      local home = os.getenv("HOME")
      local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
      local config_path = jdtls_path .. "/config_linux"
      if vim.fn.has("mac") == 1 then
        config_path = jdtls_path .. "/config_mac"
      elseif vim.fn.has("win32") == 1 then
        config_path = jdtls_path .. "/config_win"
      end

      local function get_config()
        local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
        local workspace_dir = home .. "/.cache/jdtls/workspace/" .. project_name

        return {
          cmd = {
            "java",
            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",
            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            "-Dlog.protocol=true",
            "-Dlog.level=ALL",
            "-Xmx1g",
            "--add-modules=ALL-SYSTEM",
            "--add-opens", "java.base/java.util=ALL-UNNAMED",
            "--add-opens", "java.base/java.lang=ALL-UNNAMED",
            "-jar", vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
            "-configuration", config_path,
            "-data", workspace_dir,
          },
          root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
          settings = {
            java = {
              eclipse = { downloadSources = true },
              configuration = { updateBuildConfiguration = "interactive" },
              maven = { downloadSources = true },
              implementationsCodeLens = { enabled = true },
              referencesCodeLens = { enabled = true },
              references = { includeDecompiledSources = true },
              format = { enabled = true },
            },
            signatureHelp = { enabled = true },
            completion = {
              favoriteStaticMembers = {
                "org.hamcrest.MatcherAssert.assertThat",
                "org.hamcrest.Matchers.*",
                "org.hamcrest.CoreMatchers.*",
                "org.junit.jupiter.api.Assertions.*",
                "java.util.Objects.requireNonNull",
                "java.util.Objects.requireNonNullElse",
                "org.mockito.Mockito.*",
              },
            },
            contentProvider = { preferred = "fernflower" },
            extendedClientCapabilities = jdtls.extendedClientCapabilities,
            sources = {
              organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 },
            },
            codeGeneration = {
              toString = { template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}" },
              useBlocks = true,
            },
          },
          flags = { allow_incremental_sync = true },
          on_attach = defaults.on_attach,
          capabilities = defaults.capabilities,
          init_options = { bundles = {} },
        }
      end

      -- Attach per Java buffer
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function()
          local config = get_config()
          jdtls.start_or_attach(config)
        end,
      })
    end,
  },
}

