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
		hlsearch = false,
		incsearch = true,

		tabstop = 2,
		softtabstop = 2,
		shiftwidth = 2,
		expandtab = true,
		autoindent = true,

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

	colorscheme = {
		name = "catppuccin",
	},

	plugins = {
		{
			name = "plugins.find",
		},
		{
			name = "plugins.grep",
		},
		{
			name = "auto-session",
		},
		{
			name = "nvim-treesitter.configs",
			opts = {
				highlight = {
					enable = true,
				},
			},
		},
		{
			name = "conform",
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
				name = "nil_ls",
			},
			{
				name = "lua_ls",
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
							library = {
								vim.env.VIMRUNTIME,
							},
						},
					},
				},
			},
			{
				name = "ts_ls",
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
				action = ":lua vim.lsp.buf.definition()<cr>",
			},
			{
				key = "gt",
				action = ":lua vim.lsp.buf.type_definition()<cr>",
			},
			{
				key = "gr",
				action = ":lua vim.lsp.buf.references()<cr>",
			},
			{
				key = "<leader>a",
				action = ":lua vim.lsp.buf.code_action()<cr>",
			},
			{
				key = "<leader>r",
				action = ":lua vim.lsp.buf.rename()<cr>",
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
			command = ":lua vim.highlight.on_yank()",
		},
	},

	commands = {},
})
