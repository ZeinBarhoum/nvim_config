return {
	"MeanderingProgrammer/render-markdown.nvim",
	-- NOTE: `ft` previously listed only copilot-chat and Avante -- neither plugin was
	-- installed, and "markdown" was missing -- so this never loaded for anything,
	-- including plain .md files. codecompanion's chat buffer is the live consumer now.
	opts = {
		file_types = { "markdown", "codecompanion" },
	},
	ft = { "markdown", "codecompanion" },
}
