local colors = require('pjl.colors')

-- Lighten default background a little for columns after wrapmargin and rows
-- after EndOfBuffer
local old_bg = colors.fromhl("Normal").bg
local color = { 
    bg = colors.change_brightness(old_bg, 5), 
    fg = colors.fromhl("Comment").fg 
}
color = colors.tohl(color)

vim.cmd("highlight clear ColorColumn")
vim.cmd("highlight ColorColumn " .. color)
vim.cmd("highlight clear EndOfBuffer")
vim.cmd("highlight link EndOfBuffer ColorColumn")
vim.cmd("highlight clear VertSplit")
vim.cmd("highlight link VertSplit NonText")
