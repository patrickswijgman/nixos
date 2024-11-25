local M = {}

function M.with_input(prompt, default, completion, on_confirm)
	vim.ui.input({ prompt = prompt .. ": ", default = default, completion = completion }, function(input)
		if input and input ~= "" then
			on_confirm(input)
		end
	end)
end

function M.with_confirm(prompt, on_confirm)
	vim.ui.input({ prompt = prompt .. " (y/n): " }, function(input)
		if input == "y" or input == "Y" then
			on_confirm()
		end
	end)
end

function M.list_files(query)
	return vim.fn.systemlist("fd --type=file --full-path --hidden --exclude='.git' " .. query)
end

function M.list_words(starts_with)
	local bufs = vim.api.nvim_list_bufs()
	local words_list = {}
	local words_set = {}

	for _, buf in ipairs(bufs) do
		if vim.api.nvim_buf_is_loaded(buf) then
			local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

			for _, line in ipairs(lines) do
				for word in line:gmatch("%a+") do
					if not words_set[word] then
						words_set[word] = true
						if word:find("^" .. starts_with) then
							words_list[#words_list + 1] = word
						end
					end
				end
			end
		end
	end

	table.sort(words_list)

	return words_list
end

function M.ends_with(str, tail)
	return str:match(tail .. "$")
end

function M.dirname(file)
	return vim.fn.fnamemodify(file, ":h")
end

function M.delete_bufs_with_filename(filename)
	local bufs = vim.api.nvim_list_bufs()

	for _, buf in ipairs(bufs) do
		local name = vim.api.nvim_buf_get_name(buf)

		if name:match("^" .. vim.pesc(filename)) then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end
end

return M
