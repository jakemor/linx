------------
-- Locals -- 
------------

local ScoreKeeper = {}
local ScoreKeeper_mt = { __index = ScoreKeeper }
local DataSaver = require("DataSaver")

-----------------
-- Constructor --
-----------------

function ScoreKeeper.new( key, input )
	local ScoreKeeper = {
		safe = DataSaver.new(key, input);
		key = key
	}

	-- score 
	if (not ScoreKeeper.safe.score) then
		ScoreKeeper.safe.score = 0; 
	end

	-- high score  
	if (not ScoreKeeper.safe.HS) then
		ScoreKeeper.safe.HS = 0; 
	end

	-- last high score
	if (not ScoreKeeper.safe.lastHS) then
		ScoreKeeper.safe.lastHS = 0; 
	end

	-- true if beat high score
	if (not ScoreKeeper.safe.beatHS) then
		ScoreKeeper.safe.beatHS = false; 
	end
	 
	ScoreKeeper.safe:save();
	
	return setmetatable( ScoreKeeper, ScoreKeeper_mt )
end

-------------
-- Methods -- 
-------------

-- UPDATE: (auto takes care of high score, and others)
function ScoreKeeper:update( newScore )
	-- set beatHS to false
	self.safe.beatHS = false;
	-- set current score
	self.safe.score = newScore;
	-- if player beat high score
	if (newScore > self.safe.HS) then
		-- save high score as last high score
		self.safe.lastHS = self.safe.HS
		-- save high score as current score
		self.safe.HS = newScore;
		-- set beatHS to true, if 
		self.safe.beatHS = true; 
	end

	-- save changes
	self.safe:save()
end

-- GET HIGH SCORE:
function ScoreKeeper:getHighScore( )
	return self.safe.HS
end

-- GET LAST HIGH SCORE:
function ScoreKeeper:getLastHighScore( )
	return self.safe.lastHS
end

-- GET HIGH SCORE:
function ScoreKeeper:getScore( )
	return self.safe.score
end

-- CHECK FOR NEW HS:
function ScoreKeeper:newHighScore( )
	return self.safe.beatHS
end

-- PRINT:
function ScoreKeeper:print( )
	print( "            Key:", self.key )
	print( "          Score:",self.safe.score )
	print( "     High Score:",self.safe.HS )
	print( "Last High Score:",self.safe.lastHS )
	print( "New High Score?:",self.safe.beatHS )
end


return ScoreKeeper