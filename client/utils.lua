local _SendNUIMessage = SendNUIMessage

--- Send a message to the NUI
--- @param action string 
--- @param data any
function SendNUI(action, data)
    _SendNUIMessage({
        action = action,
        data = data
    })
end