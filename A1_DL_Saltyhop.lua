local FILENAME = "client/saltyhop.cfg"

local file = io.openlocal(FILENAME, "a")  --create the file if it doesn't exist, but don't alter it. we use append mode for this
file:close()

//saltyhop command by SMS Alfredo
COM_AddCommand("saltyhop", function(player, arg)
	if not (player.mo and player.mo.valid) then CONS_Printf(player, "This can only be used in a level!") return end
	if arg
		if arg == "0" or arg == "off" or arg == "false"
			player.saltyhop = false
			if io and player == consoleplayer
				local file = io.openlocal(FILENAME, "w+")
				file:write(0)
				file:close()
			end
		elseif arg == "1" or arg == "on" or arg == "default" or arg == "true"
			player.saltyhop = true
			--CONS_Printf(player, "Saltyhop enabled")
			if io and player == consoleplayer
				local file = io.openlocal(FILENAME, "w+")
				file:write(1)
				file:close()
			end
		else
			CONS_Printf(player, "saltyhop [on/off] - Toggles whether or not you jump.")
			CONS_Printf(player, "Note that this jump is 100% visual and does not affect gameplay in any way. No jumping over walls or offroad here.")
		end
	else
		CONS_Printf(player, "saltyhop [on/off] - Toggles whether or not you jump.")
		CONS_Printf(player, "Note that this jump is 100% visual and does not affect gameplay in any way. No jumping over walls or offroad here.")
	end
end, 0)

//I/O junk for the command above
addHook("PlayerSpawn", function(player)
	if io and player.saltyhop == nil and player == consoleplayer
	--CONS_Printf(player, "starting fileread")
		local file = io.openlocal(FILENAME)
		local num = file:read("*n")
		if num != nil and num == 0 or num == 1
			COM_BufInsertText(consoleplayer, "saltyhop ".. num)
		else
			COM_BufInsertText(consoleplayer, "saltyhop 0")
		end
		--print(num)
		file:close()
	end
end)
/*
No Mobj Version of Saltyhop for Ring Racers
by JosephLol

Thanks Benji! (you're welcome)

This was Reused from MK64 Cast by SMS Alfredo
*/
local function SaltyThink(player)
	if not (player.mo and player.mo.valid) then return end
	if (player.spectator) then return end
	if not (player.saltyhop) then return end
	//Jump Detection
	if not (player.cmd.buttons & BT_DRIFT)
		player.saltyhopdrifttapready = true;
		player.saltyhopdrifttapping = false;
	elseif player.saltyhopdrifttapready then
		player.saltyhopdrifttapping = true;
		player.saltyhopdrifttapready = false;
	else
		player.saltyhopdrifttapping = false;
	end
	//Fake jumping
	//It's entirely visual and you're technically still on the ground
	local mo = player.mo;
	if player.saltyhopzoffset == nil
		player.saltyhopjump = false;
		player.saltyhopzoffset = 0;
		player.saltyhopmomz = 0;
	elseif player.saltyhopjump
		if mo.eflags&MFE_JUSTHITFLOOR
			player.saltyhopzoffset = 0;
		elseif P_IsObjectOnGround(mo)
			player.saltyhopzoffset = $ + player.saltyhopmomz;
			player.saltyhopmomz = $ - (FRACUNIT*3/2);
		else
			player.saltyhopzoffset = $*49/50;
			player.saltyhopmomz = 0;
		end
		if player.saltyhopzoffset <= 0
			if not (mo.eflags&MFE_JUSTHITFLOOR)
			and P_IsObjectOnGround(mo)
				mo.spritexscale = FRACUNIT*11/10;
				mo.spriteyscale = FRACUNIT*9/10;
				S_StartSound(mo, sfx_s268);
			end
			player.saltyhopjump = false;
			player.saltyhopzoffset = 0;
			player.saltyhopmomz = 0;
		end
		mo.spriteyoffset = player.saltyhopzoffset*P_MobjFlip(mo);
		if S_SoundPlaying(mo, sfx_screec)
			S_StopSoundByID(mo, sfx_screec);
		end
		if S_SoundPlaying(mo, sfx_drift)
			S_StopSoundByID(mo, sfx_drift);
		end
	elseif player.saltyhopdrifttapping and P_IsObjectOnGround(mo)
	and not player.spinouttimer
		player.saltyhopjump = true;
		player.saltyhopzoffset = 0;
		player.saltyhopmomz = FRACUNIT*6;
		mo.spritexscale = FRACUNIT*9/10;
		mo.spriteyscale = FRACUNIT*11/10;
		S_StartSound(mo, sfx_s25a);
	end
end
addHook("PlayerThink", SaltyThink);