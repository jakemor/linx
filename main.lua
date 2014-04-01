-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local W, H = display.contentWidth, display.contentHeight
local storyboard = require "storyboard"
local bg = display.newRect( W/2, H/2, W, H )
bg:setFillColor( 219/219, 219/219, 219/219 )
-- load scenetemplate.lua
storyboard.gotoScene( "game" )

-- Add any objects that should appear on all scenes below (e.g. tab bar, hud, etc.):