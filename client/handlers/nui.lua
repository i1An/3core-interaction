RegisterNuiCallback('startInteraction', function(data, cb)
    Interaction.StartRaycast()
end)

RegisterNuiCallback('onClick', function(data, cb)
    if not data.item.OnClick then return end
    if data.item.OnClick.Type == 'client-event' then
        if data.item.OnClick.Args then
            TriggerEvent(data.item.OnClick.Value, table.unpack(data.item.OnClick.Args))
        else
            TriggerEvent(data.item.OnClick.Value)
        end
    elseif data.item.OnClick.Type == 'server-event' then
        if data.item.OnClick.Args then
            TriggerServerEvent(data.item.OnClick.Value, table.unpack(data.item.OnClick.Args))
        else
            TriggerServerEvent(data.item.OnClick.Value)
        end
    elseif data.item.OnClick.Type == 'command' then
        ExecuteCommand(data.item.OnClick.Value)
    end
    if data.item.OnClick.Close then
        Interaction.Destroy()
        SetNuiFocus(false, false)
    end
end)
