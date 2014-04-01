------------
-- Locals -- 
------------

local stack = {}
local stack_mt = { __index = stack }

-----------------
-- Constructor --
-----------------

function stack.new(  )
	local stack = {}

	return setmetatable( stack, stack_mt )
end

-------------
-- Methods -- 
-------------

function stack:print()
	local string = "["
	for i=1, #self do
		string = string .. tostring(self[i])
		if (i ~= #self) then
			string = string .. ", "
		end
	end
	string = string .. "]"
	print( string )
end

function stack:push( a )
	self[#self + 1] = a
	return a
end

function stack:clear( )
	while (#self > 0) do 
		self:pop(); 
	end
end

function stack:pop()
	return table.remove( self )
end

function stack:length(  )
	return #self
end

function stack:clear( )
	for i=1, #self do
		self:pop()
	end
end

return stack