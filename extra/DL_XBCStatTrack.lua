-- Cvar to toggle the utility.
-- The script will also generally only be active in netgames and only in the game hosting the server
local cv_xbcStatTrackToggle = CV_RegisterVar({
	name = "xbcStatTrackToggle",
	defaultvalue = "On",
	flags = 0,
	description = "Determines whether to record various player statistics at the end of each race.",
	possiblevalue = CV_OnOff
})

local cv_xbcStatTrackNetgameOnly = CV_RegisterVar({
	name = "xbcStatTrackNetgameOnly",
	defaultvalue = "Yes",
	flags = 0,
	description = "Determines whether xbcStatTrack should record stats only in netgames.",
	possiblevalue = CV_YesNo
})

local cv_xbcStatTrackHostOnly = CV_RegisterVar({
	name = "xbcStatTrackHostOnly",
	defaultvalue = "Yes",
	flags = 0,
	description = "Determines whether xbcStatTrack should record stats only if you are the server host.",
	possiblevalue = CV_YesNo
})

-- Initialize variables for each player
addHook("PlayerSpawn", function(player)
	player.xbcStatsLogged = false
	player.xbcPrevLap = 0
	player.xbcLapBonus = 0
end)

-- Keep track of each player's lap bonus.
-- Must do it myself since the variable that the game uses is not exposed to us...
addHook("ThinkFrame", function()
	-- Whenever a player crosses the finish line...
	for player in players.iterate do
		if player.xbcPrevLap ~= nil and player.laps > player.xbcPrevLap
			player.xbcPrevLap = player.laps
			
			-- Check this wasn't just the start of the race
			if player.laps > 1
			
				-- +2 lap bonus for 1st place
				if player.position == 1
					player.xbcLapBonus = player.xbcLapBonus + 2
					
				-- +1 lap bonus for top half
				else
					-- Check player count
					local playerCount = 0
					for i in players.iterate do
						playerCount = playerCount + 1
					end
					
					-- Award lap bonus
					if (player.position * 2) <= playerCount
						player.xbcLapBonus = player.xbcLapBonus + 1
					end
				end
				print(player.xbcLapBonus)
			end
		end
	end
end)

-- In the intermission screen, write results to file
addHook("IntermissionThinker", function( )
	if cv_xbcStatTrackToggle.value and (isserver or not cv_xbcStatTrackHostOnly.value) and (netgame or not cv_xbcStatTrackNetgameOnly.value)
		-- Determine where to open the file
		-- Gotta open the right one because of permissions
		local file = nil
		if isserver
			file = io.openlocal("xbcStatTrack.csv", "a")
		else
			file = io.openlocal("client/xbcStatTrack.csv", "a")
		end
		
		-- Record data
		for player in players.iterate do
			-- Checking for explicitly false lets us handle spectators who never spawned to have this variable initialized (i.e. spectators)
			if player.xbcStatsLogged == false
				player.xbcStatsLogged = true
				
				local playerId = player.publickey or "NA"
				local playerName = player.name or "NA"
				local skinName = skins[player.skin].name or "NA"
				local finalPos = tostring(player.position) or "NA"
				local lapBonus = tostring(player.xbcLapBonus) or "NA"
				local numlaps = tostring(numlaps) or "NA"
				local mapname = mapheaderinfo[gamemap].lvlttl or "NA"
				
				local infoString = playerId..","..playerName..","..skinName..","..finalPos..","..lapBonus..","..numlaps..","..mapname.."\n"
				file:write(infoString)
			end
		end
		file:close()
	end
end)

