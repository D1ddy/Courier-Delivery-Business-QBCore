-- TODO: Add on the map a small icon to show that there is a job there -> try some sort of minimap/map component
local interactDistance = 10
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
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
RegisterNetEvent('startJob',function()
    -- TODO: Trigger a serverevent for checking if job is already in progress 
    local shortRoute = {vector3(-146.0,-1772.0,29.0),vector3(21.0,-1876.0,22.0),vector3(100.0,-1948.0,20.0),vector3(160.0,-1895.0,22.0),vector3(124.0,-1547.0,28.0),vector3(-495.0,-2179.0,8.0)}
    local MarkerTypeVerticalCylinder = 1 
    local playerCoords = GetEntityCoords(PlayerPedId())
    Citizen.CreateThread(function()
        local vehicle = nil
        while true do
            Citizen.Wait(0)
            DrawMarker(MarkerTypeVerticalCylinder, -504.4, -2205.21, 4.0 , 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 2.0, 0, 255 ,0 , 255, false,true,2,false,nil,nil,false)
            if IsEntityAtCoord(PlayerPedId(), -504.4, -2205.21, 6.0, 1.0, 1.0, 1.0, true, true, 0) then
                --TODO: Change outfit to a delivery driver
                local vehicleHash = 'mule2'
                if not IsModelInCdimage(vehicleHash) then return end
                RequestModel(vehicleHash)
                while not HasModelLoaded(vehicleHash) do 
                    Wait(0)
                end
                vehicle = CreateVehicle(vehicleHash, -508.15, -2194.16, 7.0, 320.18, true, false)
                local plate = GetVehicleNumberPlateText(vehicle)
                TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', plate)
                SetModelAsNoLongerNeeded(vehicleHash)
                break
            end
        end
        for i = 1, #shortRoute, 1 do 
            local marker = shortRoute[i]
            while true do
                Citizen.Wait(0)
                DrawMarker(MarkerTypeVerticalCylinder, marker.x, marker.y, marker.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 5.0, 5.0, 5.0,255,255,0,255,false,true,2,false,nil,nil,false)
                if IsEntityAtCoord(PlayerPedId(), marker.x, marker.y, marker.z, 2.0, 2.0, 2.0, true, true, 2) and IsPedInVehicle(PlayerPedId(), vehicle, true) == 1 then
                    ClearGpsPlayerWaypoint()
                    break
                else
                    SetNewWaypoint(marker.x, marker.y)
                end                
            end
        
        
        end

    end)
end)
