return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  opts = function()
    local logo = [[
      =================     ===============     ===============   ========  ========
      \\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //
      ||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\/ . . .||
      || . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||
      ||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||
      || . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\ . . . . ||
      ||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\_ . .|. .||
      || . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\ `-_/| . ||
      ||_-' ||  .|/    || ||    \|.  || `-_|| ||_-' ||  .|/    || ||   | \  / |-_.||
      ||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \  / |  `||
      ||    `'         || ||         `'    || ||    `'         || ||   | \  / |   ||
      ||            .===' `===.         .==='.`===.         .===' /==. |  \/  |   ||
      ||         .=='   \_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \/  |   ||
      ||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \/  |   ||
      ||   .=='    _-'          '-__\._-'         '-_./__-'         `' |. /|  |   ||
      ||.=='    _-'                                                     `' |  /==.||
      =='    _-'                        N E O V I M                         \/   `==
      \   _-'                                                                `-_   /
       `''                                                                      ``' 
    ]]

    logo = string.rep("\n", 8) .. logo .. "\n\n"

    local opts = {
      theme = "doom",
      hide = {
        statusline = false,
      },
      config = {
        header = vim.split(logo, "\n"),
        center = {
          {
            action = "Telescope find_files",
            desc = " Find File",
            icon = " ",
            key = "f",
          },
          {
            action = "ene | startinsert",
            desc = " New File",
            icon = " ",
            key = "n",
          },
          {
            action = "Telescope oldfiles",
            desc = " Recent Files",
            icon = " ",
            key = "r",
          },
          {
            action = "Telescope live_grep",
            desc = " Find Text",
            icon = " ",
            key = "g",
          },
          {
            action = [[lua require("nvchad.term").toggle()]],
            desc = " Terminal",
            icon = " ",
            key = "t",
          },
          {
            action = "qa",
            desc = " Quit",
            icon = " ",
            key = "q",
          },
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
        end,
      },
    }

    return opts
  end,
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
