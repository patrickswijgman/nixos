--  Prompts the user for input and then executes the `on_confirm` callback function with the provided input.
function _G.with_input(prompt, completion, on_confirm)
	vim.ui.input({ prompt = prompt, completion = completion }, function(input)
		if input and input ~= "" then
			on_confirm(input)
		end
	end)
end

-- Merge table `b` into table `a`.
function _G.merge(a, b)
	return vim.tbl_extend("force", a, b)
end

-- Get the full absolute path of the current file.
function _G.get_current_file_path()
	return vim.fn.expand("%:p")
end
