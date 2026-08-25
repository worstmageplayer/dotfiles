return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "mocha",
            -- Stock Catppuccin palette: colours come from
            -- https://github.com/catppuccin/palette (mirrored in palette/*.json).
            -- To switch flavour: change `flavour` above.
            highlight_overrides = {
                mocha = function(colors)
                    return {
                        Normal = { bg = "none" },
                        NormalFloat = { bg = "none" },
                        NormalNC = { bg = "none" },
                        FloatBorder = { bg = "none" },
                        FloatTitle = { bg = "none" },
                        StatusLine = { bg = "none" },
                        StatusLineNC = { bg = "none" },
                        MsgArea = { bg = "none" },
                        CursorLine = { bg = "none" },
                        CursorLineNr = { fg = colors.text },
                        LineNr = { fg = colors.overlay0 },
                        VertSplit = { fg = colors.surface0 },
                        Whitespace = { fg = colors.surface0 },
                        Visual = {
                            style = {},
                        }
                    }
                end,
                latte = function(colors)
                    return {
                        LineNr = { fg = colors.overlay0 },
                        CursorLineNr = { fg = colors.text },
                        CursorLine = { bg = colors.mantle },
                        VertSplit = { fg = colors.surface0 },
                        MsgArea = { bg = colors.base },
                    }
                end,
            },
            integrations = {
                aerial = true,
                alpha = true,
                cmp = true,
                dashboard = true,
                flash = true,
                fzf = true,
                grug_far = true,
                gitsigns = true,
                headlines = true,
                illuminate = true,
                indent_blankline = { enabled = true },
                leap = true,
                lsp_trouble = true,
                mason = true,
                markdown = true,
                mini = true,
                native_lsp = {
                    enabled = true,
                    underlines = {
                        errors = { "undercurl" },
                        hints = { "undercurl" },
                        warnings = { "undercurl" },
                        information = { "undercurl" },
                    },
                },
                navic = { enabled = true, custom_bg = "lualine" },
                neotest = true,
                neotree = true,
                noice = true,
                notify = true,
                semantic_tokens = true,
                snacks = true,
                telescope = true,
                treesitter = true,
                treesitter_context = true,
                which_key = true,
            },
        })

        vim.cmd.colorscheme("catppuccin")
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = 'none' })
      end,
}
