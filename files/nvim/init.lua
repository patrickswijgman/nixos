-- UTILS

-- Convenience wrapper around vim.fn.input() that checks input.
local function with_input(prompt, completion, on_confirm)
	vim.ui.input({ prompt = prompt, completion = completion }, function(input)
		if input and input ~= "" then
			on_confirm(input)
		end
	end)
end

-- COLORSCHEME

vim.cmd("colorscheme fleet")

-- OPTIONS
-- https://neovim.io/doc/user/lua-guide.html#lua-guide-options

-- Editor
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = ""
vim.opt.scrolloff = 8

-- Searching
vim.opt.showmatch = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

-- Session management
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Window splitting behavior
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Completion menu
vim.opt.completeopt = "menuone,popup,noinsert,noselect"

-- Command line completion
vim.opt.wildmenu = true
vim.opt.wildmode = "full"
vim.opt.wildoptions = "pum"
vim.opt.wildignore = {
	"*/.git/*",
	"*/node_modules/*",
	"*/dist/*",
	"*/target/*",
}

-- Grep program
vim.opt.grepprg = "rg --vimgrep --smart-case --sort=path"

-- Spelling
vim.opt.spell = true
vim.opt.spelllang = "en_us"
vim.opt.spelloptions = "camel"
vim.opt.spellfile = "/home/patrick/nixos/runtime/nvim/spell/en.utf-8.add"

-- Netrw (builtin file explorer)
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 3

-- Update time for CursorHold events, such as for LSP events
vim.opt.updatetime = 50

-- Use fancy terminal colors
vim.opt.termguicolors = true

-- Set leader key to space
vim.g.mapleader = " "

-- KEYMAPS
-- https://neovim.io/doc/user/lua-guide.html#lua-guide-mappings
-- Use ':map' to list all keymaps or a specific keymap

-- Auto complete file names.
function _G.find_completion(arg_lead)
	return vim.fn.globpath("**", arg_lead .. "*", false, true)
end

-- Find a file using fd with auto complete.
local function find()
	with_input("Find > ", "customlist,v:lua.find_completion", function(input)
		vim.cmd("silent find " .. input)
	end)
end

-- Auto complete words in the current buffer.
function _G.grep_completion(arg_lead)
	local bufnr = vim.api.nvim_get_current_buf()
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	local words_list = {}
	local words_set = {}

	for _, line in ipairs(lines) do
		for word in line:gmatch("%a+") do
			if not words_set[word] then
				words_set[word] = true
				if word:find("^" .. arg_lead) then
					table.insert(words_list, word)
				end
			end
		end
	end

	table.sort(words_list)

	return words_list
end

-- Grep for a word in the current working directory using ripgrep with auto complete.
local function grep()
	with_input("Grep > ", "customlist,v:lua.grep_completion", function(input)
		vim.cmd("silent grep! " .. input)
		vim.cmd("copen")
	end)
end

-- Open a buffer with auto complete.
local function buffers()
	with_input("Buffer > ", "buffer", function(input)
		vim.cmd("buffer " .. input)
	end)
end

-- Copy pasting using the system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p')

-- Searching
vim.keymap.set("n", "<leader>e", "<cmd>tabnew<cr><cmd>Explore<cr>")
vim.keymap.set("n", "<leader>f", find)
vim.keymap.set("n", "<leader>g", grep)

-- Quickfix window
vim.keymap.set("n", "<leader>q", "<cmd>copen<cr>")
vim.keymap.set("n", "]q", "<cmd>cnext<cr>")
vim.keymap.set("n", "[q", "<cmd>cprev<cr>")

-- Buffers
vim.keymap.set("n", "<leader>b", buffers)
vim.keymap.set("n", "]b", "<cmd>bnext<cr>")
vim.keymap.set("n", "[b", "<cmd>bprev<cr>")

-- Tabs
vim.keymap.set("n", "<leader>t", "<cmd>tabnew<cr>")
vim.keymap.set("n", "]t", "<cmd>tabnext<cr>")
vim.keymap.set("n", "[t", "<cmd>tabprev<cr>")
vim.keymap.set("n", "<a-h>", "<cmd>tabprev<cr>")
vim.keymap.set("n", "<a-l>", "<cmd>tabnext<cr>")
vim.keymap.set("n", "<a-q>", "<cmd>tabclose<cr>")
vim.keymap.set("n", "<a-tab>", "<cmd>tablast<cr>")

-- Window shortcuts
vim.keymap.set("n", "<c-h>", "<c-w>h")
vim.keymap.set("n", "<c-j>", "<c-w>j")
vim.keymap.set("n", "<c-k>", "<c-w>k")
vim.keymap.set("n", "<c-l>", "<c-w>l")
vim.keymap.set("n", "<c-q>", "<c-w>q")
vim.keymap.set("n", "<c-tab>", "<c-w>w")

-- Disabled keymaps
vim.keymap.set({ "n", "v" }, "q", "")
vim.keymap.set({ "n", "v" }, "Q", "")

--- PLUGINS

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

-- Setup a language server with default capabilities and keybindings.
local function setup(server, extra_opts)
	local opts = vim.tbl_extend("force", {
		capabilities = capabilities,
		on_attach = on_attach,
	}, extra_opts or {})

	lsp[server].setup(opts)
end

setup("nil_ls")
setup("lua_ls", {
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
setup("ts_ls", {
	init_options = {
		preferences = {
			importModuleSpecifierPreference = "non-relative",
			importModuleSpecifierEnding = "js",
		},
	},
})
setup("eslint")
setup("tailwindcss")
setup("gopls")
setup("golangci_lint_ls")
setup("yamlls")

--- FILETYPES
--- https://neovim.io/doc/user/lua.html#vim.filetype

vim.filetype.add({
	pattern = {
		[".env"] = "properties",
		[".env.*"] = "properties",
		[".env.*.local"] = "properties",
	},
})

--- AUTOCOMMANDS
--- https://neovim.io/doc/user/lua-guide.html#_autocommands
--- Use ':autocmd' to list all autocommands

-- Automatically format files on save with given formatter command.
local function format(pattern, command)
	vim.api.nvim_create_autocmd("BufWritePost", {
		pattern = pattern,
		callback = function()
			vim.cmd("silent !" .. command .. " " .. vim.fn.expand("%:p"))
		end,
	})
end

format("*.html,*.css,*.js,*.jsx,*.ts,*.tsx,*.json,*.yaml,*.md", "prettier --write")
format("*.nix", "nixfmt")
format("*.lua", "stylua")
format("*.go", "gofmt -w")

-- Disable spellcheck for certain filetypes

vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf,checkhealth",
	callback = function()
		vim.opt_local.spell = false
	end,
})

-- Highlight yanked text

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})
