-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "gruvchad",

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },

  changed_themes = {
    vscode_dark = {
      base_16 = {
        base00 = "#0F0F0F",
        base01 = "#202020",
        base03 = "#4D4D4D",
        base04 = "#808080",
        base08 = "#87CEFA",
        base0B = "#CE9178",
      },
      base_30 = {
        white = "#F4F4F4",
        black = "#0F0F0F",
        black2 = "#202020",
        pink = "#F4C2C2",
        green1 = "#00FF7F",
        yellow = "#FFC40C",
        teal = "#008080",
        orange = "#FFA500",
        pmenu_bg = "#4169E1",
      },
    }
  }
}

-- M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
-- }

return M
