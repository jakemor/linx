------------
-- Locals -- 
------------

local Queue = {}
local Queue_mt = { __index = Queue }

-----------------
-- Constructor --
-----------------

function Queue.new(  )
	local Queue = {}

	return setmetatable( Queue, Queue_mt )
end

-------------
-- Methods -- 
-------------

function Queue:print()
	local string = "["
	for i=1, #self do
		string = string .. self[i]
		if (i ~= #self) then
			string = string .. ", "
		end
	end
	string = string .. "]"
	print( string )
end

function Queue:add( a )
	self[#self + 1] = a
	return a
end

function Queue:get( a )
	return self[a]
end

function Queue:remove()
	return table.remove( self, 1 )
end

function Queue:length(  )
	return #self
end

function Queue:clear( )
	for i=1, #self do
		self:pop()
	end
end

return Queue