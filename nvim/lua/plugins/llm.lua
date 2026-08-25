return {
  "huggingface/llm.nvim",
  event = "VeryLazy",
  opts = {
    backend = "ollama",
    model = "qwen2.5-coder:7b-base",
    url = "http://localhost:11434",
    tokens_to_clear = { "<|endoftext|>" },
    fim = {
      enabled = true,
      prefix = "<|fim_prefix|>",
      middle = "<|fim_middle|>",
      suffix = "<|fim_suffix|>",
    },
    request_body = {
      options = {
        temperature = 0.2,
        top_p = 0.95,
        stop = { "<|endoftext|>", "```" },
      },
    },
    accept_keymap = "<a-l>",
    dismiss_keymap = "<a-k>",
    enable_suggestions_on_startup = true,
    debounce_ms = 150,
  },
}
