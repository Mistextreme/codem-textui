-- Função para abrir o TextUI
exports('OpenTextUI',function(message, key, thema)
    if message == nil or key == nil or thema == nil then
        print("^1[ERROR]^7 OpenTextUI requires message, key, and thema parameters")
        return
    end
    
    SendNUIMessage({
        action = 'SHOW_TEXTUI',
        data = {
            message = message, 
            key = key, 
            thema = thema
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
    
    -- Garantir que o TextUI esteja fechado quando o resource iniciar
    Citizen.Wait(500)
    exports[GetCurrentResourceName()]:CloseTextUI()
end)

-- Remova os comandos de teste ou comente-os para evitar a exibição constante
RegisterCommand("ui", function()
    exports[GetCurrentResourceName()]:OpenTextUI("thema 1", "E", 'thema-1')
    Citizen.Wait(1000)
    exports[GetCurrentResourceName()]:CloseTextUI()
    Citizen.Wait(500)
    exports[GetCurrentResourceName()]:OpenTextUI("thema 2", "A", 'thema-2')
    Citizen.Wait(1000)
    exports[GetCurrentResourceName()]:CloseTextUI()
    Citizen.Wait(500)
    exports[GetCurrentResourceName()]:OpenTextUI("thema3", "S", 'thema-3')
    Citizen.Wait(1000)
    exports[GetCurrentResourceName()]:CloseTextUI()
    Citizen.Wait(500)
    exports[GetCurrentResourceName()]:OpenTextUI("thema 4", "D", 'thema-4')
    Citizen.Wait(1000)
    exports[GetCurrentResourceName()]:CloseTextUI()
    Citizen.Wait(500)
    exports[GetCurrentResourceName()]:OpenTextUI("thema 5", "F", 'thema-5')
    Citizen.Wait(1000)
    exports[GetCurrentResourceName()]:CloseTextUI()
    Citizen.Wait(500)
    exports[GetCurrentResourceName()]:OpenTextUI("thema 6", "G", 'thema-6')
    Citizen.Wait(1000)
    exports[GetCurrentResourceName()]:CloseTextUI()
    Citizen.Wait(500)
    exports[GetCurrentResourceName()]:OpenTextUI("thema 7", "H", 'thema-7')
    Citizen.Wait(1000)
    exports[GetCurrentResourceName()]:CloseTextUI()
    Citizen.Wait(500)
    exports[GetCurrentResourceName()]:OpenTextUI("thema 8", "I", 'thema-8')
    Citizen.Wait(1000)
    exports[GetCurrentResourceName()]:CloseTextUI()
    Citizen.Wait(500)
    exports[GetCurrentResourceName()]:OpenTextUI("thema 9", "E", 'thema-9')
    Citizen.Wait(1000)
    exports[GetCurrentResourceName()]:CloseTextUI()
    Citizen.Wait(500)
    exports[GetCurrentResourceName()]:OpenTextUI("thema 10", "E", 'thema-10')
    Citizen.Wait(1000)
    exports[GetCurrentResourceName()]:CloseTextUI()
    Citizen.Wait(500)
    exports[GetCurrentResourceName()]:OpenTextUI("thema 11", "H", 'thema-11')
    Citizen.Wait(1000)
    exports[GetCurrentResourceName()]:CloseTextUI()
    Citizen.Wait(500)
    exports[GetCurrentResourceName()]:OpenTextUI("thema 12", "K", 'thema-12')
    Citizen.Wait(1000)
    exports[GetCurrentResourceName()]:CloseTextUI()
    Citizen.Wait(500)
end)
--[[

RegisterCommand("uii", function ()
    exports[GetCurrentResourceName()]:CloseTextUI()
end)
]]--