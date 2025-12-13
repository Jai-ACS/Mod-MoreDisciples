local Mod = GameMain:GetMod("Jai_MoreDisciples")
local Adapter = GameMain:GetMod("Jai_HotkeyAdapter")

local Windows = GameMain:GetMod("Windows")
local Jai_MoreDisciplesWindow = Windows:CreateWindow("Jai_MoreDisciplesWindow")

local sizes = {
	{6,12,18,24},
	{12,12,24,36},
	{48,48,60,72}
}

function Mod:OnLoad(tbLoad)
    self.data = tbLoad or {}
	self.data.index = self.data.index or 1
	
    self:setMaxDisciples(self.data.index)
end

function Mod:OnSave()
	local data = self.data or {}
	data.index = data.index or 1
	return data
end

function Mod:OnInit()
	-- self.data = self.data or {}
	self:registerAdapter()
end

function Mod:registerAdapter()
	if Adapter == nil then
		return
	end
	
	Adapter:register("More Disciples", "Configure...",
		function()
			Jai_MoreDisciplesWindow:Show()
		end
	)
end

function Mod:setMaxDisciples(index)
	CS.XiaWorld.GameDefine.SchoolMaxNpc = sizes[index]
	CS.XiaWorld.GameDefine.SchoolMaxDNpc = sizes[index]
end

function Jai_MoreDisciplesWindow:OnInit()
	-- self.window.contentPane = UIPackage.CreateObject("Jai_MoreDisciples", "ConfigWindow")
	-- self.window.closeButton = self:GetChild("frame"):GetChild("n5")
	-- self.window:Center()
	
	-- local frame = self:GetChild("frame")
	-- frame.title = "More Disciples"

	-- local titleBox = frame:GetChild("n6")
	-- local titleText = frame:GetChild("title")

	-- titleBox.maxWidth = 200
	-- titleText.autoSize = CS.FairyGUI.AutoSizeType.Both
	-- titleBox.width = titleText.width + 100
	-- titleText.fontsize = 18
	-- titleBox.height = 50
	-- titleText.y = titleBox.y + (titleBox.height - titleText.height) / 2

	-- if Mod.data == nil then
	-- 	return
	-- end

	-- --local group = self:GetChild("options")
	-- --local optionDefault = group:GetChild("option-default")
	-- --local optionDesktop = group:GetChild("option-desktop")
	-- --local optionMax = group:GetChild("option-max")
	
	-- local radioController = self:GetController("radio")
	-- radioController.onChanged:Add(
	-- 	function(context)
	-- 		local controller = context.sender;
	-- 		local index = controller.selectedIndex;

	-- 		Mod.data = Mod.data or {}
	-- 		Mod.data.index = index
			
	-- 		Mod:setMaxDisciples(index)
	-- 	end
	-- )
end
