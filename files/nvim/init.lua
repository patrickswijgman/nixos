require("utils")
require("completion")

-- COLORSCHEME

vim.cmd("colorscheme fleet")

-- OPTIONS

vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = ""
vim.opt.scrolloff = 8
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.opt.updatetime = 50
vim.opt.termguicolors = true

vim.opt.showmatch = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

vim.opt.completeopt = "menuone,popup,noinsert,noselect"

vim.opt.path:append("**")
vim.opt.wildmenu = true
vim.opt.wildmode = "full"
vim.opt.wildoptions = "pum"
vim.opt.wildignore = { "*/.git/*", "*/node_modules/*", "*/dist/*", "*/target/*" }

vim.opt.grepprg = "rg --vimgrep --smart-case --sort=path"

vim.opt.spell = true
vim.opt.spelllang = "en_us"
vim.opt.spelloptions = "camel"
vim.opt.spellfile = "/home/patrick/nixos/runtime/nvim/spell/en.utf-8.add"

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 0

vim.g.mapleader = " "

-- KEYMAPS

local function find()
	with_input("Find > ", "customlist,v:lua.find_completion", function(input)
		vim.cmd("silent! find " .. input)
	end)
end

local function grep()
	with_input("Grep > ", "customlist,v:lua.grep_completion", function(input)
		vim.cmd("silent grep! " .. input)
		vim.cmd("copen")
	end)
end

local function buffers()
	with_input("Buffer > ", "buffer", function(input)
		vim.cmd("buffer " .. input)
	end)
end

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p')

vim.keymap.set("n", "<leader>e", "<cmd>Explore<cr>")
vim.keymap.set("n", "<leader>f", find)
vim.keymap.set("n", "<leader>g", grep)

vim.keymap.set("n", "<leader>q", "<cmd>copen<cr>")
vim.keymap.set("n", "]q", "<cmd>cnext<cr>")
vim.keymap.set("n", "[q", "<cmd>cprev<cr>")

vim.keymap.set("n", "<leader>b", buffers)
vim.keymap.set("n", "]b", "<cmd>bnext<cr>")
vim.keymap.set("n", "[b", "<cmd>bprev<cr>")

vim.keymap.set("n", "<leader>t", "<cmd>tabnew<cr>")
vim.keymap.set("n", "]t", "<cmd>tabnext<cr>")
vim.keymap.set("n", "[t", "<cmd>tabprev<cr>")
vim.keymap.set("n", "<a-h>", "<cmd>tabprev<cr>")
vim.keymap.set("n", "<a-l>", "<cmd>tabnext<cr>")
vim.keymap.set("n", "<a-q>", "<cmd>tabclose<cr>")
vim.keymap.set("n", "<a-tab>", "<cmd>tablast<cr>")

vim.keymap.set("n", "<c-h>", "<c-w>h")
vim.keymap.set("n", "<c-j>", "<c-w>j")
vim.keymap.set("n", "<c-k>", "<c-w>k")
vim.keymap.set("n", "<c-l>", "<c-w>l")
vim.keymap.set("n", "<c-q>", "<c-w>q")
vim.keymap.set("n", "<c-tab>", "<c-w>w")

vim.keymap.set({ "n", "v" }, "q", "")
vim.keymap.set({ "n", "v" }, "Q", "")

-- PLUGINS

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

-- LSP

local lsp = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()

local function on_attach(client, bufnr)
	-- Disable semantic highlighting as Treesitter is used for highlighting instead
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

lsp["nil_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lsp["lua_ls"].setup({
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

lsp["ts_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	init_options = {
		preferences = {
			importModuleSpecifierPreference = "non-relative",
			importModuleSpecifierEnding = "js",
		},
	},
})

lsp["eslint"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lsp["tailwindcss"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lsp["gopls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lsp["golangci_lint_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lsp["yamlls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- FILETYPES

vim.filetype.add({
	pattern = {
		[".env"] = "properties",
		[".env.*"] = "properties",
		[".env.*.local"] = "properties",
	},
})

-- AUTOCOMMANDS

local group = vim.api.nvim_create_augroup("UserConfig", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
	group = group,
	pattern = "*.nix",
	callback = function()
		vim.cmd("silent !nixfmt " .. get_current_file_path())
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	group = group,
	pattern = "*.lua",
	callback = function()
		vim.cmd("silent !stylua " .. get_current_file_path())
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	group = group,
	pattern = "*.html,*.css,*.js,*.jsx,*.ts,*.tsx,*.json,*.yaml,*.md",
	callback = function()
		vim.cmd("silent !prettier --write " .. get_current_file_path())
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	group = group,
	pattern = "*.go",
	callback = function()
		vim.cmd("silent !gofmt -w " .. get_current_file_path())
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = group,
	pattern = "qf,checkhealth",
	callback = function()
		vim.opt_local.spell = false
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	group = group,
	callback = function()
		vim.highlight.on_yank()
	end,
})
