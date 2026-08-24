return { -- Linting. conform.nvim handles formatting; this is the diagnostics half.
	"mfussenegger/nvim-lint",
	event = { "BufReadPost", "BufWritePost", "BufNewFile" },
	config = function()
		local lint = require("lint")

		-- nvim-lint ships a `cmakelint` linter for the pip package of that name, which
		-- is NOT what is installed here: mason's `cmakelang` provides `cmake-lint`, a
		-- different tool with a different output format. Point the built-in at the
		-- wrong binary and cmake linting silently never runs, so define our own.
		--
		--   built-in expects:  file:12: message [C0103]
		--   cmake-lint emits:  file:03,04: [C0103] message
		--
		-- cmake-lint columns are 0-based, hence col_offset = 0 (nvim-lint's default of
		-- -1 assumes 1-based and would shift every diagnostic one column left).
		lint.linters["cmake-lint"] = {
			cmd = "cmake-lint",
			stdin = false,
			ignore_exitcode = true,
			parser = require("lint.parser").from_pattern(
				"([^:]+):(%d+),(%d+): %[(%a)(%d+)%] (.+)",
				{ "file", "lnum", "col", "severity", "code", "message" },
				{
					C = vim.diagnostic.severity.HINT, -- convention
					R = vim.diagnostic.severity.INFO, -- refactor
					W = vim.diagnostic.severity.WARN,
					E = vim.diagnostic.severity.ERROR,
				},
				{ source = "cmake-lint" },
				{ col_offset = 0 }
			),
		}

		-- Deliberately does NOT duplicate what the language servers already report:
		-- clangd runs --clang-tidy (see lspconfig.lua) and pyright covers Python types.
		-- These fill the shell / markdown / yaml / cmake gap instead.
		lint.linters_by_ft = {
			sh = { "shellcheck" },
			bash = { "shellcheck" },
			python = { "ruff" },
			markdown = { "markdownlint-cli2" },
			yaml = { "yamllint" },
			cmake = { "cmake-lint" },
		}

		local group = vim.api.nvim_create_augroup("user-nvim-lint", { clear = true })

		-- Skip linters whose binary is absent rather than letting nvim-lint raise an
		-- error per save. Mason installs them lazily, so there is a window on a fresh
		-- machine where the filetype is configured but the tool is not yet on disk.
		local function lint_available()
			local names = lint.linters_by_ft[vim.bo.filetype]
			if not names then
				return
			end
			local runnable = {}
			for _, name in ipairs(names) do
				local linter = lint.linters[name]
				local cmd = type(linter) == "table" and linter.cmd or nil
				if cmd and vim.fn.executable(cmd) == 1 then
					table.insert(runnable, name)
				end
			end
			if #runnable > 0 then
				lint.try_lint(runnable)
			end
		end

		vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
			group = group,
			callback = lint_available,
		})

		vim.keymap.set("n", "<leader>ll", lint_available, { desc = "LSP: [L]int buffer now" })
	end,
}
