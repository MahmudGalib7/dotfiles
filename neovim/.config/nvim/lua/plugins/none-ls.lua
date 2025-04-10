return {
	{
		"nvimtools/none-ls.nvim",
		event = "InsertEnter",
		dependencies = {
			"nvimtools/none-ls-extras.nvim",
			"lewis6991/gitsigns.nvim",
		},
		config = function()
			local null_ls = require("null-ls")
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			-- Helper function to check if a directory exists relative to the root of the project
			local function is_installed(dir_name)
				local cwd = vim.fn.getcwd() -- Get the current working directory
				local found = vim.fs.find(dir_name, { path = cwd, upward = true, type = "directory" })
				return not vim.tbl_isempty(found)
			end

			-- Check for Prettier and ESLint installations
			local prettier_installed = is_installed("node_modules/prettier")
			local biome_installed = is_installed("node_modules/biome")
			local eslint_plugin_format_installed = is_installed("node_modules/eslint-plugin-format")

			-- Dynamically configure sources based on checks
			local sourcesConfig = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.isort,
				null_ls.builtins.formatting.yamlfmt,
				null_ls.builtins.diagnostics.rubocop,
				null_ls.builtins.formatting.rubocop,
				null_ls.builtins.diagnostics.yamllint,
				null_ls.builtins.formatting.shfmt,
				null_ls.builtins.code_actions.gitsigns,
				null_ls.builtins.completion.spell,
			}

			-- Add Prettierd if Prettier is installed
			if prettier_installed and not eslint_plugin_format_installed then
				table.insert(sourcesConfig, null_ls.builtins.formatting.prettierd)
			end

			-- Add biome if installed
			if biome_installed then
				table.insert(sourcesConfig, null_ls.builtins.formatting.biome)
			end

			-- Setup null-ls
			null_ls.setup({
				sources = sourcesConfig,
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({
							group = augroup,
							buffer = bufnr,
						})
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ bufnr = bufnr })
							end,
						})
					end
				end,
			})
		end,
	},
}
