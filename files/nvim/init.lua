-- Colorscheme
vim.cmd("colorscheme fleet")

-- Options

-- Enable the mouse
vim.opt.mouse = "a"

-- Spot the cursor more easily by highlighting the current line
vim.opt.cursorline = true

-- Show a "max line length" column
vim.opt.colorcolumn = ""

-- Show line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Cursor scroll offset
vim.opt.scrolloff = 8

-- Enable the sign column on the left to show things like warning and errors symbols
vim.opt.signcolumn = "yes"

-- Search settings
vim.opt.showmatch = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Default indentation settings
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

-- Keep undo history between sessions
vim.opt.undofile = true

-- Disable swap file, it's annoying
vim.opt.swapfile = false
vim.opt.backup = false

-- Change default splitting behavior
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Update time for CursorHold autocommand event
vim.opt.updatetime = 50

-- Enable 24-bit RGB colors, requires compatible terminal
vim.opt.termguicolors = true

-- Enable spell checking
vim.opt.spell = true
vim.opt.spelllang = "en_us"
vim.opt.spelloptions = "camel"
vim.opt.spellfile = "/home/patrick/nixos/runtime/nvim/spell/en.utf-8.add"

-- Set <leader> key to space
vim.g.mapleader = " "

-- Keymaps

vim.keymap.set("n", "q", "<nop>")
vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p')

vim.keymap.set("n", "<leader>e", "<cmd>Explore<cr>")
vim.keymap.set("n", "<leader>f", "<cmd>Files<cr>")
vim.keymap.set("n", "<leader>/", "<cmd>Rg<cr>")

vim.keymap.set("n", "<c-h>", "<c-w>h")
vim.keymap.set("n", "<c-j>", "<c-w>j")
vim.keymap.set("n", "<c-k>", "<c-w>k")
vim.keymap.set("n", "<c-l>", "<c-w>l")

-- Plugins

require("auto-session").setup({})

require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
	},
})

require("conform").setup({
	formatters_by_ft = {
		html = { "prettierd" },
		css = { "prettierd" },
		javascript = { "prettierd" },
		javascriptreact = { "prettierd" },
		typescript = { "prettierd" },
		typescriptreact = { "prettierd" },
		json = { "prettierd" },
		jsonc = { "prettierd" },
		yaml = { "prettierd" },
		markdown = { "prettierd" },
		nix = { "nixfmt" },
		lua = { "stylua" },
		_ = { "trim_whitespace" },
	},
	format_on_save = {
		lsp_format = "fallback",
	},
})

-- LSP configs
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
local lsp = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()

local function on_attach(client, bufnr)
	-- Disable semantic highlighting as Treesitter is used for highlighting instead.
	client.server_capabilities.semanticTokensProvider = nil

	local opts = { buffer = bufnr }
	vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
	vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
	vim.keymap.set("n", "gk", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
	vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
	vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
	vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
	vim.keymap.set("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
	vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
	vim.keymap.set("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
	vim.keymap.set("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
end

lsp.nil_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lsp.lua_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
		},
	},
})

lsp.ts_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	init_options = {
		preferences = {
			importModuleSpecifierPreference = "non-relative",
			importModuleSpecifierEnding = "js",
		},
	},
})

lsp.tailwindcss.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- Filetypes
vim.filetype.add({
	pattern = {
		[".env"] = "properties",
		[".env.*"] = "properties",
		[".env.*.local"] = "properties",
	},
})

-- Autocommands

-- Disable spell checking in quickfix windows
vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.opt_local.spell = false
	end,
})
