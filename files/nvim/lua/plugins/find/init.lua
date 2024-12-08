local M = {}

local function command(opts)
	vim.cmd("silent find " .. opts.fargs[1])
end

local function complete(ArgLead)
	return vim.fn.systemlist("fd --type=file --full-path --hidden --exclude='.git' " .. ArgLead)
end

function M.setup()
	vim.api.nvim_create_user_command("Find", command, { nargs = 1, complete = complete })
end

return M
