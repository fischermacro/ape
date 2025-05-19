local HttpService = game:GetService("HttpService")
local githubUser = "fischermacro"
local repoName = "ape"
local branch = "main"
local repoAPI = "https://api.github.com/repos/" .. githubUser .. "/" .. repoName .. "/contents/"
local rawBase = "https://raw.githubusercontent.com/" .. githubUser .. "/" .. repoName .. "/" .. branch .. "/"

local function isfile(path)
	local ok, result = pcall(function() return readfile(path) end)
	return ok and result and result ~= ""
end

local function makepath(path)
	local segments = {}
	for segment in path:gmatch("[^/]+") do
		table.insert(segments, segment)
	end
	for i = 1, #segments - 1 do
		local dir = table.concat(segments, "/", 1, i)
		if not isfolder(dir) then makefolder(dir) end
	end
end

local function downloadRaw(path)
	local url = rawBase .. path
	local success, result = pcall(function()
		return game:HttpGet(url)
	end)
	if not success or result == "404: Not Found" then
		error("Failed to download: " .. path)
	end
	return result
end

local function downloadRecursive(repoPath, localPath)
	local data = HttpService:JSONDecode(game:HttpGet(repoAPI .. repoPath))

	for _, item in ipairs(data) do
		if item.type == "file" then
			local path = localPath .. "/" .. item.name
			local content = downloadRaw(repoPath .. "/" .. item.name)
			makepath(path)
			writefile(path, content)
		elseif item.type == "dir" then
			local subRepoPath = repoPath .. "/" .. item.name
			local subLocalPath = localPath .. "/" .. item.name
			if not isfolder(subLocalPath) then makefolder(subLocalPath) end
			downloadRecursive(subRepoPath, subLocalPath)
		end
	end
end

-- 📂 Create root
if not isfolder("ape") then makefolder("ape") end

-- ⬇ Download everything from repo
downloadRecursive("", "ape")

-- 🚀 Run Gui.Ape.lua after loading
local entry = "ape/lib/Gui.Ape.lua"
if isfile(entry) then
	loadstring(readfile(entry))()
else
	warn("Gui.Ape.lua not found in lib/")
end
