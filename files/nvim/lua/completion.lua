-- Auto complete file names.
function _G.find_completion(arg_lead)
	return vim.fn.globpath("**", arg_lead .. "*", false, true)
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
