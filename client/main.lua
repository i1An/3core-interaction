RegisterCommand('openinteraction', function()
    if IsNuiFocused() then
        SetNuiFocus(false, false)
        Interaction.Destroy()
    else
        SetNuiFocus(true, true)
    end
end)

RegisterKeyMapping('openinteraction', 'Open Interaction Mouse', 'keyboard', 'LMENU')