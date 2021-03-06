local ADDON, Engine = ...
local Module = Engine:NewModule("Blizzard: Styling")
local C = Engine:GetStaticConfig("Data: Colors")

-- Lua API
local _G = _G
local pairs = pairs
local select = select
local string_find = string.find
local string_split = string.split
local unpack = unpack

-- List of elements to be styled
local elements = {
	["CharacterFrame"] = true,
	["CharacterFrameInset"] = true,
	["CharacterFrameInsetRight"] = true,
	["CharacterModelFrame"] = true,
	["CharacterFrameTab1"] = true,
	["CharacterFrameTab2"] = true,
	["CharacterFrameTab3"] = true,
	["CharacterFrameTab4"] = true,
	["CharacterFrameTab5"] = true,
	["ContainerFrame1"] = true,
	["ContainerFrame2"] = true,
	["ContainerFrame3"] = true,
	["ContainerFrame4"] = true,
	["ContainerFrame5"] = true,
	["ContainerFrame6"] = true,
	["ContainerFrame7"] = true,
	["ContainerFrame8"] = true,
	["ContainerFrame9"] = true,
	["ContainerFrame10"] = true,
	["ContainerFrame11"] = true,
	["ContainerFrame12"] = true,
	["ContainerFrame13"] = true,
	["GroupFinderFrame"] = true, 
	["GroupFinderFrameGroupButton1"] = true, 
	["GroupFinderFrameGroupButton2"] = true, 
	["GroupFinderFrameGroupButton3"] = true, 
	["GroupFinderFrameGroupButton4"] = true, 
	["LFDParentFrame"] = true, 
	["LFDParentFrameInset"] = true, 
	["LFDQueueFrame"] = true,
	["LFDQueueFrameFindGroupButton"] = true,
	["LFDQueueFrameTypeDropDown"] = true,
	["LFDQueueFrameRandom"] = true,
	["LFDQueueFrameSpecificListScrollFrame"] = true,
	["LFDQueueFrameSpecificListScrollFrameScrollBar"] = true,
	["LFDQueueFrameSpecificListScrollFrameScrollBarScrollUpButton"] = true,
	["LFDQueueFrameSpecificListScrollFrameScrollBarScrollDownButton"] = true,
	["LFGListFrame"] = true,
	["LFGListFrame.CategorySelection.Inset"] = true,
	["LFGListFrame.CategorySelection.StartGroupButton"] = true,
	["LFGListFrame.CategorySelection.FindGroupButton"] = true,
	["LFGListFrame.SearchPanel"] = true,
	["LFGListFrame.SearchPanel.BackButton"] = true,
	["LFGListFrame.SearchPanel.FilterButton"] = true,
	["LFGListFrame.SearchPanel.ResultsInset"] = true,
	["LFGListFrame.SearchPanel.SearchBox"] = true,
	["LFGListFrame.SearchPanel.SignUpButton"] = true,
	["LFGListSearchPanelScrollFrame.StartGroupButton"] = true,
	["LFGListSearchPanelScrollFrameScrollBar"] = true,
	["LFGListSearchPanelScrollFrameScrollBarScrollDownButton"] = true,
	["LFGListSearchPanelScrollFrameScrollBarScrollUpButton"] = true,
	["PaperDollFrame"] = true,
	["PaperDollEquipmentManagerPaneScrollBar"] = true,
	["PaperDollEquipmentManagerPaneScrollBarScrollDownButton"] = true,
	["PaperDollEquipmentManagerPaneScrollBarScrollUpButton"] = true,
	["PaperDollTitlesPaneScrollBar"] = true,
	["PaperDollTitlesPaneScrollBarScrollDownButton"] = true,
	["PaperDollTitlesPaneScrollBarScrollUpButton"] = true,
	["PaperDollItemsFrame"] = true,
	["PlayerStatFrameLeftDropDown"] = true,
	["PlayerStatFrameLeftDropDownButton"] = true,
	["PlayerStatFrameRightDropDown"] = true,
	["PlayerStatFrameRightDropDownButton"] = true,
	["PlayerTitleFrame"] = true,
	["PlayerTitleFrameButton"] = true,
	
	["PVEFrame"] = true,
	["PVEFrame.shadows"] = true,
	["PVEFrameLeftInset"] = true,
	["PVEFrameTab1"] = true,
	["PVEFrameTab2"] = true,
	["PVEFrameTab3"] = true,
	["RaidFinderFrame"] = true,
	["RaidFinderFrameBottomInset"] = true,
	["RaidFinderFrameFindRaidButton"] = true,
	["RaidFinderQueueFrame"] = true,
	["RaidFinderQueueFrameSelectionDropDown"] = true,
	["RaidFinderFrameRoleInset"] = true,
	["SpellBookFrame"] = true,
	["SpellBookSkillLineTab1"] = true,
	["SpellBookSkillLineTab2"] = true,
	["SpellBookSkillLineTab3"] = true,
	["SpellBookSkillLineTab4"] = true,
	["SpellBookSkillLineTab5"] = true,
	["SpellBookSkillLineTab6"] = true,
	["SpellBookSkillLineTab7"] = true,
	["SpellBookSkillLineTab8"] = true,
	["WorldMapFrame"] = true,
	["WorldMapFrame.BorderFrame"] = true,

	["ConquestFrame"] = "Blizzard_PVPUI",
	["ConquestFrame.Inset"] = "Blizzard_PVPUI",
	["ConquestFrame.RoleInset"] = "Blizzard_PVPUI",
	["ConquestJoinButton"] = "Blizzard_PVPUI",

	["HonorFrame"] = "Blizzard_PVPUI",
	["HonorFrame.Inset"] = "Blizzard_PVPUI",
	["HonorFrame.RoleInset"] = "Blizzard_PVPUI",
	["HonorFrameQueueButton"] = "Blizzard_PVPUI",
	["HonorFrameTypeDropDown"] = "Blizzard_PVPUI",
	["PVPQueueFrameCategoryButton1"] = "Blizzard_PVPUI",
	["PVPQueueFrameCategoryButton2"] = "Blizzard_PVPUI",
	["PVPQueueFrameCategoryButton3"] = "Blizzard_PVPUI",
	["PVPQueueFrameCategoryButton4"] = "Blizzard_PVPUI",

	["WarGamesFrame"] = "Blizzard_PVPUI",
	["WarGamesFrame.HorizontalBar"] = "Blizzard_PVPUI",
	["WarGamesFrame.RightInset"] = "Blizzard_PVPUI",
	["WarGamesFrameInfoScrollFrameScrollBar"] = "Blizzard_PVPUI",
	["WarGamesFrameInfoScrollFrameScrollBarScrollUpButton"] = "Blizzard_PVPUI",
	["WarGamesFrameInfoScrollFrameScrollBarScrollDownButton"] = "Blizzard_PVPUI",
	["WarGamesFrameScrollFrameScrollBar"] = "Blizzard_PVPUI",
	["WarGamesFrameScrollFrameScrollBarScrollUpButton"] = "Blizzard_PVPUI",
	["WarGamesFrameScrollFrameScrollBarScrollDownButton"] = "Blizzard_PVPUI",
	["WarGameStartButton"] = "Blizzard_PVPUI",

	["PlayerTalentFrame"] = "Blizzard_TalentUI",
	["PlayerTalentFrameTab1"] = "Blizzard_TalentUI",
	["PlayerTalentFrameTab2"] = "Blizzard_TalentUI",
	["PlayerTalentFrameTab3"] = "Blizzard_TalentUI",
	["PlayerTalentFrameTab4"] = "Blizzard_TalentUI",
	["PlayerTalentFrameTab5"] = "Blizzard_TalentUI",
	["PlayerTalentFrameInset"] = "Blizzard_TalentUI",
	["PlayerTalentFramePVPTalents"] = "Blizzard_TalentUI",
	["PlayerTalentFramePVPTalents.Talents"] = "Blizzard_TalentUI",
	["PlayerTalentFrameSpecialization"] = "Blizzard_TalentUI",
	["PlayerTalentFrameSpecializationSpellScrollFrameScrollChild"] = "Blizzard_TalentUI",
	["PlayerTalentFrameSpecializationSpecButton1"] = "Blizzard_TalentUI",
	["PlayerTalentFrameSpecializationSpecButton2"] = "Blizzard_TalentUI",
	["PlayerTalentFrameSpecializationSpecButton3"] = "Blizzard_TalentUI",
	["PlayerTalentFrameSpecializationSpecButton4"] = "Blizzard_TalentUI",
	["PlayerTalentFrameSpecializationLearnButton"] = "Blizzard_TalentUI",
	["PlayerTalentFrameTalents"] = "Blizzard_TalentUI"
}

-- Elements we won't skin
local whiteList = {
	["GroupFinderFrameGroupButton1Icon"] = true, 
	["GroupFinderFrameGroupButton2Icon"] = true, 
	["GroupFinderFrameGroupButton3Icon"] = true, 
	["GroupFinderFrameGroupButton4Icon"] = true, 
	["LFDQueueFrameFindGroupButtonText"] = true,
	["LFGListFrameText"] = true,
	["PVEFramePortrait"] = true,
	["RaidFinderFrameFindRaidButtonText"] = true,
	["RaidFinderFrameRoleBackground"] = true,
	["SpellBookPage1"] = true,
	["SpellBookPage2"] = true,


	["PlayerTalentFramePortrait"] = "Blizzard_TalentUI",
	["PlayerTalentFrameSpecializationLearnButtonText"] = "Blizzard_TalentUI",
	["PlayerTalentFrameSpecializationSpellScrollFrameScrollChild.gradient"] = "Blizzard_TalentUI",
	["PlayerTalentFrameSpecializationSpecButton1.selectedTex"] = "Blizzard_TalentUI",
	["PlayerTalentFrameSpecializationSpecButton2.selectedTex"] = "Blizzard_TalentUI",
	["PlayerTalentFrameSpecializationSpecButton3.selectedTex"] = "Blizzard_TalentUI",
	["PlayerTalentFrameSpecializationSpecButton4.selectedTex"] = "Blizzard_TalentUI",
	["PlayerTalentFrameSpecializationSpecButton1SpecIcon"] = "Blizzard_TalentUI",
	["PlayerTalentFrameSpecializationSpecButton2SpecIcon"] = "Blizzard_TalentUI",
	["PlayerTalentFrameSpecializationSpecButton3SpecIcon"] = "Blizzard_TalentUI",
	["PlayerTalentFrameSpecializationSpecButton4SpecIcon"] = "Blizzard_TalentUI",

	["ConquestFrame.RoleInset.Background"] = "Blizzard_PVPUI",
	["ConquestJoinButtonText"] = "Blizzard_PVPUI",
	["HonorFrame.RoleInset.Background"] = "Blizzard_PVPUI",
	["HonorFrameQueueButtonText"] = "Blizzard_PVPUI",
	["PVPQueueFrameCategoryButton1.Icon"] = "Blizzard_PVPUI",
	["PVPQueueFrameCategoryButton2.Icon"] = "Blizzard_PVPUI",
	["PVPQueueFrameCategoryButton3.Icon"] = "Blizzard_PVPUI",
	["PVPQueueFrameCategoryButton4.Icon"] = "Blizzard_PVPUI",
	["WarGameStartButtonText"] = "Blizzard_PVPUI"


} 

-- Elements we'll hide
local blackList = {
	["LFDQueueFrameFindGroupButton_LeftSeparator"] = true,
	["LFDQueueFrameFindGroupButton_RightSeparator"] = true,
	["LFGListFrame.CategorySelection.FindGroupButton.LeftSeparator"] = true,
	["LFGListFrame.CategorySelection.StartGroupButton.RightSeparator"] = true,
	["LFGListFrame.SearchPanel.BackButton.RightSeparator"] = true,
	["LFGListFrame.SearchPanel.SignUpButton.LeftSeparator"] = true,
	["RaidFinderFrameFindRaidButton_LeftSeparator"] = true,
	["RaidFinderFrameFindRaidButton_RightSeparator"] = true,

	["ConquestJoinButton_LeftSeparator"] = "Blizzard_PVPUI",
	["ConquestJoinButton_RightSeparator"] = "Blizzard_PVPUI",
	["HonorFrameQueueButton_LeftSeparator"] = "Blizzard_PVPUI",
	["HonorFrameQueueButton_RightSeparator"] = "Blizzard_PVPUI",
	["WarGameStartButton_LeftSeparator"] = "Blizzard_PVPUI",

	["PlayerTalentFrameSpecializationSpecButton1Glow"] = "Blizzard_TalentUI",
	["PlayerTalentFrameSpecializationSpecButton2Glow"] = "Blizzard_TalentUI",
	["PlayerTalentFrameSpecializationSpecButton3Glow"] = "Blizzard_TalentUI",
	["PlayerTalentFrameSpecializationSpecButton4Glow"] = "Blizzard_TalentUI"

}

-- Frames that'll have nameless child elements styled too.
-- Note that these frames aren't currently hooked to addon loading, 
-- so a full iteration of this table is run on every frame styling API call. 
-- Also, frames here will only be styled if they are listed in the elements table above. 
local iterateNameless = {
	["PlayerTalentFrameSpecialization"] = "Blizzard_TalentUI"
}

-- Character Frame
do
	-- The ItemsFrame was added in Cata when the character frame was upgraded to the big one
	local paperDoll = _G.PaperDollItemsFrame or _G.PaperDollFrame 
	for i = 1, select("#", paperDoll:GetChildren()) do

		local child = select(i, paperDoll:GetChildren())
		local childName = child:GetName()

		if (child:GetObjectType() == "Button") and (childName and childName:find("Slot")) then
			-- Nothing that belongs on the character frame, remnants of the templates used.
			if _G[childName .. "Stock"] then 
				blackList[childName .. "Stock"] = true
			end

			-- Ugly textures surrounding the buttons.
			if _G[childName .. "Frame"] then
				blackList[childName .. "Frame"] = true
			end

			-- Disable the annoying hovering border textures 
			-- of the main hand and secondary hand weapons.
			if childName:find("HandSlot") then
				child:DisableDrawLayer("BACKGROUND")
			end
		end
	end
end

-- Talent Frame
for row = 1,7 do
	elements["PlayerTalentFrameTalentsTalentRow"..row] = "Blizzard_TalentUI"
	for talent = 1,3 do
		elements["PlayerTalentFrameTalentsTalentRow"..row.."Talent"..talent] = "Blizzard_TalentUI"
		whiteList["PlayerTalentFrameTalentsTalentRow"..row.."Talent"..talent.."IconTexture"] = "Blizzard_TalentUI"
		--whiteList["PlayerTalentFrameTalentsTalentRow"..row.."Talent"..talent.."Name"] = "Blizzard_TalentUI"
		whiteList["PlayerTalentFrameTalentsTalentRow"..row.."Talent"..talent.."Slot"] = "Blizzard_TalentUI"
		whiteList["PlayerTalentFrameTalentsTalentRow"..row.."Talent"..talent.."Selection"] = "Blizzard_TalentUI"
	end
end

-- PvP Talent Frame
for row = 1,6 do
	elements["PlayerTalentFramePVPTalents.Talents.Tier"..row] = "Blizzard_TalentUI"
	for talent = 1,3 do
		elements["PlayerTalentFramePVPTalents.Talents.Tier"..row..".Talent"..talent] = "Blizzard_TalentUI"
		whiteList["PlayerTalentFramePVPTalents.Talents.Tier"..row..".Talent"..talent..".Cover"] = "Blizzard_TalentUI"
		whiteList["PlayerTalentFramePVPTalents.Talents.Tier"..row..".Talent"..talent..".Icon"] = "Blizzard_TalentUI"
		whiteList["PlayerTalentFramePVPTalents.Talents.Tier"..row..".Talent"..talent..".Slot"] = "Blizzard_TalentUI"
	end
end 

-- WarGames Frame
for i = 1,32 do -- overkill
	elements["WarGamesFrameScrollFrameButton"..i] = "Blizzard_PVPUI"
	elements["WarGamesFrameScrollFrameButton"..i..".Entry"] = "Blizzard_PVPUI"
	whiteList["WarGamesFrameScrollFrameButton"..i..".Entry.Icon"] = "Blizzard_PVPUI"
end

local styled = {}

-- Translate strings into keyed children
Module.GetObject = function(self, objectName)
	if string_find(objectName, ".") then
		local tree = { string_split(".", objectName) }
		local object = _G[tree[1]]
		if object then
			for i = 2, #tree do
				if object[tree[i]] then
					object = object[tree[i]]
				else
					return 
				end
			end
			return object
		end
	else
		return _G[objectName]
	end
end

Module.IsWhiteListed = function(self, object)
	if (not object) then
		return
	end
	for i in pairs(whiteList) do
		local white = self:GetObject(i)
		if (white and (white == object)) then
			return true
		end
	end
end

Module.StyleRegion = function(self, region)
	local objectType = region:GetObjectType()
	if (objectType == "Texture") then
		region:SetVertexColor(unpack(C.General.UIBackdrop))
	elseif (objectType == "FontString") then
		region:SetTextColor(unpack(C.General.Title))
	end
end

Module.StyleFrame = function(self, frame)
	for i = 1, select("#", frame:GetRegions()) do
		local region = select(i, frame:GetRegions())
		if region and (not self:IsWhiteListed(region)) then
			self:StyleRegion(region)
		end
	end

	-- Iterate nameless children
	for i in pairs(iterateNameless) do
		local object = self:GetObject(i)
		if (frame == object) then
			for i = 1, select("#", frame:GetChildren()) do
				local child = select(i, frame:GetChildren())
				if child and child.GetName and (not child:GetName()) then
					self:StyleFrame(child)
				end
			end
		end
	end

end

Module.StyleObject = function(self, object)
	if (object and (not styled[object])) then
		if (object:IsObjectType("Frame")) then
			self:StyleFrame(object)
		else
			self:StyleRegion(object)
		end
		styled[object] = true
	end
end

Module.OnEvent = function(self, event, ...)
	local addonName = ...
	for frameName, addon in pairs(elements) do
		if (addonName == addon) then
			local object = self:GetObject(frameName)
			if object then
				self:StyleObject(object)
			end

			-- Deleting the entry regardless of whether or not it was found, 
			-- as it could be a frame not found in the current version of the addon.
			elements[frameName] = nil

			self.unstyledAddonFrames = self.unstyledAddonFrames - 1
		end
	end

	local UIHider = self.UIHider 
	if UIHider then
		for frameName, addon in pairs(blackList) do
			if (addonName == addon) then
				local object = self:GetObject(frameName)
				if object then
					object:SetParent(UIHider)
				end
				blackList[frameName] = nil
				self.unhiddenAddonFrames = self.unhiddenAddonFrames - 1
			end
		end	
	end	

	if (self.unstyledAddonFrames == 0) and (self.unhiddenAddonFrames == 0) then
		self:UnregisterEvent("ADDON_LOADED", "OnEvent")
	end
end

Module.OnInit = function(self)
	local UIHider -- define this, but don't create it until we need it
	local unstyledAddonFrames = 0 -- Count how many addon elements we were unable to style
	local unhiddenAddonFrames = 0 -- Count how many elements we were unable to hide

	for frameName, addonName in pairs(elements) do
		local object = self:GetObject(frameName)
		if object then
			self:StyleObject(object)
			elements[frameName] = nil
		else
			if (addonName == true) then -- is the element from normal frameXML or an addon?
				blackList[frameName] = nil -- remove the entry since it's probably a frameXML reference from another expansion
			else
				unstyledAddonFrames = unstyledAddonFrames + 1
			end
		end
	end

	for frameName, addonName in pairs(blackList) do
		local object = self:GetObject(frameName)
		if object then
			if (not UIHider) then
				UIHider = CreateFrame("Frame") -- only create it if we need it
				UIHider:Hide()
			end
			object:SetParent(UIHider)
			blackList[frameName] = nil
		else
			if (addonName == true) then -- is the element from normal frameXML or an addon?
				blackList[frameName] = nil -- remove the entry since it's probably a frameXML reference from another expansion
			else
				unhiddenAddonFrames = unhiddenAddonFrames + 1
			end
		end
	end

	if (unhiddenAddonFrames > 0) then
		if (not UIHider) then
			UIHider = CreateFrame("Frame") 
			UIHider:Hide()
		end
		self.UIHider = UIHider
		self.unhiddenAddonFrames = unhiddenAddonFrames
	end

	if (unstyledAddonFrames > 0) then
		self.unstyledAddonFrames = unstyledAddonFrames
	end

	if (unstyledAddonFrames > 0) or (unhiddenAddonFrames > 0) then
		self:RegisterEvent("ADDON_LOADED", "OnEvent")
	end
end


