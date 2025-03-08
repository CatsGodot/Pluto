
-- -------------------------------------------------------------------------
--##########################################################################

-- -------------------------------------------------------------------------

local gsPlutoVers = "1.0"
local gsDebugOn = false

--  ........................................................................

local gsColor_TealGreen = "|c004fb9af"
local gsColor_LightBlue = "|c009ABDDC"
local gsColor_Orange = "|c00FFA500"

local gsColor_Msg = gsColor_TealGreen
local gsColor_Error = gsColor_Orange
local gsColor_Debug = gsColor_LightBlue

-- -------------------------------------------------------------------------
-- -------------------------------------------------------------------------

local function PrintDebug( msg )
    if gsDebugOn then 
        print( gsColor_Debug .. "[DEBUG]  " .. msg .. "|r" )
    end
end

-- -------------------------------------------------------------------------

local function Print( msg )
  print( gsColor_Msg .. msg .. "|r" )
end

-- -------------------------------------------------------------------------

local function PrintErr( msg )
    print( gsColor_Error .. msg .. "|r" )
end

-- -------------------------------------------------------------------------
-- -------------------------------------------------------------------------

local plutoFrame = CreateFrame("Frame", nil, UIParent)
plutoFrame:SetPoint("CENTER")
plutoFrame:SetSize(175, 40)
plutoFrame:RegisterEvent("ADDON_LOADED")

-- -------------------------------------------------------------------------
-- -------------------------------------------------------------------------

function plutoFrame:OnEvent( wEvent, arg1 )
	PrintDebug( "plutoFrame:OnEvent() called" )
		
	if ( wEvent == "ADDON_LOADED" ) then
		PrintDebug( PlutoFrame_Point )
		PrintDebug( PlutoFrame_RelPoint )
		PrintDebug( PlutoFrame_xOffset )
		PrintDebug( PlutoFrame_yOffset )
		
		plutoFrame:SetPoint( PlutoFrame_Point, UIParent, PlutoFrame_RelPoint,
								PlutoFrame_xOffset, PlutoFrame_yOffset )
 	end
 end

-- -------------------------------------------------------------------------
-- -------------------------------------------------------------------------

plutoFrame:SetScript( "OnEvent", plutoFrame.OnEvent );

plutoFrame:EnableMouse(true)
plutoFrame:SetMovable(true)
plutoFrame:RegisterForDrag("LeftButton")
plutoFrame:SetScript("OnDragStart", function(self)
	self:StartMoving()
end)
plutoFrame:SetScript("OnDragStop", function(self)
	self:StopMovingOrSizing()
	
	PlutoFrame_Point, PlutoFrame_RelTo, PlutoFrame_RelPoint, 
		PlutoFrame_xOffset, PlutoFrame_yOffset = plutoFrame:GetPoint()
	
end)

plutoFrame:SetScript("OnShow", function()
        PlaySound(808)
end)

plutoFrame:SetScript("OnHide", function()
        PlaySound(808)

end)

local plutoThumbFrame = CreateFrame("Frame", nil, plutoFrame)
plutoThumbFrame:SetPoint("LEFT")
plutoThumbFrame:SetSize(32, 40)
plutoThumbFrame.tex = plutoThumbFrame:CreateTexture()
plutoThumbFrame.tex:SetAllPoints(plutoThumbFrame)
plutoThumbFrame.tex:SetTexture("interface/icons/inv_mushroom_11")


local plutoBtn1 = CreateFrame("Button", nil, plutoFrame, "UIPanelButtonTemplate")
plutoBtn1:SetPoint("LEFT", 38, 0)
plutoBtn1:SetSize(42, 40)
plutoBtn1:SetText("TA")
plutoBtn1:SetScript("OnClick", function(self, button, down)
	GoGoTank()
end)
plutoBtn1:RegisterForClicks("AnyUp")


local plutoBtn2 = CreateFrame("Button", nil, plutoFrame, "UIPanelButtonTemplate")
plutoBtn2:SetPoint("LEFT", 84, 0)
plutoBtn2:SetSize(42, 40)
plutoBtn2:SetText("Su")
plutoBtn2:SetScript("OnClick", function(self, button, down)
	Summon()
end)
plutoBtn2:RegisterForClicks("AnyUp")


local plutoBtn3 = CreateFrame("Button", nil, plutoFrame, "UIPanelButtonTemplate")
plutoBtn3:SetPoint("LEFT", 130, 0)
plutoBtn3:SetSize(42, 40)
plutoBtn3:SetText("In")
plutoBtn3:SetScript("OnClick", function(self, button, down)
	InitPlayer()
end)
plutoBtn2:RegisterForClicks("AnyUp")

plutoFrame:Hide()

local function SendPartyMessage( sMessage )
	PrintDebug( "Pluto::SendPartyMessage() called" )	
	SendChatMessage( sMessage, "PARTY", nil, nil ); 
end

-- -------------------------------------------------------------------------
-- -------------------------------------------------------------------------

function GoGoTank()
	PrintDebug( "Pluto::GoGoTank() called" )
	SendPartyMessage( "@tank attack" )
end

-- -------------------------------------------------------------------------

function Summon()
	PrintDebug( "Pluto::Summon() called" )
	SendPartyMessage( "summon" )
end

-- -------------------------------------------------------------------------

function InitPlayer()
	PrintDebug( "Pluto::InitPlayer() called" )
	SendPartyMessage( ".playerbot bot init=auto" )
end

-- -------------------------------------------------------------------------
-- -------------------------------------------------------------------------

SLASH_PLUTO1 = "/pluto"
SlashCmdList["PLUTO"] = function()
	if plutoFrame:IsShown() then
		plutoFrame:Hide()
	else
		plutoFrame:Show()
	end
end

-- -------------------------------------------------------------------------
-- -------------------------------------------------------------------------

Print( "Pluto " .. gsPlutoVers .. " loaded" )


--##########################################################################
-- -------------------------------------------------------------------------
