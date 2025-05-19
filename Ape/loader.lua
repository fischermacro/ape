makefolder("ape")

local response = syn.request({
    Url = "https://your-link.com/sevices.lua",
    Method = "GET"
})

writefile("ape/sevices.lua", response.Body)
