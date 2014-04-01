------------
-- Locals -- 
------------
local nextSquare = require( "nextSquare" )
local nextBlocks = {}
local nextBlocks_mt = { __index = nextBlocks }
local W = display.contentWidth
local H = display.contentHeight
-----------------
-- Constructor --
-----------------

function nextBlocks.new( yVal )
	local nextBlocks = {}

	local nextBlocks = {}
	
	local x = W/2
	local y = yVal+2
	local spacing = W/5
	local size = 15
	for j=1, 5 do
		nextBlocks[j] = nextSquare.new(j, x - (2*spacing) + spacing*(j-1), y, W/5, size)
	end
	return setmetatable( nextBlocks, nextBlocks_mt )
end

-------------
-- Methods -- 
-------------

function nextBlocks:toColor( )
	for i=1,5 do
		self[i]:toColor()
	end
	
end

function nextBlocks:remove(  )
	for i=1,5 do
		self[i]:remove()
	end
end

return nextBlocks