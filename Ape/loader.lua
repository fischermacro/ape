local isfile = isfile or function(file)
	local suc, res = pcall(function()
		return readfile(file)
	end)
	return suc and res ~= nil and res ~= ''
end

local delfile = delfile or function(file)
	writefile(file, '')
end

local function downloadFile(path, func)
	if not isfile(path) then
		local suc, res = pcall(function()
			local branch = readfile("ape/meta.txt")
			local baseUrl = "https://raw.githubusercontent.com/fischermacro/ape/" .. branch .. "/"
			return game:HttpGet(baseUrl .. path, true)
		end)
		if not suc or res == '404: Not Found' then
			error(res)
		end
		if path:find(".lua") then
			res = "--autogen: do not remove unless customizing persist\n" .. res
		end
		writefile("ape/" .. path, res)
	end
	return (func or readfile)("ape/" .. path)
end

local function wipeFolder(path)
	if not isfolder(path) then return end
	for _, file in listfiles(path) do
		if isfile(file) and select(1, readfile(file):find("--autogen")) == 1 then
			delfile(file)
		end
	end
end

for _, folder in { "ape" } do
	if not isfolder(folder) then
		makefolder(folder)
	end
end

if not isfile("ape/meta.txt") then
	writefile("ape/meta.txt", "main") -- change "main" to your branch if needed
end

-- wipe old cache if needed
wipeFolder("ape")

-- ⬇️ MAIN EXECUTE
return loadstring(downloadFile("Gui.Ape.lua"), "ape-main")()
