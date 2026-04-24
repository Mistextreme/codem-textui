local coords = {
    { thema = 'thema-1',  key = "E", message = 'Open Crafting',      coords = vector3(-1361.4, -2937.25, 13.95) },
    { thema = 'thema-2',  key = "R", message = 'Open Door',          coords = vector3(-1365.01, -2935.3, 13.94) },
    { thema = 'thema-3',  key = "S", message = 'Open Vehicle',       coords = vector3(-1368.92, -2933.02, 13.94) },
    { thema = 'thema-4',  key = "C", message = 'Send Request',       coords = vector3(-1371.87, -2930.79, 13.94) },
    { thema = 'thema-5',  key = "U", message = 'Open Crafting',      coords = vector3(-1374.27, -2929.56, 13.94) },
    { thema = 'thema-6',  key = "P", message = 'Close Door',         coords = vector3(-1377.41, -2927.56, 13.94) },
    { thema = 'thema-7',  key = "R", message = 'Get in the vehicle', coords = vector3(-1380.6, -2925.83, 13.94) },
    { thema = 'thema-8',  key = "O", message = 'Open Trunk',         coords = vector3(-1383.87, -2924.35, 13.94) },
    { thema = 'thema-9',  key = "T", message = 'Lock Vehicle',       coords = vector3(-1386.82, -2922.87, 13.94) },
    { thema = 'thema-10', key = "J", message = 'Open Menu',          coords = vector3(-1390.4, -2921.17, 13.94) },
}

-- Variável para controlar o estado do UI
local textUiVisible = false

-- Função para verificar se o jogador está próximo de algum ponto
local function IsNearPoint(pos)
    for k, v in pairs(coords) do
        local dist = #(pos - v.coords)
        if dist < 1.5 then
            return v
        end
    end
    return false
end

-- Thread principal com otimização de desempenho
Citizen.CreateThread(function()
    -- Garantir que o resource está completamente carregado
    Wait(1000)
    
    -- Inicializa o estado, garantindo que UI está fechada no início
    exports[GetCurrentResourceName()]:CloseTextUI()
    
    while true do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local nearPoint = IsNearPoint(pos)
        local sleepTime = 1000 -- Padrão para quando longe dos pontos (1 segundo)
        
        -- Se estiver perto de um ponto
        if nearPoint then
            sleepTime = 0 -- Atualiza a cada frame quando perto
            
            -- Desenha o marcador
            DrawMarker(2, nearPoint.coords + vector3(0.0, 0.0, 0.5), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15,
                255, 255, 255, 255,
                false, false, false, true, false, false, false)
            
            -- Se o UI não estiver visível, mostra
            if not textUiVisible then
                exports[GetCurrentResourceName()]:OpenTextUI(nearPoint.message, nearPoint.key, nearPoint.thema)
                textUiVisible = true
            end
        -- Se não estiver perto de nenhum ponto e o UI estiver visível
        elseif textUiVisible then
            exports[GetCurrentResourceName()]:CloseTextUI()
            textUiVisible = false
        end
        
        Citizen.Wait(sleepTime) -- Espera adaptativa
    end
end)
