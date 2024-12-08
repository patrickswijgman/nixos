local M = {}

local function command(opts)
	vim.cmd("silent grep! " .. opts.fargs[1] .. " | botright copen")
end

local function complete(ArgLead)
	local bufnr = vim.api.nvim_get_current_buf()
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

	local words_list = {}
	local words_set = {}

	for _, line in ipairs(lines) do
		for word in line:gmatch("%a+") do
			if not words_set[word] then
				words_set[word] = true

				if word:find("^" .. ArgLead) then
					table.insert(words_list, word)
				end
			end
		end
	end

	table.sort(words_list)

	return words_list
end

function M.setup()
	vim.opt.grepprg = "rg --vimgrep --smart-case --sort=path"
	vim.api.nvim_create_user_command("Grep", command, { nargs = 1, complete = complete })
end

return M
