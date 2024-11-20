local M = {}

local function ends_with(str, char)
	return vim.fn.match(str, vim.fn.escape(char, "/") .. "$") ~= -1
end

local function set_buf_keymap(buf, key, callback)
	vim.api.nvim_buf_set_keymap(buf, "n", key, "", {
		noremap = true,
		silent = true,
		callback = callback,
	})
end

local function create_buf(listed, scratch, opts)
	local buf = vim.api.nvim_create_buf(listed, scratch)

	if opts then
		for key, value in pairs(opts) do
			vim.api.nvim_set_option_value(key, value, { buf = buf })
		end
	end

	return buf
end

local function create_float_win(buf, title, width, height, opts)
	local max_width = vim.o.columns
	local max_height = vim.o.lines

	if width < 1 then
		width = math.floor(max_width * width)
	end

	if height < 1 then
		height = math.floor(max_height * height)
	end

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		title = title,
		width = width,
		height = height,
		col = (max_width - width) / 2,
		row = (max_height - height) / 2,
		style = "minimal",
		border = "rounded",
	})

	if opts then
		for key, value in pairs(opts) do
			vim.api.nvim_set_option_value(key, value, { win = win })
		end
	end

	return win
end

local function get_files(query)
	local q = query or ""
	return vim.fn.systemlist("fd --type=file --full-path " .. q)
end

local function set_files_list(buf, files)
	vim.api.nvim_set_option_value("modifiable", true, { buf = buf })
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, files)
	vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
end

local function open_file(file, target_win, win)
	vim.api.nvim_set_current_win(target_win)
	vim.cmd("edit " .. file)
	vim.api.nvim_win_close(win, true)
end

local function focus_file(file)
	vim.fn.search(file, "w")
end

function M.open()
	local target_win = vim.api.nvim_get_current_win()
	local current_file = vim.fn.expand("%")

	local buf = create_buf(false, true, {
		buftype = "nofile",
		bufhidden = "wipe",
	})

	set_files_list(buf, get_files())

	local win = create_float_win(buf, vim.fn.getcwd(), 80, 0.5, {
		cursorline = true,
	})

	focus_file(current_file)

	set_buf_keymap(buf, "f", function()
		with_input("Filter > ", "file", function(input)
			local files = get_files(input)
			if #files == 1 then
				open_file(files[1], target_win, win)
			else
				set_files_list(buf, files)
			end
		end)
	end)

	set_buf_keymap(buf, "o", function()
		local file = vim.api.nvim_get_current_line()
		open_file(file, target_win, win)
	end)

	set_buf_keymap(buf, "<enter>", function()
		local file = vim.api.nvim_get_current_line()
		open_file(file, target_win, win)
	end)

	set_buf_keymap(buf, "a", function()
		with_input("Create file/directory > ", "dir", function(input)
			if ends_with(input, "/") then
				vim.fn.system("mkdir -p " .. input)
				set_files_list(buf, get_files())
			else
				vim.fn.system("touch " .. input)
				set_files_list(buf, get_files())
				focus_file(input)
			end
		end)
	end)

	set_buf_keymap(buf, "D", function()
		with_confirm("Delete file/directory?", "file", function(input)
			vim.fn.system("rm -rf " .. input)
			set_files_list(buf, get_files())
		end)
	end)

	set_buf_keymap(buf, "R", function()
		local files = get_files()
		set_files_list(buf, files)
	end)

	set_buf_keymap(buf, "q", function()
		vim.api.nvim_win_close(win, true)
	end)

	set_buf_keymap(buf, "<esc>", function()
		vim.api.nvim_win_close(win, true)
	end)
end

return M
