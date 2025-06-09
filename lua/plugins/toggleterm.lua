return {
	"akinsho/toggleterm.nvim",
	version = "*",
	event = "VeryLazy",
	config = function()
		require("toggleterm").setup({
			-- size can be a number or function which is passed the current terminal
			size = function(term)
				if term.direction == "horizontal" then
					return vim.o.lines * 0.4
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				elseif term.direction == "float" then
					return vim.o.columns * 0.8
				end
			end,
		})
	end,
}
