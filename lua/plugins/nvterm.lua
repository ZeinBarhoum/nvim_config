return {
	"zbirenbaum/nvterm",
	config = function()
		local width = 0.9
		local height = width
		local row = (1 - height) / 2
		local col = (1 - width) / 2

		require("nvterm").setup({
			terminals = {
				type_opts = {
					float = {
						relative = "editor",
						row = row,
						col = col,
						width = width,
						height = height,
						border = "single",
					},
				},
			},
		})
	end,
}
