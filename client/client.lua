RegisterCommand('svelte:show', function()
    SendNUI('setVisible', true)
    SetNuiFocus(true, true)
    print("Svelte showing")
end, false)

RegisterNUICallback('getClientData', function(_, cb)
    local playerCoords = GetEntityCoords(PlayerPedId())
    cb({
        x = math.ceil(playerCoords.x),
        y = math.ceil(playerCoords.y),
        z = math.ceil(playerCoords.z)
    })
end)

RegisterNUICallback('hideUI', function(_, cb)
    cb({})
    SetNuiFocus(false, false)
end)
