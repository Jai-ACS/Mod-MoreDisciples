local Mod = GameMain:GetMod("Jai_MoreDisciples");--先注册一个新的MOD模块

local Windows = GameMain:GetMod("Windows")
local tbWindow = Windows:CreateWindow("Jai_MoreDisciplesWindow")

local sizes = {
	{6,12,18,24},
	{12,12,24,36},
	{48,48,60,72}
}

function Mod:OnEnter()
	CS.XiaWorld.GameDefine.SchoolMaxNpc = {6,12,18,24}

	CS.XiaWorld.GameDefine.SchoolMaxDNpc ={6,12,18,24};
end

function tbWindow:OnInit()
	self.window.contentPane = UIPackage.CreateObject("Jai_MoreDisciples", "ConfigWindow")
	self.window.closeButton = self:GetChild("frame"):GetChild("n5")
	self.window:Center()
	
	local frame = self:GetChild("frame")
	--frame.title = XT("快捷键连接器")
	frame.title = "More Disciples"

	local titleBox = frame:GetChild("n6")
	local titleText = frame:GetChild("title")

	titleBox.maxWidth = 200
	titleText.autoSize = CS.FairyGUI.AutoSizeType.Both
	titleBox.width = titleText.width + 100
	titleText.fontsize = 18
	titleBox.height = 50
	titleText.y = titleBox.y + (titleBox.height - titleText.height) / 2

	if Mod.data == nil then
		return
	end

	--local group = self:GetChild("options")
	--local optionDefault = group:GetChild("option-default")
	--local optionDesktop = group:GetChild("option-desktop")
	--local optionMax = group:GetChild("option-max")
	
	local radioController = self:GetController("radio")
	radioController.onChanged:Add(
		function(context)
			local controller = context.sender;
			local index = controller.selectedIndex;
			
			CS.XiaWorld.GameDefine.SchoolMaxNpc = sizes[index]
			CS.XiaWorld.GameDefine.SchoolMaxDNpc = sizes[index]
		end
	)
end