------------
-- Locals -- 
------------

local Node = {}
local Node_mt = { __index = Node }


-----------------
-- Constructor --
-----------------
function Node.new( row, col, val, parent )
	local Node = {
		row = row or 0,
		col = col or 0, 
		val = val or 0,
	}

	

	return setmetatable( Node, Node_mt )
end

-------------
-- Methods -- 
-------------

return Node