------------
-- Locals -- 
------------
local square = {}
local square_mt = { __index = square }
local events = require( "events" )


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

function square.new( x, y, w, h, row, col )
	local square = {
		image = display.newRect( _group,x, y, w, h ),
		row = row,
		col = col,
		color = 0; 
	}


--	local selected = false; 

	function square.image:touch(e)
		if (e.phase == "began") then
			
			-- set as picked up
			if (_pickedUp == nil and _board[square.row][square.col] ~= 0 and _board[square.row][square.col] ~= -1) then
				_pickedUp = square
				_gotLine = false;
				_added = false;
				_noShrink = false; 
				if (not _noShrink) then
					square:animateSize(60)
				end
			-- put back in same spot, if tap in same spot
			elseif (_pickedUp == square) then 
				square:animateSize(_squareSize, 0)
				_pickedUp = nil 
				_doneDeleting = true;
			
			elseif (_board[square.row][square.col] ~= 0 and _board[square.row][square.col] ~= -1) then 
				_pickedUp:animateSize(_squareSize, 0)
				_pickedUp = nil 
				_doneDeleting = true;
			-- place in new spot
			elseif (_pickedUp ~= nil and _board[square.row][square.col] == 0) then
				
				_placed = true;
				_doneDeleting = true;
				-- restore size of picked up
				_pickedUp:animateSize(_squareSize, 0)
				-- place piece down
				_board[square.row][square.col] = _pickedUp.color
				square:animatePutDown(_squareSize);
				-- set picked up as empty, bc just placed it down
				_board[_pickedUp.row][_pickedUp.col] = 0
				_board:updateColor();
				_board:removeLines(square.row, square.col)			
				_pickedUp = nil; 
			end
			 
		end
	end

	square.image:addEventListener( "touch", square.image )
	
	
	return setmetatable( square, square_mt )
	
end

-------------
-- Methods -- 
-------------


function square:active()
	-- body
end

function square:setRowCol(x, y)
	self.row = x
	self.col = y
end

function square:removeMe()
	self.image:removeSelf( )
	self.row = nil
	self.col = nil
	self.nextIndex = nil
	self.index = nil
end

function square:animateSize( size, time )
	local top = display.newGroup( )
	local square = self.image
	top:insert( square )
	-- options to change selected
	if (size ~= _squareSize) then
		square.alpha = .5
	-- otherwise
	else
		square.alpha = 1
	end
	local one = transition.to(square, {
		time = time or 60, 
		width = size,
		height = size,
		transition=easing.outQuad,
	})
	top = nil
	square = nil
	one = nil
end

function square:animateLine(  )
	local function two () 
		local one = transition.to(self.image, {
			time = 100, 
			width = _squareSize,
			height = _squareSize,
			transition=easing.inQuad,
		}) 
	end 

	local one = transition.to(self.image, {
		time = 125, 
		width = 50,
		height = 50,
		transition=easing.outQuad,
		onComplete = two
	})
	one = nil
	two = nil
end

function square:animatePutDown( size )
	local top = display.newGroup( )
	top:insert( self.image )
	local function two () 
		local one = transition.to(self.image, {
			time = 125, 
			width = size,
			height = size,
			transition=easing.inQuad,
		}) 
	end 

	local one = transition.to(self.image, {
		time = 125, 
		width = 100,
		height = 100,
	--	rotation = 45,
		transition=easing.outQuad,
		onComplete = two
	})

	top = nil
	one = nil
	two = nil
end

function square:setColor( color )
	toColor(self.image, color)
	self.index = color
end

function square:nextColor( c )
	self.nextIndex = c
end

function square:removeSquare( )
	local one = transition.to(self.image, {
	time = 250,
	width = 50,
	height = 50, 
	alpha = 0,
	})
end

function square:reviveSquare( )

	local one = transition.to(self.image, {
	time = 250,
	width = _squareSize,
	height = _squareSize, 
	alpha = 1, 
	})
end

return square