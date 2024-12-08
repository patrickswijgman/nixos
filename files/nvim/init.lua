require("plugins.simple-setup").setup({
	options = {
		mouse = "a",
		number = true,
		relativenumber = true,
		cursorline = true,
		signcolumn = "yes",
		colorcolumn = "",
		scrolloff = 8,
		splitright = true,
		splitbelow = true,
		undofile = true,
		swapfile = false,
		backup = false,
		sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions",
		updatetime = 50,
		termguicolors = true,

		showmatch = true,
		hlsearch = true,
		incsearch = true,

		tabstop = 2,
		softtabstop = 2,
		shiftwidth = 2,
		expandtab = true,
		autoindent = true,

		completeopt = "menuone,popup",

		spell = true,
		spelllang = "en_us",
		spelloptions = "camel",
		spellfile = "/home/patrick/nixos/runtime/nvim/spell/en.utf-8.add",
	},

	globals = {
		mapleader = " ",
		loaded_netrw = true,
		loaded_netrwPlugin = true,
	},

	plugins = {
		{
			"catppuccin",
			colorscheme = "catppuccin",
		},
		{
			"plugins.find",
		},
		{
			"plugins.grep",
		},
		{
			"auto-session",
			opts = {
				use_git_branch = true,
				session_lens = {
					load_on_setup = false,
				},
			},
		},
		{
			"nvim-treesitter.configs",
			opts = {
				highlight = {
					enable = true,
				},
			},
		},
		{
			"conform",
			opts = {
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
					go = { "gofmt" },
					rust = { "rustfmt" },
					lua = { "stylua" },
					_ = { "trim_whitespace" },
				},
				format_on_save = {
					lsp_format = "fallback",
				},
			},
		},
	},

	lsp = {
		servers = {
			{
				"nil_ls",
			},
			{
				"lua_ls",
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
							},
						},
					},
				},
			},
			{
				"ts_ls",
				init_options = {
					preferences = {
						importModuleSpecifierPreference = "non-relative",
						importModuleSpecifierEnding = "js",
					},
				},
			},
		},
		keymaps = {
			{
				key = "gd",
				action = function()
					vim.lsp.buf.definition()
				end,
			},
			{
				key = "gt",
				action = function()
					vim.lsp.buf.type_definition()
				end,
			},
			{
				key = "gr",
				action = function()
					vim.lsp.buf.references()
				end,
			},
			{
				key = "<leader>a",
				action = function()
					vim.lsp.buf.code_action()
				end,
			},
			{
				key = "<leader>r",
				action = function()
					vim.lsp.buf.rename()
				end,
			},
		},
	},

	keymaps = {
		{
			key = "<leader>y",
			action = [["+y]],
			mode = { "n", "v" },
		},
		{
			key = "<leader>p",
			action = [["+p]],
			mode = { "n", "v" },
		},
		{
			key = "<leader>f",
			action = ":Find ",
			opts = { silent = false },
		},
		{
			key = "<leader>g",
			action = ":Grep ",
			opts = { silent = false },
		},
		{
			key = "<leader>q",
			action = ":botright copen<cr>",
		},
		{
			key = "[q",
			action = ":cprev<cr>",
		},
		{
			key = "]q",
			action = ":cnext<cr>",
		},
		{
			key = "<leader>b",
			action = ":buffer ",
		},
		{
			key = "[b",
			action = ":bprev<cr>",
		},
		{
			key = "]b",
			action = ":bnext<cr>",
		},
		{
			key = "<leader>n",
			action = ":tabnew<cr>",
		},
		{
			key = "<a-h>",
			action = ":tabprev<cr>",
		},
		{
			key = "<a-l>",
			action = ":tabnext<cr>",
		},
		{
			key = "<a-tab>",
			action = "g<tab>",
		},
		{
			key = "<a-q>",
			action = ":tabclose<cr>",
		},
		{
			key = "<c-h>",
			action = "<c-w>h",
		},
		{
			key = "<c-j>",
			action = "<c-w>j",
		},
		{
			key = "<c-k>",
			action = "<c-w>k",
		},
		{
			key = "<c-l>",
			action = "<c-w>l",
		},
		{
			key = "<c-tab>",
			action = "<c-w>w",
		},
		{
			key = "<c-q>",
			action = "<c-w>q",
		},
		{
			key = "<esc>",
			action = ":nohl<cr>",
			opts = { noremap = false },
		},
	},

	filetype = {
		pattern = {
			[".env"] = "properties",
			[".env.*"] = "properties",
			[".env.*.local"] = "properties",
		},
	},

	autocmd = {
		{
			event = { "FileType" },
			pattern = { "qf", "checkhealth" },
			command = "setlocal nospell",
		},
		{
			event = { "TextYankPost" },
			callback = function()
				vim.highlight.on_yank()
			end,
		},
	},
})
