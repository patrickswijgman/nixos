local utils = require("utils")

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

vim.opt.grepprg = "rg --vimgrep --smart-case --sort=path"

vim.opt.spell = true
vim.opt.spelllang = "en_us"
vim.opt.spelloptions = "camel"
vim.opt.spellfile = vim.fn.expand("~/nixos/runtime/nvim/spell/en.utf-8.add")

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 0

vim.g.mapleader = " "

-- KEYMAPS

local function find()
	utils.with_input("Find", "", "customlist,v:lua.require'utils'.list_files", function(input)
		vim.cmd("silent find " .. input)
	end)
end

local function grep()
	local word = vim.fn.expand("<cword>")
	utils.with_input("Grep", word, "customlist,v:lua.require'utils'.list_words", function(input)
		vim.cmd("silent grep! " .. input .. " | bo copen")
	end)
end

local function buffers()
	utils.with_input("Buffer", "", "buffer", function(input)
		vim.cmd("silent buffer " .. input)
	end)
end

local function help()
	local word = vim.fn.expand("<cword>")
	vim.cmd("silent help " .. word)
end

local function create()
	local dir = vim.fn.expand("%:h") .. "/"
	utils.with_input("Create", dir, "dir", function(input)
		if utils.ends_with(input, "/") then
			vim.cmd("silent !mkdir -p " .. input)
		else
			vim.cmd("silent !mkdir -p " .. utils.dirname(input))
			vim.cmd("silent !touch " .. input)
		end
	end)
end

local function move()
	local file = vim.fn.expand("%")
	utils.with_input("Move", file, "file", function(input)
		vim.cmd("silent !mkdir -p " .. utils.dirname(input))
		vim.cmd("silent !mv " .. file .. " " .. input)
		vim.cmd("edit " .. input)
		utils.delete_bufs_with_filename(file)
	end)
end

local function delete()
	local file = vim.fn.expand("%")
	utils.with_confirm("Delete " .. file, function()
		vim.cmd("silent !rm -r " .. file)
		utils.delete_bufs_with_filename(file)
	end)
end

local opts = { noremap = true, silent = true }

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', opts)
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', opts)

vim.keymap.set("n", "<leader>f", find, opts)
vim.keymap.set("n", "<leader>g", grep, opts)
vim.keymap.set("n", "<leader>h", help, opts)
vim.keymap.set("n", "<leader>c", create, opts)
vim.keymap.set("n", "<leader>m", move, opts)
vim.keymap.set("n", "<leader>D", delete, opts)
vim.keymap.set("n", "<leader>i", ":Inspect<cr>", opts)

vim.keymap.set("n", "<leader>q", ":copen<cr>", opts)
vim.keymap.set("n", "]q", ":cnext<cr>", opts)
vim.keymap.set("n", "[q", ":cprev<cr>", opts)

vim.keymap.set("n", "<leader>b", buffers, opts)
vim.keymap.set("n", "]b", ":bnext<cr>", opts)
vim.keymap.set("n", "[b", ":bprev<cr>", opts)

vim.keymap.set("n", "<leader>t", ":tabnew<cr>", opts)
vim.keymap.set("n", "]t", ":tabnext<cr>", opts)
vim.keymap.set("n", "[t", ":tabprev<cr>", opts)
vim.keymap.set("n", "<a-h>", ":tabprev<cr>", opts)
vim.keymap.set("n", "<a-l>", ":tabnext<cr>", opts)
vim.keymap.set("n", "<a-q>", ":tabclose<cr>", opts)
vim.keymap.set("n", "<a-tab>", ":tablast<cr>", opts)

vim.keymap.set("n", "<leader>z", ":ZenMode<cr>", opts)

vim.keymap.set("n", "<c-h>", "<c-w>h", opts)
vim.keymap.set("n", "<c-j>", "<c-w>j", opts)
vim.keymap.set("n", "<c-k>", "<c-w>k", opts)
vim.keymap.set("n", "<c-l>", "<c-w>l", opts)
vim.keymap.set("n", "<c-q>", "<c-w>q", opts)
vim.keymap.set("n", "<c-tab>", "<c-w>w", opts)

vim.keymap.set({ "n", "v" }, "q", "", opts)
vim.keymap.set({ "n", "v" }, "Q", "", opts)

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

require("colorizer").setup({
	user_default_options = {
		RGB = true,
		RRGGBB = true,
		RRGGBBAA = true,
		names = false,
		rgb_fn = false,
		hsl_fn = false,
		css = false,
		css_fn = false,
		mode = "background",
	},
})

require("zen-mode").setup({
	window = {
		width = 200,
	},
})

-- LSP

local lsp = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()

local function on_attach(client, bufnr)
	-- Disable semantic highlighting as Treesitter is used for highlighting instead
	client.server_capabilities.semanticTokensProvider = nil

	---@diagnostic disable-next-line: redefined-local
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- ]d     = go to next diagnostic
	-- [d     = go to previous diagnostic
	-- <c-w>d = open floating window with diagnostics on current line
	vim.keymap.set("n", "gs", ":lua vim.lsp.buf.signature_help()<cr>", opts)
	vim.keymap.set("n", "gd", ":lua vim.lsp.buf.definition()<cr>", opts)
	vim.keymap.set("n", "gt", ":lua vim.lsp.buf.type_definition()<cr>", opts)
	vim.keymap.set("n", "gr", ":lua vim.lsp.buf.references()<cr>", opts)
	vim.keymap.set("n", "<leader>a", ":lua vim.lsp.buf.code_action()<cr>", opts)
	vim.keymap.set("n", "<leader>r", ":lua vim.lsp.buf.rename()<cr>", opts)
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
		vim.cmd("silent !nixfmt " .. vim.fn.expand("%"))
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	group = group,
	pattern = "*.lua",
	callback = function()
		vim.cmd("silent !stylua " .. vim.fn.expand("%"))
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	group = group,
	pattern = "*.html,*.css,*.js,*.jsx,*.ts,*.tsx,*.json,*.yaml,*.md",
	callback = function()
		vim.cmd("silent !prettier --write " .. vim.fn.expand("%"))
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	group = group,
	pattern = "*.go",
	callback = function()
		vim.cmd("silent !gofmt -w " .. vim.fn.expand("%"))
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
