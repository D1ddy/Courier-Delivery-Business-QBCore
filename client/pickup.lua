local interactDistance = 2
local playerCoords = GetEntityCoords(PlayerPedId())
local box = CreateObject('prop_cs_cardbox_01', playerCoords.x, playerCoords.y + 0.5, playerCoords.z , true, false, false)
local SKEL_L_Hand = 0x49D9
local ROT_ZYX = 0
local offsetX, offsetY, offsetZ = 0.0, 0.5, 0.0
local rotX, rotY, rotZ = 0.0, 0.0, 0.0
Citizen.CreateThread(function()
    while true do
        Wait(100)
        local playerCoords = GetEntityCoords(PlayerPedId())
        local playerCoordsVector = vector3(playerCoords.x,playerCoords.y,playerCoords.z)
        local boxCoords = GetEntityCoords(box)
        local boxVector = vector3(boxCoords.x,boxCoords.y,boxCoords.z)
        local distance = #(playerCoordsVector - boxVector)
        if distance <= interactDistance then
            if IsControlPressed(0, 38) then -- 38 is E key
                --TODO: Add player animation
                AttachEntityToEntity(box, PlayerPedId(), SKEL_L_Hand, offsetX, offsetY, offsetZ, rotX, rotY, rotZ, false, false, true, false, ROT_ZYX, true)
            end
            if IsControlPressed(0,44) then --44 is Q key
                --TODO: Add player animation
                DetachEntity(box, false, true)
            end
        end
    end
end)