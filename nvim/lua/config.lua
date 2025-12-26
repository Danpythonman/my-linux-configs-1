vim.keymap.set('n', '<leader>E', vim.diagnostic.open_float)

-- Highlight extra whitespace red
vim.cmd [[
    highlight ExtraWhitespace ctermbg=red guibg=red
    match ExtraWhitespace /\s\+$/
]]
