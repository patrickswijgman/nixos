require("auto-session").setup({
	use_git_branch = true,
	session_lens = {
		load_on_setup = false,
	},
})

require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
	},
})

require("colorizer").setup({
	user_default_options = {
		RGB = true,
		RRGGBB = true,
		RRGGBBAA = true,
		names = false,
		rgb_fn = false,
		hsl_fn = false,
		css = false,
		css_fn = false,
		mode = "background",
	},
})

require("zen-mode").setup({
	window = {
		width = 120,
	},
})
