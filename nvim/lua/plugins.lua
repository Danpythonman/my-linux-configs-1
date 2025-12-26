-- This is the location where Lazy Nvim should be
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- If Lazy Nvim is not found, install it now
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

-- Add Lazy Nvim command
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- UI
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup({
                renderer = {
                    icons = {
                        show = {
                            file=false,
                            folder=false,
                            folder_arrow=false,
                            git=false
                        }
                    },
                },
            })
            vim.keymap.set(
                "n",
                "<leader>e",
                ":NvimTreeToggle<CR>",
                { noremap = true, silent = true }
            )
        end,
    },

    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("lualine").setup({
                options = {
                    icons_enabled = false,
                    section_separators = "",
                    component_separators = "",
                },
            })
        end,
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files)
            vim.keymap.set("n", "<leader>fg", builtin.live_grep)
            vim.keymap.set("n", "<leader>fb", builtin.buffers)
            vim.keymap.set("n", "<leader>fh", builtin.help_tags)
        end,
    },


    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                auto_install = true,
                highlight = { enable = true },
                indent = { enable = true },
                ensure_installed = {
                    "lua",
                    "python",
                    "cpp",
                    "javascript",
                    "json",
                    "html",
                    "bash"
                },
            })
        end,
    },

    -- LSP + Completion
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = function()
            require("mason").setup({
                ensure_installed = {
                    "lua_ls",
                    "pyright",
                    "ts_ls"
                }
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp"
        },
        config = function()
            require("mason-lspconfig").setup()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            lspconfig.lua_ls.setup({ capabilities = capabilities })
            lspconfig.pyright.setup({ capabilities = capabilities })
            lspconfig.ts_ls.setup({ capabilities = capabilities })
        end,
    },

    -- CMP
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip"
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                mapping = {
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                },
                sources = { { name = "nvim_lsp" } },
            })
        end,
    },

    -- Theme
    {
        "Mofiqul/vscode.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.o.background = "dark"
            vim.cmd.colorscheme("vscode")
        end,
    },

    -- Commenting out stuff
    { "numToStr/Comment.nvim", opts = {}, lazy = false },

    -- Remember where the cursor was when we close a file
    { "ethanholz/nvim-lastplace", config = true, lazy = false },

})
