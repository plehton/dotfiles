-- Colorscheme from base16
vim.g.base16colorspace=256
vim.cmd("source ~/.vimrc_background")

-- Lighten default background a little for columns after wrapmargin and rows
-- after EndOfBuffer
local colors = require('pjl.colors')
local bg = colors.fromhl("Normal").bg
local fg = colors.fromhl("Comment").fg
local color = { 
    bg = colors.change_brightness(bg, 6),
    fg = fg
}

hl = colors.highlight("ColorColumn", color)
vim.cmd(hl)
vim.cmd("highlight clear EndOfBuffer")
vim.cmd("highlight link EndOfBuffer ColorColumn")
