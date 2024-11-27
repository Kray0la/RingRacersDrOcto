-- Cvar to toggle the utility.
-- The script will also generally only be active in netgames and only in the game hosting the server
local cv_xbcStatTrackToggle = CV_RegisterVar({
	name = "xbcStatTrackToggle",
	defaultvalue = "On",
	flags = CV_NETVAR,
	description = "Determines whether to record various player statistics at the end of each race.",
	possiblevalue = CV_OnOff
})

local cv_xbcStatTrackNetgameOnly = CV_RegisterVar({
	name = "xbcStatTrackNetgameOnly",
	defaultvalue = "Yes",
	flags = CV_NETVAR,
	description = "Determines whether xbcStatTrack should record stats only in netgames.",
	possiblevalue = CV_YesNo
})

local cv_xbcStatTrackHostOnly = CV_RegisterVar({
	name = "xbcStatTrackHostOnly",
	defaultvalue = "Yes",
	flags = CV_NETVARs,
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
		if player.xbcStatsLogged ~= nil
			print(ok!)
		end
	end
end)

-- In the intermission screen, write results to file
addHook("IntermissionThinker", function( )
	if cv_xbcStatTrackToggle.value and (isserver or not cv_xbcStatTrackHostOnly.value) and (netgame or not cv_xbcStatTrackNetgameOnly.value)
		local file = io.openlocal("/client/xbcStatTrack.csv", "a")
		for player in players.iterate do
			if player.xbcStatsLoggednot player.xbcStatsLogged
				player.xbcStatsLogged = true
				-- Gather data
				local playerId = player.publickey
				local playerName = player.name
				local skinName = skins[player.skin].name
				local finalPos = tostring(player.position)
				local lapBonus = tostring(player.xbcLapBonus)
				local numlaps = tostring(numlaps)
				-- Put everything together to build a string
				local infoString = playerId..","..playerName..","..skinName..","..finalPos..","..lapBonus..","..numlaps.."\n"
				file:write(infoString)
			end
		end
		file:close()
	end
end)

