--- Utils

local function is_empty(str)
	return str == nil or str == ""
end

--- Colorscheme

vim.cmd("colorscheme fleet")

--- Options
--- https://neovim.io/doc/user/lua-guide.html#lua-guide-options

vim.opt.mouse = "a" -- enable mouse

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = {}
vim.opt.scrolloff = 8

vim.opt.showmatch = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.completeopt = { "menuone", "popup" }

vim.opt.grepprg = "rg --vimgrep --smart-case --hidden"

vim.opt.updatetime = 50

vim.opt.termguicolors = true

vim.opt.spell = true
vim.opt.spelllang = "en_us"
vim.opt.spelloptions = "camel"
vim.opt.spellfile = "/home/patrick/nixos/runtime/nvim/spell/en.utf-8.add"

vim.g.mapleader = " "

--- Keymaps
--- https://neovim.io/doc/user/lua-guide.html#lua-guide-mappings

local function find()
	vim.ui.input({ prompt = "Find > " }, function(input)
		if not is_empty(input) then
			vim.cmd("find ./**/" .. input .. "*")
		end
	end)
end

local function grep()
	vim.ui.input({ prompt = "Grep > " }, function(input)
		if not is_empty(input) then
			vim.cmd("silent grep! " .. input .. " ./**/*")
			vim.cmd("copen")
		end
	end)
end

vim.keymap.set({ "n", "v" }, "q", "")
vim.keymap.set({ "n", "v" }, "Q", "")

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p')

vim.keymap.set("n", "<leader>e", "<cmd>Explore<cr>")
vim.keymap.set("n", "<leader>f", find)
vim.keymap.set("n", "<leader>g", grep)
vim.keymap.set("n", "<leader>q", "<cmd>copen<cr>")

vim.keymap.set("n", "]q", "<cmd>cnext<cr>")
vim.keymap.set("n", "[q", "<cmd>cprev<cr>")
vim.keymap.set("n", "]b", "<cmd>bnext<cr>")
vim.keymap.set("n", "[b", "<cmd>bprev<cr>")
vim.keymap.set("n", "]t", "<cmd>tabnext<cr>")
vim.keymap.set("n", "[t", "<cmd>tabprev<cr>")

vim.keymap.set("n", "<c-h>", "<c-w>h")
vim.keymap.set("n", "<c-j>", "<c-w>j")
vim.keymap.set("n", "<c-k>", "<c-w>k")
vim.keymap.set("n", "<c-l>", "<c-w>l")

--- Plugins

require("auto-session").setup({
	use_git_branch = true,
	session_lens = {
		load_on_setup = false,
	},
})

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
	-- ]d     = go to next diagnostic
	-- [d     = go to previous diagnostic
	-- <c-w>d = open floating window with diagnostics on current line
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

lsp.ts_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	init_options = {
		preferences = {
			-- Prefer absolute imports ending with the file extension.
			importModuleSpecifierPreference = "non-relative",
			importModuleSpecifierEnding = "js",
		},
	},
})

lsp.eslint.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lsp.tailwindcss.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

--- Filetypes
--- https://neovim.io/doc/user/lua.html#vim.filetype

vim.filetype.add({
	pattern = {
		[".env"] = "properties",
		[".env.*"] = "properties",
		[".env.*.local"] = "properties",
	},
})

--- Autocommands
--- https://neovim.io/doc/user/lua-guide.html#_autocommands

-- Disable spell checking for specific filetypes
vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf,checkhealth",
	callback = function()
		vim.opt_local.spell = false
	end,
})
