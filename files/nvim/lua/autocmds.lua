local group = vim.api.nvim_create_augroup("UserConfig", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
	group = group,
	pattern = "*.nix",
	callback = function()
		vim.cmd("silent !nixfmt " .. vim.fn.expand("%"))
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	group = group,
	pattern = "*.lua",
	callback = function()
		vim.cmd("silent !stylua " .. vim.fn.expand("%"))
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	group = group,
	pattern = "*.html,*.css,*.js,*.jsx,*.ts,*.tsx,*.json,*.yaml,*.md",
	callback = function()
		vim.cmd("silent !prettier --write " .. vim.fn.expand("%"))
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	group = group,
	pattern = "*.go",
	callback = function()
		vim.cmd("silent !gofmt -w " .. vim.fn.expand("%"))
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	group = group,
	pattern = "*.rs",
	callback = function()
		vim.cmd("silent !rustfmt " .. vim.fn.expand("%"))
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = group,
	pattern = "qf,checkhealth",
	callback = function()
		vim.opt_local.spell = false
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	group = group,
	callback = function()
		vim.highlight.on_yank()
	end,
})
