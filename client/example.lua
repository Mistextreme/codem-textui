local coords = {
    { thema = 'thema-1',  key = "E", message = 'Open Crafting',      position = "left",   coords = vector3(-1361.4,  -2937.25, 13.95) },
    { thema = 'thema-2',  key = "R", message = 'Open Door',          position = "right",  coords = vector3(-1365.01, -2935.3,  13.94) },
    { thema = 'thema-3',  key = "S", message = 'Open Vehicle',       position = "top",    coords = vector3(-1368.92, -2933.02, 13.94) },
    { thema = 'thema-4',  key = "C", message = 'Send Request',       position = "bottom", coords = vector3(-1371.87, -2930.79, 13.94) },
    { thema = 'thema-5',  key = "U", message = 'Open Crafting',      position = "center", coords = vector3(-1374.27, -2929.56, 13.94) },
    { thema = 'thema-6',  key = "P", message = 'Close Door',         position = "left",   coords = vector3(-1377.41, -2927.56, 13.94) },
    { thema = 'thema-7',  key = "R", message = 'Get in the vehicle', position = "right",  coords = vector3(-1380.6,  -2925.83, 13.94) },
    { thema = 'thema-8',  key = "O", message = 'Open Trunk',         position = "left",   coords = vector3(-1383.87, -2924.35, 13.94) },
    { thema = 'thema-9',  key = "T", message = 'Lock Vehicle',       position = "bottom", coords = vector3(-1386.82, -2922.87, 13.94) },
    { thema = 'thema-10', key = "J", message = 'Open Menu',          position = "top",    coords = vector3(-1390.4,  -2921.17, 13.94) },
}

local textUiVisible = false

local function IsNearPoint(pos)
    for k, v in pairs(coords) do
        local dist = #(pos - v.coords)
        if dist < 1.5 then
            return v
        end
    end
    return false
end

Citizen.CreateThread(function()
    Wait(1000)
    exports[GetCurrentResourceName()]:CloseTextUI()

    while true do
        local ped      = PlayerPedId()
        local pos      = GetEntityCoords(ped)
        local nearPoint = IsNearPoint(pos)
        local sleepTime = 1000

        if nearPoint then
            sleepTime = 0

            DrawMarker(2, nearPoint.coords + vector3(0.0, 0.0, 0.5),
                0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15,
                255, 255, 255, 255,
                false, false, false, true, false, false, false)

            if not textUiVisible then
                exports[GetCurrentResourceName()]:OpenTextUI(
                    nearPoint.message,
                    nearPoint.key,
                    nearPoint.thema,
                    nearPoint.position
                )
                textUiVisible = true
            end
        elseif textUiVisible then
            exports[GetCurrentResourceName()]:CloseTextUI()
            textUiVisible = false
        end

        Citizen.Wait(sleepTime)
    end
end)