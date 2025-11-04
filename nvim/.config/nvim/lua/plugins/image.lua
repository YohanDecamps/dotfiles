return {
  "3rd/image.nvim",
  dependencies = {
    "leafo/magick",
  },
  event = "VeryLazy",
  config = function()
    require("image").setup({
      backend = "kitty",
      integrations = {
        markdown = {
          enabled = true,
          download_remote_images = true,
        },
      },
    })
  end,
}
