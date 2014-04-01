local Queue = require("Queue")
_colors = Queue.new()

_numberColors = 2
_boardW = 7
_boardH = 7
_waveNumber = 0
_linesDeleted = 0

_doneDeleting = true; 
_group = nil; 
_combo = 1
_noShrink = false; 
_pickedUp = nil;
_board = nil; 
_nextBlocks = nil
--_nextBlocksTop = nil
_placed = true; 
_gotLine = false; 
_squareSize = 88; 
_score = 0; 
_added = false;
_gameOver = false; 