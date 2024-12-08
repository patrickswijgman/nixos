local M = {}

local function iter(tbl, fn)
	return fn(tbl or {})
end

local function call(fn, ...)
	if fn then
		return fn(...)
	end
end

function M.setup_options(options)
	for k, v in iter(options, pairs) do
		vim.opt[k] = v
	end
end

function M.setup_globals(globals)
	for k, v in iter(globals, pairs) do
		vim.g[k] = v
	end
end

function M.setup_keymaps(keymaps)
	for _, keymap in iter(keymaps, ipairs) do
		vim.keymap.set(
			keymap.mode or "n",
			keymap.key,
			keymap.action,
			vim.tbl_extend("force", { noremap = true, silent = true }, keymap.opts or {})
		)
	end
end

function M.setup_autocmd(autocmd)
	local group = vim.api.nvim_create_augroup("SimpleSetup", { clear = true })

	for _, cmd in iter(autocmd, ipairs) do
		vim.api.nvim_create_autocmd(cmd.event, {
			group = group,
			pattern = cmd.pattern,
			command = cmd.command,
			callback = cmd.callback,
		})
	end
end

function M.setup_commands(commands)
	for _, cmd in iter(commands, ipairs) do
		vim.api.nvim_create_user_command(cmd.name, cmd.command, cmd.opts or {})
	end
end

function M.setup_filetype(filetype)
	if not filetype then
		return
	end

	vim.filetype.add(filetype)
end

function M.setup_plugins(plugins)
	for _, plugin in iter(plugins, ipairs) do
		require(plugin[1]).setup(plugin.opts or {})

		if plugin.colorscheme then
			vim.cmd.colorscheme(plugin.colorscheme)
		end
	end
end

function M.setup_lsp(lsp)
	if not lsp then
		return
	end

	local lspconfig = require("lspconfig")
	local capabilities = vim.lsp.protocol.make_client_capabilities()

	for _, server in iter(lsp.servers, ipairs) do
		local function on_attach(client, bufnr)
			call(lsp.on_attach, client, bufnr)
			call(server.on_attach, client, bufnr)

			for _, keymap in iter(lsp.keymaps, ipairs) do
				vim.keymap.set("n", keymap.key, keymap.action, { buffer = bufnr, noremap = true, silent = true })
			end
		end

		lspconfig[server[1]].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			init_options = server.init_options,
			settings = server.settings,
		})
	end
end

function M.setup_colorscheme(colorscheme)
	if not colorscheme then
		return
	end

	require(colorscheme.module or colorscheme[1]).setup(colorscheme.opts or {})
end

function M.setup(opts)
	M.setup_options(opts.options)
	M.setup_globals(opts.globals)
	M.setup_lsp(opts.lsp)
	M.setup_plugins(opts.plugins)
	M.setup_keymaps(opts.keymaps)
	M.setup_autocmd(opts.autocmd)
	M.setup_commands(opts.commands)
	M.setup_filetype(opts.filetype)
end

return M
