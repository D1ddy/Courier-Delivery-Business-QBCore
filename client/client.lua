-- TODO: Add on the map a small icon to show that there is a job there -> try some sort of minimap/map component
local interactDistance = 10
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local playerCoords = GetEntityCoords(PlayerPedId())
        local shopXCoord = -515
        local shopYCoord =  -2202
        local shopZCoords = 6.39
        local playerCoordsVector = vector3(playerCoords.x,playerCoords.y,playerCoords.z)
        local ShopCoordsVector = vector3(shopXCoord,shopYCoord,shopZCoords)
        local distance = #(playerCoordsVector - ShopCoordsVector)
        if distance <= interactDistance then
            TriggerServerEvent('isPlayerDeliveryDriver')
            SendNUI('openPopUp',true)
            SetNuiFocus(false, false)
            if IsControlPressed(0, 38) then -- 38 is E key
                TriggerServerEvent('hirePlayerOrOpenMeni')
            end
        else
            SendNUI('closePopUp',false)
            SetNuiFocus(false,false)
        end
    end 
end)
RegisterNetEvent('playerIsDeliveryDriver:client',function()
    SendNUI('playerIsDeliveryDriver:notification','Press E to open menu')
end)
RegisterNetEvent('playerIsNotDeliveryDriver:client',function()
    SendNUI('playerIsNotDeliveryDriver:notification','Press E to get hired')
end)