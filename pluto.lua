
-- -------------------------------------------------------------------------
--##########################################################################

-- -------------------------------------------------------------------------

local gsPlutoVers = "1.1"
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

local plutoFrame = CreateFrame( "Frame", nil, UIParent )

-- -------------------------------------------------------------------------
-- -------------------------------------------------------------------------

local function CreateThumb()
	local thumbFrame = CreateFrame("Frame", nil, plutoFrame)
	thumbFrame:SetPoint("LEFT")
	thumbFrame:SetSize(32, 40)
	thumbFrame.tex = thumbFrame:CreateTexture()
	thumbFrame.tex:SetAllPoints(thumbFrame)
	thumbFrame.tex:SetTexture("interface/icons/inv_mushroom_11")
end

-- .........................................................................

local function CreateButton( sTitle, xOffset, wHandler )
	local btn = CreateFrame("Button", nil, plutoFrame, "UIPanelButtonTemplate")
	btn:SetPoint( "LEFT", xOffset, 0 )
	btn:SetSize( 42, 40 )
	btn:SetText( sTitle )
	
	btn:SetScript("OnClick", function(self, button, down)
		wHandler()
		end)
		
	btn:RegisterForClicks("AnyUp")
end

-- .........................................................................

local function BuildFrame()
	plutoFrame:SetSize( 250, 40 )
	plutoFrame:RegisterEvent( "ADDON_LOADED" )


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

	CreateThumb()
	CreateButton( "TA", 38, GoGoTank )
	CreateButton( "Su", 84, Summon )
	CreateButton( "Init", 130, InitPlayer )
	CreateButton( "Stay", 176, RedLight )
	CreateButton( "Flw", 222, GreenLight )

	plutoFrame:Hide()

end

-- -------------------------------------------------------------------------

function plutoFrame:OnEvent( wEvent, arg1 )
	PrintDebug( "plutoFrame:OnEvent() called" )
		
	if ( nil == Pluto_FirstTime ) then
		Pluto_FirstTime = false
		plutoFrame:SetPoint("CENTER")
		
		PlutoFrame_Point, PlutoFrame_RelTo, PlutoFrame_RelPoint, 
			PlutoFrame_xOffset, PlutoFrame_yOffset = plutoFrame:GetPoint()
			
		plutoFrame:Show()
		PlutoFrame_Show = true
		
		return
	end 
	
	if ( (wEvent == "ADDON_LOADED") and
			(nil ~= PlutoFrame_Point) and 
			(nil ~= PlutoFrame_RelPoint) and
			(nil ~= PlutoFrame_xOffset) and
			(nil ~= PlutoFrame_yOffset) and
			(nil ~= PlutoFrame_Show) ) then
		
		plutoFrame:SetPoint( PlutoFrame_Point, "UIParent",
								PlutoFrame_xOffset, PlutoFrame_yOffset )
		
								
		if ( PlutoFrame_Show ) then 
			plutoFrame:Show()
		else
			plutoFrame:Hide()
		end
 	end
 end

-- -------------------------------------------------------------------------
-- -------------------------------------------------------------------------


local function SendPartyMessage( sMessage )
	PrintDebug( "Pluto::SendPartyMessage() called" )	
	SendChatMessage( sMessage, "PARTY", nil, nil ); 
end

-- .........................................................................

function GoGoTank()
	PrintDebug( "Pluto::GoGoTank() called" )
	SendPartyMessage( "@tank attack" )
end

-- .........................................................................

function Summon()
	PrintDebug( "Pluto::Summon() called" )
	SendPartyMessage( "summon" )
end

-- .........................................................................

function InitPlayer()
	PrintDebug( "Pluto::InitPlayer() called" )
	SendPartyMessage( ".playerbot bot init=auto" )
end

-- .........................................................................

function RedLight()
	PrintDebug( "Pluto::RedLight() called" )
	SendPartyMessage( "stay" )
end

-- .........................................................................

function GreenLight()
	PrintDebug( "Pluto::GreenLight() called" )
	SendPartyMessage( "follow" )
end

-- -------------------------------------------------------------------------
-- -------------------------------------------------------------------------

BuildFrame()

SLASH_PLUTO1 = "/pluto"
SlashCmdList["PLUTO"] = function()
	if plutoFrame:IsShown() then
		plutoFrame:Hide()
		PlutoFrame_Show = false
	else
		plutoFrame:Show()
		PlutoFrame_Show = true
	end
end

-- -------------------------------------------------------------------------
-- -------------------------------------------------------------------------

Print( "Pluto " .. gsPlutoVers .. " loaded" )


--##########################################################################
-- -------------------------------------------------------------------------
