return {
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    opts = {
      options = {
        diagnostics_indicator = function(_, _, diagnostics_dict)
          local icons = {
            error = "",
            warning = "",
            info = "",
            hint = "󰌵",
          }
          local indicators = {}

          for _, severity in ipairs({ "error", "warning", "info", "hint" }) do
            local count = diagnostics_dict[severity]
            if count and count > 0 then
              table.insert(indicators, icons[severity] .. " " .. count)
            end
          end

          return " " .. table.concat(indicators, " ")
        end,
      }
    }
  }
}
