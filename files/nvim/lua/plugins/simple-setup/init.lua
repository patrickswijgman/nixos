local M = {}

local function setup_options(options)
	for k, v in pairs(options) do
		vim.opt[k] = v
	end
end

local function setup_globals(globals)
	for k, v in pairs(globals) do
		vim.g[k] = v
	end
end

local function setup_keymaps(keymaps)
	for _, keymap in ipairs(keymaps) do
		vim.keymap.set(
			keymap.mode or "n",
			keymap.key,
			keymap.action,
			vim.tbl_extend("force", { noremap = true, silent = true }, keymap.opts or {})
		)
	end
end

local function setup_autocmd(autocmd)
	local group = vim.api.nvim_create_augroup("UserConfig", { clear = true })

	for _, cmd in ipairs(autocmd) do
		vim.api.nvim_create_autocmd(cmd.event, {
			group = group,
			pattern = cmd.pattern,
			command = cmd.command,
			callback = cmd.callback,
		})
	end
end

local function setup_commands(commands)
	for _, cmd in ipairs(commands) do
		vim.api.nvim_create_user_command(cmd.name, cmd.command, cmd.opts or {})
	end
end

local function setup_filetype(filetype)
	vim.filetype.add(filetype)
end

local function setup_plugins(plugins)
	for _, plugin in ipairs(plugins) do
		require(plugin.name).setup(plugin.opts or {})
	end
end

local function setup_lsp(lsp)
	local config = require("lspconfig")
	local capabilities = vim.lsp.protocol.make_client_capabilities()

	local function on_attach(_, bufnr)
		for _, keymap in ipairs(lsp.keymaps) do
			vim.keymap.set("n", keymap.key, keymap.action, { buffer = bufnr, noremap = true, silent = true })
		end
	end

	for _, server in ipairs(lsp.servers) do
		config[server.name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			init_options = server.init_options,
			settings = server.settings,
		})
	end
end

local function setup_colorscheme(colorscheme)
	require(colorscheme.name).setup(colorscheme.opts or {})
	vim.cmd.colorscheme(colorscheme.name)
end

function M.setup(opts)
	setup_colorscheme(opts.colorscheme)
	setup_options(opts.options)
	setup_globals(opts.globals)
	setup_lsp(opts.lsp)
	setup_plugins(opts.plugins)
	setup_keymaps(opts.keymaps)
	setup_autocmd(opts.autocmd)
	setup_commands(opts.commands)
	setup_filetype(opts.filetype)
end

return M
