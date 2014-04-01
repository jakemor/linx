------------
-- Locals -- 
------------

local banner = {}
local banner_mt = { __index = banner }
local events = require("events")

-----------------
-- Constructor --
-----------------

function banner.new( input, inX, inY, size )
	local banner = {
		group = display.newGroup(),
	}
	local text = display.newText( input, inX, inY, system.native, size or 250);
	text:setFillColor( .5, .5, .5 );
---	text.blendMode = "multiply"	
	transition.to( text, { time=500, alpha=0, x=inX, y=inY-100, onComplete=banner.group:remove( ) } )
	
		
	

	return setmetatable( banner, banner_mt )
end

-------------
-- Methods -- 
-------------



return banner