local Mod = GameMain:GetMod("Jai_MoreDisciples")
local Adapter = GameMain:GetMod("Jai_HotkeyAdapter")

local sectSizes = {
	{06, 12, 18, 24},
	{12, 12, 24, 36},
	{48, 48, 60, 72}
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
	self:registerAdapter()
end

function Mod:registerAdapter()
	if Adapter == nil then
		return
	end

	if (MultiLanguage ~= nil) then
		MultiLanguage:Load("Jai_MoreDisciples")
	end
	
	Adapter:register(XT("增加弟子"), XT("设定"),
		function()
			-- Only create window when adapter is available
			local Windows = GameMain:GetMod("Windows")
			local window = Windows:CreateWindow("Jai_MoreDisciplesWindow")
			window.OnInit = OnConfigWindowInit
			window:Show()
		end
	)
end

function Mod:setMaxDisciples(index)
	CS.XiaWorld.GameDefine.SchoolMaxNpc = sectSizes[index]
	CS.XiaWorld.GameDefine.SchoolMaxDNpc = sectSizes[index]
end

function OnConfigWindowInit(self)
	self.window.contentPane = UIPackage.CreateObject("Jai_MoreDisciples", "ConfigWindow")
	self.window.closeButton = self:GetChild("frame"):GetChild("n5")
	self.window:Center()
	
	local frame = self:GetChild("frame")
	frame.title = XT("增加弟子")

	self:GetChild("option-default").title = XT("默认")
	self:GetChild("option-desktop").title = XT("和电脑版持平")
	self:GetChild("option-max").title = XT("最大增幅")

	Mod.data = Mod.data or {}
	local selectedIndex = Mod.data.index or 1
	if selectedIndex < 1 then
		selectedIndex = 1
	end
	
	local radioController = self.window.contentPane:GetController("radio")
	radioController:SetSelectedIndex(selectedIndex - 1) -- Lua's index start from 1, while FairyGUI's index start from 0
	radioController.onChanged:Add(
		function()
			local index = radioController.selectedIndex + 1
			
			if index > #sectSizes then
				index = #sectSizes
			end
			
			Mod.data.index = index
			Mod:setMaxDisciples(index)
		end
	)
end
