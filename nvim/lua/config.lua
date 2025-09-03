-- Treesitter
require("nvim-treesitter.configs").setup {
    highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = { "lua", "python", "cpp", "javascript", "json", "html", "bash" },
}

-- Lualine
require("lualine").setup {
    options = {
        icons_enabled = false,
        section_separators = '',
        component_separators = '',
    }
}

-- Nvim-tree
require("nvim-tree").setup({
    renderer = {
        icons = {
            show = {
                file = false,
                folder = false,
                folder_arrow = false,
                git = false,
            }
        }
    }
})
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true })

-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files)
vim.keymap.set("n", "<leader>fg", builtin.live_grep)
vim.keymap.set("n", "<leader>fb", builtin.buffers)
vim.keymap.set("n", "<leader>fh", builtin.help_tags)

-- LSP
local lspconfig = require("lspconfig")
lspconfig.lua_ls.setup {}
lspconfig.pyright.setup {}
lspconfig.tsserver = nil
lspconfig.ts_ls.setup {}

-- CMP
local cmp = require("cmp")
cmp.setup({
    mapping = {
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
        { name = 'nvim_lsp' },
    },
})

require("mason-lspconfig").setup()

vim.o.background = 'dark'
vim.cmd.colorscheme 'vscode'

vim.keymap.set('n', '<leader>E', vim.diagnostic.open_float)

vim.cmd [[
  highlight ExtraWhitespace ctermbg=red guibg=red
  match ExtraWhitespace /\s\+$/
]]
