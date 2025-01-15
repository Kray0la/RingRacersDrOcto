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
					for player in players.iterate do
						if not player.spectator
							playerCount = playerCount + 1
						end
					end
					
					-- Award lap bonus
					if (player.position * 2) - 1 <= playerCount
						player.xbcLapBonus = player.xbcLapBonus + 1
					end
				end
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
		-- We want to write the map name only once
		local mapNameLogged = false
		for player in players.iterate do
			-- Collect all needed info.
			-- Checking for explicitly false lets us handle players who never spawned to have this variable initialized (i.e. spectators)
			if player.xbcStatsLogged == false and not player.spectator
				player.xbcStatsLogged = true
				
				local playerId = player.publickey or "NA"						-- Unique player ID attached to each save file. Helps track players even if they change names.
				local playerName = player.name or "NA"							-- Player name.
				local skinName = skins[player.skin].name or "NA"				-- Chosen character.
				local colorName = R_GetNameByColor(player.skincolor) or "NA"	-- Chosen color.
				local finalPos = tostring(player.position) or "NA"				-- Final placement.
				local lapBonus = tostring(player.xbcLapBonus) or "NA"			-- Lap bonus.
				local numlaps = tostring(numlaps) or "NA"						-- Number of laps, used to calculate total possible lap bonus.
				local mapname = G_BuildMapTitle(gamemap) or "NA" 				-- Map name.
				local isEncore = tostring(encoremode) or "NA"					-- Encore mode.
				
				-- Compile all collected info into one line and write to file
				if mapNameLogged
					local infoString = playerId..","..playerName..","..skinName..","..colorName..","..finalPos..","..lapBonus..","..numlaps.."\n"
					file:write(infoString)
				else
					mapNameLogged = true
					local infoString = playerId..","..playerName..","..skinName..","..colorName..","..finalPos..","..lapBonus..","..numlaps..","..mapname..","..isEncore.."\n"
					file:write(infoString)
				end
			end
		end
		file:close()
	end
end)

