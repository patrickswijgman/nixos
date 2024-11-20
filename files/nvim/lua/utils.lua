--  Prompts the user for input and then executes the `on_confirm` callback function with the provided input.
function _G.with_input(prompt, completion, on_confirm)
	vim.ui.input({ prompt = prompt, completion = completion }, function(input)
		if input and input ~= "" then
			on_confirm(input)
		end
	end)
end

-- Merge tables into the first given table.
function _G.merge(...)
	return vim.tbl_extend("force", ...)
end

-- Get the full absolute path of the current file.
function _G.get_current_file_path()
	return vim.fn.expand("%:p")
end

-- Get a list of files matching the query.
-- Supports the `wildignore` option.
function _G.list_files(query)
	return vim.fn.globpath("**", query .. "*", false, true)
end

-- Get a list of words starting with `starts_with` from the current buffer.
function _G.list_words(starts_with)
	local bufnr = vim.api.nvim_get_current_buf()
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	local words_list = {}
	local words_set = {}

	for _, line in ipairs(lines) do
		for word in line:gmatch("%a+") do
			if not words_set[word] then
				words_set[word] = true
				if word:find("^" .. starts_with) then
					table.insert(words_list, word)
				end
			end
		end
	end

	table.sort(words_list)

	return words_list
end
