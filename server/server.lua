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
local isJobInProgress = false
RegisterNetEvent('hirePlayerOrOpenMeni',function()
    local Player = QBCore.Functions.GetPlayer(source)
    local jobInfo = Player.PlayerData.job
    local name = jobInfo.name
    if name ~= 'deliverydriver' then
        Player.Functions.Notify('You are now a Delivery Driver', 'success', 5000)
        Player.Functions.SetJob('deliverydriver',0)
        Player.Functions.UpdatePlayerData()
    else
        --TODO: Open meni but first i'll do when pressed e just to send a job
        if isJobInProgress == false then
            TriggerClientEvent('startJob', source)
        else
            Player.Functions.Notify('Job is already in progress', 'error', 5000)
        end
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
RegisterNetEvent('isJobInProgress',function()
    if isJobInProgress == false then
        isJobInProgress = true
    else
        isJobInProgress = false
    end
end)
RegisterNetEvent('payPlayer',function()
    --TODO: After adding more routes add a switch statement longer jobs more money
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    Player.Functions.AddMoney('cash', 250)
end)
RegisterNetEvent('cancelDelivery:server',function()
    local Player = QBCore.Functions.GetPlayer(source)
    if isJobInProgress then
        isJobInProgress = false
        Player.Functions.Notify('Job canceled','success',2000)
        TriggerClientEvent('deleteVehicle', source)
    else
        if not Player then return end
        Player.Functions.Notify('Player is not in a job','error' ,5000)
    end
end)
