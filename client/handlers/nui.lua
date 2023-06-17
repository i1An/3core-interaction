RegisterNuiCallback('startInteraction', function(data, cb)
    Interaction.StartRaycast()
end)

RegisterNuiCallback('onClick', function(data, cb)
    if not data.item.OnClick then return end
    if data.item.OnClick.Type == 'client-event' then
        TriggerEvent(data.item.OnClick.Value)
    elseif data.item.OnClick.Type == 'server-event' then
        TriggerServerEvent(data.item.OnClick.Value)
    elseif data.item.OnClick.Type == 'command' then
        ExecuteCommand(data.item.OnClick.Value)
    end
    if data.item.OnClick.Close then
        Interaction.Destroy()
        SetNuiFocus(false, false)
    end
end)