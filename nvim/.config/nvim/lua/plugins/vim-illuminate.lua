return {
  "RRethy/vim-illuminate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("illuminate").configure({
      delay = 200,
      filetypes_denylist = {
        "dirvish",
        "fugitive",
        "NvimTree",
        "toggleterm",
        "TelescopePrompt",
        "alpha",
        "lazy",
        "mason",
        "notify",
        "packer",
      },
    })
  end, 
}
