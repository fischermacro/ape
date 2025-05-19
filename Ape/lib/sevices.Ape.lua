-- ModuleScript named "ServiceSetup" (or whatever)
-- Put this in ReplicatedStorage or another shared place

local function sevices(clonesev)
	local services = {}

	services.playersService        = clonesev(game:GetService('Players'))
	services.replicatedStorage     = clonesev(game:GetService('ReplicatedStorage'))
	services.runService            = clonesev(game:GetService('RunService'))
	services.inputService          = clonesev(game:GetService('UserInputService'))
	services.tweenService          = clonesev(game:GetService('TweenService'))
	services.lightingService       = clonesev(game:GetService('Lighting'))
	services.marketplaceService    = clonesev(game:GetService('MarketplaceService'))
	services.teleportService       = clonesev(game:GetService('TeleportService'))
	services.httpService           = clonesev(game:GetService('HttpService'))
	services.guiService            = clonesev(game:GetService('GuiService'))
	services.groupService          = clonesev(game:GetService('GroupService'))
	services.textChatService       = clonesev(game:GetService('TextChatService'))
	services.contextService        = clonesev(game:GetService('ContextActionService'))
	services.coreGui               = clonesev(game:GetService('CoreGui'))

	return services
end

return sevices
