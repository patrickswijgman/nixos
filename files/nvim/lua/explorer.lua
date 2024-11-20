local M = {}

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

local function delete_buf_with_filename(filename)
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		local name = vim.api.nvim_buf_get_name(buf)
		if name:match(filename) then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end
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
	return vim.fn.systemlist("fd --type=file --type=directory --full-path " .. q)
end

local function set_files_list(buf, items, focus_item)
	vim.api.nvim_set_option_value("modifiable", true, { buf = buf })
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, items)
	vim.api.nvim_set_option_value("modifiable", false, { buf = buf })

	if focus_item then
		vim.fn.search("^" .. focus_item, "w")
	end
end

local function open_file(file, target_win, win)
	vim.api.nvim_set_current_win(target_win)
	vim.cmd("edit " .. file)
	vim.api.nvim_win_close(win, true)
end

function M.open()
	local source_file = vim.fn.expand("%")
	local target_win = vim.api.nvim_get_current_win()
	local title = " Explorer - " .. vim.fn.getcwd() .. " "

	local buf = create_buf(false, true, {
		buftype = "nofile",
		bufhidden = "wipe",
	})

	local win = create_float_win(buf, title, 80, 0.8, {
		cursorline = true,
	})

	set_files_list(buf, get_files(), source_file)

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
			else
				vim.fn.system("touch " .. input)
			end
			set_files_list(buf, get_files(), input)
		end)
	end)

	set_buf_keymap(buf, "r", function()
		local file = vim.api.nvim_get_current_line()
		with_input("Move file/directory > ", "dir", function(input)
			vim.fn.system("mv " .. file .. " " .. input)
			set_files_list(buf, get_files(), input)
		end, file)
	end)

	set_buf_keymap(buf, "d", function()
		local item = vim.api.nvim_get_current_line()
		with_confirm("Delete" .. item .. " ?", function()
			delete_buf_with_filename(item)
			vim.fn.system("rm -rf " .. item)
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
