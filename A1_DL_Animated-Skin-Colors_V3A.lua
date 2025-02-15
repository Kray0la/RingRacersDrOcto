--[[
Entire script by ChrisFurry.
Welcome to version 3A, I messed up my mod code
I've learned a lot about lua since the last update so things are going to be different, sorry.
]]--
if(rawget(_G,"animatedskincolor_api2"))then 
	-- Sorry for my dumb print that could confuse people who add multiple mods that use this script
	return 
end

-- Define the namespace
local asc = {
	tics = 0,
	colors = {},
}

---@param color_id SKIN_COLOR
---@param tic_delay tic_t The delay between ramp changes. (Default 4)
---@return namespace, for chaining
function asc.setDelay(color_id,tic_delay)
	asc.makeAnimated(color_id,tic_delay)
	return asc
end

---@param color_id SKIN_COLOR
---@return Animated Color table.
function asc.get(color_id) return asc.colors[color_id] end

---@param color_id SKIN_COLOR
---@return Animated Color's current ramp.
function asc.getRamp(color_id) 
	if(asc.colors[color_id] and #asc.colors[color_id].ramp)then
		local r,t = asc.colors[color_id].ramp,asc.colors[color_id].delay
		if(asc.tics <= 0)then return r[1] end
		return r[(asc.tics / t % #r) + 1]
	end
	return nil
end

---@param color_id SKIN_COLOR The skin color you want to become animated.
---@param tic_delay tic_t The delay between ramp changes. (Default 4)
---@return namespace, for chaining
function asc.makeAnimated(color_id,tic_delay)
	if(asc.colors[color_id])then
		asc.colors[color_id].delay = tic_delay
		return asc
	end
	tic_delay = tic_delay or 4
	asc.colors[color_id] = {
		ramp = {},
		delay = tic_delay
	}
	return asc
end

---@param color_id SKIN_COLOR The skin color you want to add a ramp to.
---@param ramp table The color ramp you want to add to the animation.
---@param ... table Color ramps.
---@return namespace, for chaining
function asc.addRamp(color_id,ramp,...)
	if(type(ramp) ~= "table")then return asc end
	if(asc.colors[color_id] == nil)then asc.makeAnimated(color_id) end
	table.insert(asc.colors[color_id].ramp,ramp)
	if(#asc.colors[color_id].ramp == 1)then skincolors[color_id].ramp = ramp end
	return asc.addRamp(color_id,...)
end

-- Animates skin colors.
function asc.think()
	asc.tics = $+1
	for sc,data in pairs(asc.colors) do
		if(asc.colors[sc])then
			skincolors[sc].ramp = asc.getRamp(sc) or skincolors[sc].ramp
		end
	end
end
-- Resets the timer, used so when you go into a replay or smth the color will appear exact as it was.
function asc.resetTimer() asc.tics = 0 end

-- Hooks
addHook("PostThinkFrame",asc.think)
addHook("IntermissionThinker",asc.think)
addHook("VoteThinker",asc.think)
addHook("MapChange",asc.resetTimer)

-- Make the namespace is global so other scripts can use it.

rawset(_G,"animatedSkinColor",asc)
rawset(_G,"animatedskincolor_api2",true)

-- Add an example animated color
-- Freeslot & Define
freeslot("SKINCOLOR_RAINBOW")
skincolors[SKINCOLOR_RAINBOW] = {
name = "Rainbow",
ramp = {32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47},
invcolor = SKINCOLOR_BLACK,
invshade = 0,
chatcolor = V_REDMAP,
accessible = true}
-- Make animated & Add Ramps
animatedSkinColor.makeAnimated(SKINCOLOR_RAINBOW,5).addRamp(SKINCOLOR_RAINBOW,
-- red
{32	,33	,34	,35	,36	,37	,38	,39	,40	,41	,42	,43	,44	,45	,46	,47	},
{210,32	,33	,34	,34	,34	,37	,38	,39	,40	,41	,63	,43	,44	,45	,46	},
{219,210,32	,33	,34	,34	,34	,59	,205,205,61	,61	,63	,63	,63	,45	},
{217,218,210,32	,54	,55	,56	,58	,58	,58	,59	,60	,61	,63	,63	,63	},
-- orange
{48	,49	,50	,51	,52	,53	,54	,55	,56	,57	,58	,59	,60	,61	,62	,63	},
{208,84	,49	,51	,52	,53	,55	,57	,57	,58	,58	,59	,60	,61	,62	,63	},
{208,84	,84	,64	,74	,53	,54	,55	,56	,57	,58	,59	,60	,61	,62	,63	},
{81	,82	,83	,72	,74	,65	,75	,222,225,225,68	,69	,69	,61	,62	,63	},
-- yellow
{81	,82	,83	,72	,73	,74	,75	,66	,67	,67	,68	,69	,69	,61	,62	,63	},
{88	,88	,188,188,188,189,190,76	,77	,77	,78	,79	,233,70	,70	,63	},
{88	,96	,96	,97	,97	,99	,100,102,103,191,105,94	,251,236,237,239},
{96	,112,112,98	,98	,100,101,103,103,105,105,107,108,95	,25	,26	},
-- green
{96	,112,112,113,113,114,114,115,115,116,116,117,118,118,119,119},
{96	,112,112,113,113,114,114,115,115,116,116,117,118,118,119,119},
{120,96	,122,122,122,123,123,124,115,126,126,117,127,118,110,110},
{120,129,121,121,122,123,123,124,125,143,143,117,127,138,110,110},
-- aqua
{120,120,121,121,122,123,123,124,125,143,143,127,127,138,139,139},
{120,120,121,121,122,123,123,124,125,143,143,127,127,138,139,139},
{128,129,121,130,131,133,133,125,142,143,143,118,118,138,139,139},
{128,129,130,131,131,132,141,135,142,137,137,138,138,110,139,139},
-- cyan
{128,129,130,131,132,133,134,135,136,137,137,138,138,139,139,139},
{128,129,130,132,133,134,135,136,137,138,138,138,138,139,139,139},
{128,5	,140,133,134,135,136,137,150,138,138,139,139,158,159,253},
{2	,5	,146,170,147,148,149,150,151,154,155,156,157,158,158,159},
-- blue
{144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159},
{4	,145,161,147,148,149,150,151,152,153,154,155,156,157,158,159},
{176,160,147,147,194,196,164,166,167,168,168,168,168,169,169,159},
{145,161,162,162,163,164,164,166,166,167,167,168,168,169,169,169},
-- purple
{160,161,162,162,163,164,164,165,165,166,166,167,167,168,168,169},
{160,161,192,162,163,164,164,165,165,165,165,167,167,168,168,169},
{200,177,192,192,163,183,183,184,184,185,185,167,167,168,168,169},
{200,177,178,179,180,182,183,184,184,184,184,185,185,186,187,187},
-- magenta
{176,177,178,179,180,181,182,183,183,184,184,185,185,186,187,187},
{176,177,178,179,180,181,182,183,183,184,184,185,185,186,187,187},
{200,177,178,178,179,204,204,183,206,206,184,207,185,186,187,187},
{200,200,201,178,179,203,203,205,206,206,206,206,197,198,199,199},
-- pink?
{200,200,201,201,202,203,203,204,205,205,206,206,197,198,199,199},
{209,177,32	,202,33	,204,204,205,206,206,206,207,197,198,199,199},
{201,210,202,33	,34	,204,205,205,206,206,207,207,63	,199,46	,47	},
{210,32	,33	,34	,35	,37	,37	,38	,39	,40	,41	,42	,44	,71	,46	,47	})