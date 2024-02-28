require("neorg").setup({
	load = {
		["core.defaults"] = {},
		["core.dirman"] = {
			config = {
				workspaces = {
					work = "~/notes/work",
					home = "~/notes/home",
				},
				--open_last_workspace = true,
			},
		},
		["core.concealer"] = {},
		--["core.completion"] = {
		--	config = {
		--		engine = "nvim-cmp",
		--	},
		--},
	},
})
