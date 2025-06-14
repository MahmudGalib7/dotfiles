return {
	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				term_colors = true,
				compile = {
					enabled = true,
					path = vim.fn.stdpath("cache") .. "/catppuccin",
				},
				dim_inactive = {
					enabled = true,
				},
				no_italic = true,
				custom_highlights = function(palette)
					local groups = {
						SnacksDashboardHeader = { fg = palette.yellow },
						SnacksIndent = { fg = palette.surface0 },
					}
					return groups
				end,
				default_integrations = true,
				integrations = {
					which_key = true,
					dadbod_ui = true,
					lsp_trouble = true,
					grug_far = true,
					harpoon = true,
					mason = true,
					neotest = true,
					noice = true,
					diffview = true,
					dap = true,
					dap_ui = true,
					dropbar = {
						enabled = true,
						color_mode = true, -- enable color for kind's texts, not just kind's icons
					},
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					treesitter = true,
					notify = false,
					mini = {
						enabled = false,
						indentscope_color = "",
					},
					dashboard = true,
					neotree = true,
					blink_cmp = true,
					snacks = true,
					fzf = true,
					markview = true,
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = true,
		opts = {
			style = "night",
			transparent = true,
			terminal_colors = true,
			styles = {
				comments = { italic = true },
				keywords = { italic = true },
				functions = { bold = true },
				variables = {},
				sidebars = "transparent",
				floats = "transparent",
			},
			on_highlights = function(hl, c)
				hl.CursorLineNr.fg = c.orange
				hl.CursorLineNr.bold = true
				hl.CursorLineNr.italic = true

				hl.LineNr = { fg = c.dark5 }
				hl.Pmenu = { bg = c.bg_dark, fg = c.fg }
				hl.NormalFloat = { bg = "NONE" }
				hl.FloatBorder = { fg = c.border_highlight, bg = "NONE" }
				hl.Normal = { bg = "NONE" }
				hl.NormalNC = { bg = "NONE" }
			end,
		},
	},
}
