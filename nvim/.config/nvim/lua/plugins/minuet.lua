return {
  {
    "milanglacier/minuet-ai.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      provider = "openai_fim_compatible",
      n_completions = 1,
      context_window = 2048,
      debounce = 100,
      request_timeout = 30,
      notify = "verbose",
      provider_options = {
        openai_fim_compatible = {
          api_key = "TERM",
          name = "Ollama",
          end_point = "http://localhost:11434/v1/completions",
          model = "qwen2.5-coder:3b",
          optional = { max_tokens = 56, top_p = 0.9 },
        },
      },
      virtualtext = {
        show_on_completion_menu = true,
        auto_trigger_ft = { "*" },
        auto_trigger_ignore_ft = { "markdown", "text" },
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
