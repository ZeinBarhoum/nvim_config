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

print(get_distro())
