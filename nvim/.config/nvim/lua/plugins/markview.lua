-- For `plugins/markview.lua` users.
return {
    "OXY2DEV/markview.nvim",
    lazy = false,
    
    config = function()
        local presets = require("markview.presets").headings;
        require("markview").setup({
            -- Your configuration options go here
            markdown = {
              headings = presets.arrowed
            }
        })
    end,
};
