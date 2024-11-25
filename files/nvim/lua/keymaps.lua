local utils = require("utils")

vim.g.mapleader = " "

local function find()
	utils.with_input("Find", "", "customlist,v:lua.require'utils'.list_files", function(input)
		vim.cmd("silent find " .. input)
	end)
end

local function grep()
	local word = vim.fn.expand("<cword>")
	utils.with_input("Grep", word, "customlist,v:lua.require'utils'.list_words", function(input)
		vim.cmd("silent grep! " .. input .. " | Quickfix")
	end)
end

local function buffers()
	utils.with_input("Buffer", "", "buffer", function(input)
		vim.cmd("silent buffer " .. input)
	end)
end

local function help()
	local word = vim.fn.expand("<cword>")
	vim.cmd("silent help " .. word)
end

local function create()
	local dir = vim.fn.expand("%:h") .. "/"
	utils.with_input("Create", dir, "dir", function(input)
		if utils.ends_with(input, "/") then
			vim.cmd("silent !mkdir -p " .. input)
		else
			vim.cmd("silent !mkdir -p " .. utils.dirname(input))
			vim.cmd("silent !touch " .. input)
		end
	end)
end

local function move()
	local file = vim.fn.expand("%")
	utils.with_input("Move", file, "file", function(input)
		utils.delete_bufs_with_filename(file)
		vim.cmd("silent !mkdir -p " .. utils.dirname(input))
		vim.cmd("silent !mv " .. file .. " " .. input)
		vim.cmd("edit " .. input)
	end)
end

local function delete()
	local file = vim.fn.expand("%")
	utils.with_confirm("Delete " .. file, function()
		utils.delete_bufs_with_filename(file)
		vim.cmd("silent !rm -r " .. file)
	end)
end

local opts = { noremap = true, silent = true }

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', opts)
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', opts)

vim.keymap.set("n", "<leader>f", find, opts)
vim.keymap.set("n", "<leader>g", grep, opts)
vim.keymap.set("n", "<leader>h", help, opts)
vim.keymap.set("n", "<leader>c", create, opts)
vim.keymap.set("n", "<leader>m", move, opts)
vim.keymap.set("n", "<leader>d", delete, opts)
vim.keymap.set("n", "<leader>i", ":Inspect<cr>", opts)

vim.keymap.set("n", "<leader>q", ":Quickfix<cr>", opts)
vim.keymap.set("n", "]q", ":cnext<cr>", opts)
vim.keymap.set("n", "[q", ":cprev<cr>", opts)

vim.keymap.set("n", "<leader>b", buffers, opts)
vim.keymap.set("n", "]b", ":bnext<cr>", opts)
vim.keymap.set("n", "[b", ":bprev<cr>", opts)

vim.keymap.set("n", "<leader>t", ":tabnew<cr>", opts)
vim.keymap.set("n", "]t", ":tabnext<cr>", opts)
vim.keymap.set("n", "[t", ":tabprev<cr>", opts)
vim.keymap.set("n", "<a-h>", ":tabprev<cr>", opts)
vim.keymap.set("n", "<a-l>", ":tabnext<cr>", opts)
vim.keymap.set("n", "<a-q>", ":tabclose<cr>", opts)
vim.keymap.set("n", "<a-tab>", "g<tab>", opts)

vim.keymap.set("n", "<leader>z", ":ZenMode<cr>", opts)

vim.keymap.set("n", "<c-h>", "<c-w>h", opts)
vim.keymap.set("n", "<c-j>", "<c-w>j", opts)
vim.keymap.set("n", "<c-k>", "<c-w>k", opts)
vim.keymap.set("n", "<c-l>", "<c-w>l", opts)
vim.keymap.set("n", "<c-q>", "<c-w>q", opts)
vim.keymap.set("n", "<c-tab>", "<c-w>w", opts)

vim.keymap.set({ "n", "v" }, "q", "", opts)
vim.keymap.set({ "n", "v" }, "Q", "", opts)
