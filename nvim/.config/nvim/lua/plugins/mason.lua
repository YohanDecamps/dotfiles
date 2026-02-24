return {
  {
    "williamboman/mason.nvim",
    opts = function()
      require("configs.mason").setup()
    end,
  },
}

