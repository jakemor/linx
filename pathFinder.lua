------------
-- Locals -- 
------------

local pathFinder = {}
local pathFinder_mt = { __index = pathFinder }
local Node = require("Node")
local Stack = require("stack")

-----------------
-- Constructor --
-----------------

function pathFinder.new( map )
	local pathFinder = {
		map = map,
		cost = 0,
		stack = Stack.new() 
	}
	return setmetatable( pathFinder, pathFinder_mt )
end

-------------
-- Methods -- 
-------------

function pathFinder:newMap( input )
	self.map = nil; 
	self.map = input; 
end

function pathFinder:print(  )
	local line = ""
	for i=1,#self.map do
		line = ""
		for j=1,#self.map[i] do
			line = line .. " " .. self.map[i][j]
		end
		print( line );
	end
end

function pathFinder:checkNorth( node )
	self.cost = self.cost + 1; 

	self.map[node.row][node.col] = 'X'

	if (node.row == 1) then
		return false; 
	end

	if (self.map[node.row - 1][node.col] == 'X') then
		return false; 
	end
	
	if (self.map[node.row - 1][node.col] == node.val) then
		return true; 
	end
end

function pathFinder:checkSouth( node )
	self.cost = self.cost + 1; 

	self.map[node.row][node.col] = 'X'

	if (node.row == #self.map) then
		return false; 
	end
	
	if (self.map[node.row + 1][node.col] == 'X') then
		return false; 
	end
	
	if (self.map[node.row + 1][node.col] == node.val) then
		return true; 
	end
end

function pathFinder:checkEast( node )
	self.cost = self.cost + 1; 

	self.map[node.row][node.col] = 'X'

	if (node.col == #self.map[1]) then
		return false; 
	end

	if (self.map[node.row][node.col + 1] == 'X') then
		return false; 
	end
	
	if (self.map[node.row][node.col + 1] == node.val) then
		return true; 
	end
end

function pathFinder:checkWest( node )
	 
	if (node.col == 1) then
		return false; 
	end

	if (self.map[node.row][node.col - 1] == 'X') then
		return false; 
	end
	
	if (self.map[node.row][node.col - 1] == node.val) then
		return true; 
	end
end

function pathFinder:toStack()
	for i=1,#self.map do
		for j=1,#self.map[1] do
			if (self.map[i][j] == 'X') then
				self.stack:push({i,j})
			end
		end
	end
end

function pathFinder:checkMoves(  )
	for i=1,7 do
		for j=1,7 do
			self:find(i,j)
			print( "..." )
			self:print()
			print( "..." )
			if (#self.stack > 4) then
				return true; 
			else
				self.stack:clear()
			end
		end
	end
	return false; 
end

function pathFinder:find(row, col)
	local node = Node.new(row, col)
	self:mark(node);
	self:toStack();
	node = nil
end

function pathFinder:mark( node, block )
	self.cost = self.cost + 1; 
	local firstNode = node; 
	local nextNode;

	node.val = self.map[node.row][node.col]
	
	if (block ~= "N" and block ~= "S") then 
		while (self:checkNorth(node)) do
			nextNode = Node.new(node.row - 1,node.col,node.val)
			node = nextNode;
			nextNode = nil
			self:mark(node, "N");
		end
	end 

	node = firstNode; 

	if (block ~= "S" and block ~= "N") then 
		while (self:checkSouth(node)) do
			nextNode = Node.new(node.row + 1,node.col,node.val)
			node = nextNode;
			nextNode = nil
			self:mark(node, "S");
		end
	end 

	node = firstNode;

	if (block ~= "W" and block ~= "E") then 
		while (self:checkWest(node)) do
			nextNode = Node.new(node.row,node.col - 1,node.val)
			node = nextNode;
			nextNode = nil
			self:mark(node, "W");
		end
	end 

	node = firstNode;

	if (block ~= "E" and block ~= "W") then 
		while (self:checkEast(node)) do
			nextNode = Node.new(node.row,node.col + 1,node.val)
			node = nextNode;
			nextNode = nil
			self:mark(node, "E");
		end
	end

	firstNode = nil; 
	node = nil;
	nextNode = nil; 

end

return pathFinder

















































