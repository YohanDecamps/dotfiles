return {
	{
		"nvim-tree/nvim-tree.lua",
		lazy = false,
		opts = {
		  sort = {
        sorter = "case_sensitive",
      },
      view = {
      	width = 30,
    	},
    	renderer = {
      	group_empty = true,
    	},
    	filters = {
      	dotfiles = true,
    	},
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        api.config.mappings.default_on_attach(bufnr)
        vim.keymap.set("n", "<C-o>", api.tree.change_root_to_node, {
          buffer = bufnr,
          desc = "Change root to selected node",
        })
      end,
		}
	}
}
