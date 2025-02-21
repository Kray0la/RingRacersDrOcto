-- taken from Hostmod by Tyron
-- https://mb.srb2.org/threads/hostmod.26649/

local hostmod_encorechance = CV_RegisterVar({
	name = "hm_encore",
	defaultvalue = "-1",
	flags = CV_NETVAR,
	possiblevalue = {MIN = -1, MAX = 100}
})

addHook("ThinkFrame", function()
	server.hostmod_doencoreswitch = true
end)

addHook("IntermissionThinker", function()
	if hostmod_encorechance.value == -1 then return end
	if server.hostmod_doencoreswitch then
		server.hostmod_doencoreswitch = false
		if P_RandomRange(1, 100) <= hostmod_encorechance.value then
			COM_BufInsertText(server, "encore on")
		else
			COM_BufInsertText(server, "encore off")
		end
	end
end)