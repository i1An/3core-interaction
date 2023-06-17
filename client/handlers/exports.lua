AddEntityBone = function(interactionData)
    if not interactionData or not next(interactionData) or not interactionData.Bone then
        return error('[INTERACTION] Creation failed, missing parameters.')
    end
    if Helpers.CheckIfDuplicate('EntityBone', interactionData.Bone) then
        return error('[INTERACTION] Creation failed, duplicate entry was found.')
    end
    table.insert(Config.DefaultInteractions, {
        Info = { Type = 'EntityBone', Value = interactionData.Bone },
        Options = interactionData.Options
    })
end

AddPedBone = function(interactionData)
    if not interactionData or not next(interactionData) or not interactionData.Bone then
        return error('[INTERACTION] Creation failed, missing parameters.')
    end
    if Helpers.CheckIfDuplicate('PedBone', interactionData.Bone) then
        return error('[INTERACTION] Creation failed, duplicate entry was found.')
    end
    table.insert(Config.DefaultInteractions, {
        Info = { Type = 'PedBone', Value = interactionData.Bone },
        Options = interactionData.Options
    })
end

AddProp = function(interactionData)
    if not interactionData or not next(interactionData) or not interactionData.Prop then
        return error('[INTERACTION] Creation failed, missing parameters.')
    end
    if Helpers.CheckIfDuplicate('Prop', interactionData.Prop) then
        return error('[INTERACTION] Creation failed, duplicate entry was found.')
    end
    if not IsModelValid(interactionData.Prop) then
        return error('[INTERACTION] Creation failed, invalid prop.')
    end
    table.insert(Config.DefaultInteractions, {
        Info = { Type = 'Prop', Value = interactionData.Prop },
        Options = interactionData.Options
    })
end

AddEntity = function(interactionData)
    if not interactionData or not next(interactionData) or not interactionData.Entity then
        return error('[INTERACTION] Creation failed, missing parameters.')
    end
    if Helpers.CheckIfDuplicate('Entity', interactionData.Entity) then
        return error('[INTERACTION] Creation failed, duplicate entry was found.')
    end
    if not DoesEntityExist(interactionData.Entity) then
        return error('[INTERACTION] Creation failed, entity doesn\'t exist.')
    end
    table.insert(Config.DefaultInteractions, {
        Info = { Type = 'Entity', Value = interactionData.Entity },
        Options = interactionData.Options
    })
end

GetLastEntity = function()
    return Interaction.GetLastEntity()
end

exports('AddEntityBone', AddEntityBone)

exports('AddPedBone', AddPedBone)

exports('AddProp', AddProp)

exports('AddEntity', AddEntity)

exports('GetLastEntity', GetLastEntity)