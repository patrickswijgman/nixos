local M = {}

M.buf = nil
M.win = nil
M.query = "."

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

	for k, v in pairs(opts or {}) do
		vim.api.nvim_set_option_value(k, v, { win = win })
	end

	return win
end

local function with_input(opts, on_confirm)
	vim.ui.input(opts, function(input)
		if input and input ~= "" then
			on_confirm(input)
		end
	end)
end

local function keymap(key, action)
	vim.keymap.set("n", key, action, { buffer = M.buf, noremap = true, silent = true })
end

local function refresh()
	local files = vim.fn.systemlist("fd --type=file --type=directory --full-path --hidden --exclude='.git' " .. M.query)
	vim.api.nvim_set_option_value("modifiable", true, { buf = M.buf })
	vim.api.nvim_buf_set_lines(M.buf, 0, -1, false, files)
	vim.api.nvim_set_option_value("modifiable", false, { buf = M.buf })
end

local function search(query)
	vim.fn.search("^" .. vim.fn.escape(query, "/"), "w")
end

local function close()
	vim.api.nvim_win_close(M.win, true)
	vim.cmd("nohl")
end

local function open()
	local file = vim.api.nvim_get_current_line()
	close()
	vim.cmd.edit(file)
end

local function add()
	with_input({
		prompt = "Add: ",
		default = vim.fn.fnamemodify(vim.api.nvim_get_current_line(), ":h") .. "/",
		completion = "file",
	}, function(target)
		vim.cmd("silent !touch " .. target)
		refresh()
		search(target)
	end)
end

local function move()
	local source = vim.api.nvim_get_current_line()
	with_input({
		prompt = "Move: ",
		default = source,
		completion = "file",
	}, function(target)
		vim.cmd("silent !mv " .. source .. " " .. target)
		refresh()
		search(target)
	end)
end

local function delete()
	local source = vim.api.nvim_get_current_line()
	with_input({
		prompt = "Delete: ",
		default = source,
		completion = "file",
	}, function(target)
		vim.cmd("silent !rm -rf " .. target)
		refresh()
		search(vim.fn.fnamemodify(source, ":h"))
	end)
end

local function command()
	local current_file = vim.fn.expand("%")

	M.buf = vim.api.nvim_create_buf(false, true)

	refresh()

	M.win = create_float_win(M.buf, "Explore", 0.8, 0.8, { spell = false, cursorline = true })

	search(current_file)

	keymap("<cr>", open)
	keymap("a", add)
	keymap("m", move)
	keymap("d", delete)
	keymap("q", close)
	keymap("<esc>", close)
end

function M.setup()
	vim.api.nvim_create_user_command("Explorer", command, {})
end

return M
