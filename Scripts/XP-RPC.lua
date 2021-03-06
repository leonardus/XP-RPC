discordRPC = require "discordRPC"

local startTimestamp = os.time()
local applicationId = "536223561690644481"
local XPlane11SteamId = "269950"

function update_rpc()
    dataref("aircraft", "sim/aircraft/view/acf_descrip", "readable")
    dataref("tailnumber", "sim/aircraft/view/acf_tailnum", "readable")
    dataref("icao", "sim/aircraft/view/acf_ICAO", "readable")
    dataref("heading_magnetic", "sim/flightmodel/position/mag_psi", "readable")
    dataref("heading_true", "sim/flightmodel/position/true_psi", "readable")
    dataref("kias", "sim/flightmodel/position/indicated_airspeed", "readable")
    dataref("alt", "sim/flightmodel/position/elevation", "readable")
    alt = alt * 3.28084 -- convert m to ft
    discordRPC.updatePresence({
        ["details"] = aircraft,
        ["state"] = math.floor(alt) .. "ft MSL @ " .. math.floor(kias) .. "kias",
        ["startTimestamp"] = startTimestamp
    })
end

local function main()
    discordRPC.initialize(applicationId, false, XPlane11SteamId)
    do_on_exit("discordRPC.clearPresence()")
    do_often("update_rpc()")
end

local ok = xpcall(main, function(err)
    logMsg(err)
end)