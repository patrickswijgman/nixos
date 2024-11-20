--  Prompts the user for input and then executes the `on_confirm` callback function with the provided input.
function _G.with_input(prompt, completion, on_confirm, default)
	vim.ui.input({ prompt = prompt, completion = completion, default = default }, function(input)
		if input and input ~= "" then
			on_confirm(input)
		end
	end)
end

--  Prompts the user for confirmation and then executes the `on_confirm` callback function if the user confirms.
function _G.with_confirm(prompt, on_confirm)
	vim.ui.input({ prompt = prompt .. " (y/n) " }, function(input)
		if input and (input == "y" or input == "Y") then
			on_confirm()
		end
	end)
end

-- Check if a string ends with the given string.
function _G.ends_with(str, tail)
	return str:match(tail .. "$")
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
