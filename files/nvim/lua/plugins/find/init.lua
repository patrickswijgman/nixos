local M = {}

function M.setup()
	vim.api.nvim_create_user_command("Find", function(opts)
		vim.cmd.edit(opts.fargs[1])
	end, {
		nargs = 1,
		complete = function(ArgLead)
			return vim.fn.systemlist("fd --type=file --full-path --hidden --exclude='.git' " .. ArgLead)
		end,
	})
end

return M
