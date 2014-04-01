------------
-- Locals -- 
------------
local events = require( "events" )
local nextSquare = {}
local nextSquare_mt = { __index = nextSquare }
local W = display.contentWidth
local H = display.contentHeight

local function toColor( box, id )
	if (id == 0) then 
		box:setFillColor( 200/219, 200/219, 200/219 )
	elseif (id == 1) then
		box:setFillColor( 112/219, 53/219, 219/219 ) 
	elseif (id == 2) then 
		box:setFillColor( 231/219, 76/219, 60/219 )
	elseif (id == 3) then 
		box:setFillColor( 230/219, 126/219, 43/219 )
	elseif (id == 4) then 
		box:setFillColor( 75/219, 180/219, 121/219 )
	elseif (id == 5) then 
		box:setFillColor( 53/219, 151/219, 219/219 )
	elseif (id == 6) then 
		box:setFillColor( 64/219, 81/219, 100/219 )
	elseif (id == -1) then 
		box:setFillColor( 219/219, 219/219, 219/219 )
	end
end

-----------------
-- Constructor --
-----------------

function nextSquare.new( c,x,y,w,h )
	local nextSquare = {
		image = display.newRect( x, y, w, h ),
		col = c, 
	}
	nextSquare.image.alpha = 1
	toColor(nextSquare.image, 0)

	return setmetatable( nextSquare, nextSquare_mt )
end

-------------
-- Methods -- 
-------------
function nextSquare:toColor( input )
	toColor(self.image, input or _colors[self.col])
end


return nextSquare