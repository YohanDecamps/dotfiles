return {
  {
    "milanglacier/minuet-ai.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      provider = "openai_fim_compatible",
      n_completions = 1,
      context_window = 2048,
      debounce = 100,
      provider_options = {
        openai_fim_compatible = {
          api_key = "TERM",
          name = "Ollama",
          end_point = "http://localhost:11434/v1/completions",
          model = "qwen2.5-coder:7b",
          optional = { max_tokens = 56, top_p = 0.9 },
        },
      },
      virtualtext = {
        auto_trigger_ft = {
          "lua", "python", "javascript", "javascriptreact",
          "typescript", "typescriptreact", "svelte", "prisma",
          "glsl", "html", "css", "go", "rust", "c", "cpp",
        },
        keymap = {
          accept = "<A-A>",
          accept_line = "<A-a>",
          accept_n_lines = "<A-z>",
          prev = "<A-[>",
          next = "<A-]>",
          dismiss = "<A-e>",
        },
      },
    },
  },
}
