local lsp = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local buf = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		if client then
			-- Disable semantic highlighting as Treesitter is used for highlighting instead
			client.server_capabilities.semanticTokensProvider = nil
		end

		---@diagnostic disable-next-line: redefined-local
		local opts = { noremap = true, silent = true, buffer = buf }

		-- ]d     = go to next diagnostic
		-- [d     = go to previous diagnostic
		-- <c-w>d = open floating window with diagnostics on current line
		-- K      = open documentation for symbol under cursor
		vim.keymap.set("n", "gs", ":lua vim.lsp.buf.signature_help()<cr>", opts)
		vim.keymap.set("n", "gd", ":lua vim.lsp.buf.definition()<cr>", opts)
		vim.keymap.set("n", "gt", ":lua vim.lsp.buf.type_definition()<cr>", opts)
		vim.keymap.set("n", "gr", ":lua vim.lsp.buf.references()<cr>", opts)
		vim.keymap.set("n", "<leader>a", ":lua vim.lsp.buf.code_action()<cr>", opts)
		vim.keymap.set("n", "<leader>r", ":lua vim.lsp.buf.rename()<cr>", opts)
	end,
})

lsp["nil_ls"].setup({
	capabilities = capabilities,
})

lsp["lua_ls"].setup({
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using
				-- (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = { vim.env.VIMRUNTIME },
			},
			diagnostics = {
				globals = {
					"vim",
				},
			},
		},
	},
})

lsp["ts_ls"].setup({
	capabilities = capabilities,
	init_options = {
		preferences = {
			importModuleSpecifierPreference = "non-relative",
			importModuleSpecifierEnding = "js",
		},
	},
})

lsp["eslint"].setup({
	capabilities = capabilities,
})

lsp["tailwindcss"].setup({
	capabilities = capabilities,
})

lsp["gopls"].setup({
	capabilities = capabilities,
})

lsp["golangci_lint_ls"].setup({
	capabilities = capabilities,
})

lsp["yamlls"].setup({
	capabilities = capabilities,
})
