--- Utils

-- Escape special (regex) characters and spaces.
local function escape(str)
	return vim.fn.escape(str, "() ")
end

-- Wrapper around vim.fn.input() that checks and sanitizes the input.
local function with_input(opts, callback)
	vim.ui.input(opts, function(input)
		if input and input ~= "" then
			callback(escape(input))
		end
	end)
end

-- Set items in the quickfix list and open the quickfix window.
local function quickfix(list, make_qf_item, handle_lone_item)
	local qf_list = {}

	for _, item in ipairs(list) do
		local qf_item = make_qf_item(item)
		if qf_item then
			table.insert(qf_list, qf_item)
		end
	end

	vim.fn.setqflist(qf_list, "r")

	if #qf_list == 1 then
		if handle_lone_item then
			if handle_lone_item(qf_list[1]) then
				vim.cmd("copen")
			end
		else
			vim.cmd("copen")
		end
	else
		vim.cmd("copen")
	end
end

--- Colorscheme

vim.cmd("colorscheme fleet")

--- Options
--- https://neovim.io/doc/user/lua-guide.html#lua-guide-options

vim.opt.mouse = "a"

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = ""
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

vim.opt.completeopt = "menuone,popup"

vim.opt.grepprg = "rg --vimgrep --smart-case --sort=path"

vim.opt.updatetime = 50

vim.opt.termguicolors = true

vim.opt.spell = true
vim.opt.spelllang = "en_us"
vim.opt.spelloptions = "camel"
vim.opt.spellfile = "/home/patrick/nixos/runtime/nvim/spell/en.utf-8.add"

vim.g.mapleader = " "

--- Keymaps
--- https://neovim.io/doc/user/lua-guide.html#lua-guide-mappings
--- Use ':map' to list all keymaps or a specific keymap

-- Find files using fd with auto complete.
-- Show the results in the quickfix window.
local function find()
	with_input({ prompt = "Find > ", completion = "file" }, function(input)
		local files = vim.fn.systemlist("fd --type=file --full-path " .. input)

		quickfix(files, function(file)
			return {
				filename = file,
				text = file,
			}
		end, function(item)
			vim.cmd("edit " .. item.filename)
		end)
	end)
end

-- Returns a list of unique words in the current buffer that start with the given argument.
-- Global function so it can be used as a custom completion function.
function GET_BUFFER_WORDS(arg_lead)
	local bufnr = vim.api.nvim_get_current_buf()
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	local words_list = {}
	local words_set = {}

	for _, line in ipairs(lines) do
		for word in line:gmatch("%w+") do
			if not words_set[word] then
				words_set[word] = true
				if word:find("^" .. escape(arg_lead)) then
					table.insert(words_list, word)
				end
			end
		end
	end

	return words_list
end

-- Grep for a word in the current working directory using ripgrep with auto complete.
-- Show the results in the quickfix window.
local function grep()
	with_input({ prompt = "Grep > ", completion = "customlist,v:lua.GET_BUFFER_WORDS" }, function(input)
		vim.cmd('silent grep! "' .. input .. '"')
		vim.cmd("copen")
	end)
end

-- Open the list of buffers in the quickfix window.
local function buffers()
	local bufs = vim.api.nvim_list_bufs()

	quickfix(bufs, function(bufnr)
		if not vim.api.nvim_buf_is_loaded(bufnr) then
			return
		end

		local bufname = vim.api.nvim_buf_get_name(bufnr)
		if bufname == "" then
			bufname = "[No Name]"
		end

		return {
			filename = bufname,
			text = "Buffer " .. bufnr,
		}
	end)
end

-- Toggle the quickfix window.
local function toggle_quickfix_window()
	local is_qf_open = false
	local wins = vim.fn.getwininfo()

	for _, win in ipairs(wins) do
		if win.quickfix == 1 then
			is_qf_open = true
		end
	end

	if is_qf_open then
		vim.cmd("cclose")
	else
		vim.cmd("copen")
	end
end

vim.keymap.set({ "n", "v" }, "q", "")
vim.keymap.set({ "n", "v" }, "Q", "")

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p')

vim.keymap.set("n", "<leader>e", "<cmd>Explore<cr>")
vim.keymap.set("n", "<leader>f", find)
vim.keymap.set("n", "<leader>g", grep)

vim.keymap.set("n", "<leader>q", toggle_quickfix_window)
vim.keymap.set("n", "]q", "<cmd>cnext<cr>")
vim.keymap.set("n", "[q", "<cmd>cprev<cr>")

vim.keymap.set("n", "<leader>b", buffers)
vim.keymap.set("n", "]b", "<cmd>bnext<cr>")
vim.keymap.set("n", "[b", "<cmd>bprev<cr>")

vim.keymap.set("n", "]t", "<cmd>tabnext<cr>")
vim.keymap.set("n", "[t", "<cmd>tabprev<cr>")

vim.keymap.set("n", "<leader>t", "<cmd>tabnew<cr>")
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
--- Use ':autocmd' to list all autocommands

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = {
		"*.html",
		"*.css",
		"*.js",
		"*.jsx",
		"*.ts",
		"*.tsx",
		"*.json",
		"*.yaml",
		"*.md",
	},
	callback = function()
		vim.cmd("silent !prettier --write " .. vim.fn.expand("%:p"))
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.nix",
	callback = function()
		vim.cmd("silent !nixfmt " .. vim.fn.expand("%:p"))
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.lua",
	callback = function()
		vim.cmd("silent !stylua " .. vim.fn.expand("%:p"))
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.go", "*.rs" },
	callback = function()
		local bufnr = vim.api.nvim_get_current_buf()
		vim.lsp.buf.format({ async = false, bufnr = bufnr })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "qf", "checkhealth" },
	callback = function()
		vim.opt_local.spell = false
	end,
})
