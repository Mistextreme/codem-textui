-- Função para abrir o TextUI
exports('OpenTextUI', function(message, key, thema, position)
    if message == nil or key == nil or thema == nil then
        print("^1[ERROR]^7 OpenTextUI requires message, key, and thema parameters")
        return
    end

    -- Posições válidas: "left" | "right" | "top" | "bottom" | "center"
    local validPositions = { left = true, right = true, top = true, bottom = true, center = true }
    if position == nil or not validPositions[position] then
        position = "left"
    end

    SendNUIMessage({
        action = 'SHOW_TEXTUI',
        data = {
            message  = message,
            key      = key,
            thema    = thema,
            position = position
        }
    })
end)

-- Função para fechar o TextUI
exports('CloseTextUI', function()
    SendNUIMessage({
        action = "CLOSE_TEXTUI"
    })
end)

-- Quando o resource iniciar, garantir que a UI está fechada
AddEventHandler('onClientResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    Citizen.Wait(500)
    exports[GetCurrentResourceName()]:CloseTextUI()
end)

RegisterCommand("ui", function()
    exports[GetCurrentResourceName()]:OpenTextUI("thema 1",  "E", 'thema-1',  "left")
    Citizen.Wait(1000)
    exports[GetCurrentResourceName()]:CloseTextUI()
    Citizen.Wait(500)
    exports[GetCurrentResourceName()]:OpenTextUI("thema 2",  "A", 'thema-2',  "right")
    Citizen.Wait(1000)
    exports[GetCurrentResourceName()]:CloseTextUI()
    Citizen.Wait(500)
    exports[GetCurrentResourceName()]:OpenTextUI("thema3",   "S", 'thema-3',  "top")
    Citizen.Wait(1000)
    exports[GetCurrentResourceName()]:CloseTextUI()
    Citizen.Wait(500)
    exports[GetCurrentResourceName()]:OpenTextUI("thema 4",  "D", 'thema-4',  "bottom")
    Citizen.Wait(1000)
    exports[GetCurrentResourceName()]:CloseTextUI()
    Citizen.Wait(500)
    exports[GetCurrentResourceName()]:OpenTextUI("thema 5",  "F", 'thema-5',  "center")
    Citizen.Wait(1000)
    exports[GetCurrentResourceName()]:CloseTextUI()
    Citizen.Wait(500)
    exports[GetCurrentResourceName()]:OpenTextUI("thema 6",  "G", 'thema-6',  "left")
    Citizen.Wait(1000)
    exports[GetCurrentResourceName()]:CloseTextUI()
    Citizen.Wait(500)
    exports[GetCurrentResourceName()]:OpenTextUI("thema 7",  "H", 'thema-7',  "right")
    Citizen.Wait(1000)
    exports[GetCurrentResourceName()]:CloseTextUI()
    Citizen.Wait(500)
    exports[GetCurrentResourceName()]:OpenTextUI("thema 8",  "I", 'thema-8',  "left")
    Citizen.Wait(1000)
    exports[GetCurrentResourceName()]:CloseTextUI()
    Citizen.Wait(500)
    exports[GetCurrentResourceName()]:OpenTextUI("thema 9",  "E", 'thema-9',  "bottom")
    Citizen.Wait(1000)
    exports[GetCurrentResourceName()]:CloseTextUI()
    Citizen.Wait(500)
    exports[GetCurrentResourceName()]:OpenTextUI("thema 10", "E", 'thema-10', "top")
    Citizen.Wait(1000)
    exports[GetCurrentResourceName()]:CloseTextUI()
    Citizen.Wait(500)
    exports[GetCurrentResourceName()]:OpenTextUI("thema 11", "H", 'thema-11', "center")
    Citizen.Wait(1000)
    exports[GetCurrentResourceName()]:CloseTextUI()
    Citizen.Wait(500)
    exports[GetCurrentResourceName()]:OpenTextUI("thema 12", "K", 'thema-12', "right")
    Citizen.Wait(1000)
    exports[GetCurrentResourceName()]:CloseTextUI()
    Citizen.Wait(500)
end)