exports['qb-core']:AddJob('deliverydriver', {
    label = 'Delivery driver',
    defaultDuty = true,
    offDutyPay = true,
    grades = {
        [0] = {
            name = 'Driver',
            payment = 10
        }
    }
})
local QBCore = exports['qb-core']:GetCoreObject()
RegisterNetEvent('hirePlayerOrOpenMeni',function()
    --TODO: Add checker if a job is in progress
    local Player = QBCore.Functions.GetPlayer(source)
    local jobInfo = Player.PlayerData.job
    local name = jobInfo.name
    if name ~= 'deliverydriver' then
        Player.Functions.Notify('You are now a Delivery Driver', 'success', 5000)
        Player.Functions.SetJob('deliverydriver',0)
        Player.Functions.UpdatePlayerData()
    else
        --TODO: Open meni but first i'll do when pressed e just to send a job
        TriggerClientEvent('startJob', source)
    end
end)
RegisterNetEvent('isPlayerDeliveryDriver',function()
    local Player = QBCore.Functions.GetPlayer(source)
    local jobInfo = Player.PlayerData.job
    local name = jobInfo.name
    if name ~= 'deliverydriver' then
        TriggerClientEvent('playerIsNotDeliveryDriver:client', source)
    else
        TriggerClientEvent('playerIsDeliveryDriver:client',source)
    end
end)
