------------
-- Locals -- 
------------

local DataSaver = {}
local DataSaver_mt = { __index = DataSaver }
local json = require( "json" )

-----------------
-- Constructor --
-----------------

function DataSaver.new( key, input )
	local DataSaver = {}
	
	-- create path for data saving
	local path; 

	-- store in proj dir if in dev mode
	if (input == "dev") then
		path = key .. ".txt";
	else
		path = system.pathForFile( key .. ".txt", system.DocumentsDirectory );
	end
	
	-- load file for json parse
	local file = io.open( path, "r" );
	
	-- create file if none exists
	if (not file) then
		file = io.open( path, "w+" );
		print( "created " .. key .. ".txt!" );
		file:write( "[]" )
	else
		-- if exists, load json data to self data
		DataSaver = json.decode( file:read( "*a" ) )
	end

	-- close file
	io.close( file )
	
	-- save path
	DataSaver.path = path;
	
	-- nil out
	file = nil
	path = nil; 
	
	return setmetatable( DataSaver, DataSaver_mt );
end


-------------
-- Methods -- 
-------------

-- SAVE:
function DataSaver:save( )
	local file = io.open( self.path, "w+" );
	file:write( json.encode( self ) );
	print( "saved!" );
	io.close( file );
end

-- CLEAR:
function DataSaver:clear()
	for k,v in pairs(self) do
		if (k ~= "path") then
			self[k] = nil;
		end
	end
end

-- PRINT:
function DataSaver:print( )
	for k,v in pairs(self) do
		print( k , v );
	end
end

return DataSaver





