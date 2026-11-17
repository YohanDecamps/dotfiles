return {
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      for _, group in ipairs({
        "IlluminatedWordText",
        "IlluminatedWordRead",
        "IlluminatedWordWrite",
      }) do
        vim.api.nvim_set_hl(0, group, { underline = true })
      end
    end,
  }
}
