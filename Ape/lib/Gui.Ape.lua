local sevices = loadstring(readfile("sevices.lua"))()

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- UI Setup
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ModuleFrames"
screenGui.Parent = PlayerGui

local holder = Instance.new("Frame")
holder.Name = "FrameHolder"
holder.Size = UDim2.new(0, 175 * 5, 0, 600)
holder.Position = UDim2.new(0, 0, 0, 0)
holder.BackgroundTransparency = 1
holder.Parent = screenGui

local layout = Instance.new("UIListLayout")
layout.FillDirection = Enum.FillDirection.Horizontal
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 25)
layout.Parent = holder

-- ape system
ape = {}

function ape:CreateCategory(data)
	assert(data and data.Name, "Category must have a Name")

	local name = string.lower(data.Name)

	local category = {
		Modules = {}
	}

	-- Make main frame
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(0, 175, 0, 600)
	frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	frame.BorderSizePixel = 0
	frame.Parent = holder

	-- Title
	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, 0, 0, 30)
	title.BackgroundTransparency = 1
	title.TextColor3 = Color3.new(1, 1, 1)
	title.TextScaled = true
	title.Font = Enum.Font.SourceSansBold
	title.Text = data.Name
	title.Parent = frame

	-- Module list
	local moduleHolder = Instance.new("Frame")
	moduleHolder.Size = UDim2.new(1, 0, 1, -30)
	moduleHolder.Position = UDim2.new(0, 0, 0, 30)
	moduleHolder.BackgroundTransparency = 1
	moduleHolder.Parent = frame

	local moduleLayout = Instance.new("UIListLayout")
	moduleLayout.SortOrder = Enum.SortOrder.LayoutOrder
	moduleLayout.Parent = moduleHolder

	-- CreateModule method
	function category:CreateModule(moduel)
		assert(moduel and moduel.Name, "Module must have a Name")

		self.Modules[moduel.Name] = moduel

		local label = Instance.new("TextLabel")
		label.Size = UDim2.new(1, 0, 0, 25)
		label.BackgroundTransparency = 1
		label.TextColor3 = Color3.new(1, 1, 1)
		label.TextScaled = true
		label.Font = Enum.Font.SourceSans
		label.Parent = moduleHolder
		label.Text = moduel.Name

	end

	-- Register it under ape by lowercase name
	ape[name] = category
	return category
end


combat = ape:CreateCategory({
	Name = "combat"
})

movment = ape:CreateCategory({
	Name = "movment"
})

ape.combat:CreateModule({
	Name = "Velocity",
	Value = 999
})

ape.combat:CreateModule({
	Name = "reach",
	Value = 999
})

print(sevices)