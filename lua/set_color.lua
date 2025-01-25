-- first check which ditro used
local function get_distro()
	local distro = ""
	local os_release = "/etc/os-release"
	local file = io.open(os_release, "r")
	if file then
		for line in file:lines() do
			if line:match("^PRETTY_NAME=") then
				distro = line:gsub('^PRETTY_NAME="(.*)"$', "%1")
				break
			end
		end
		file:close()
	end
	return distro
end

local distro = get_distro()

-- In order to understand if I am inside distrobox or not
if distro:find("Arch") then
	require("onedark").setup({
		style = "darker",
	})
	-- require("onedark").load()
	vim.cmd.colorscheme("onedark")
else
	vim.cmd.colorscheme("tokyonight-night")
end

vim.cmd.hi("Comment gui=none")
