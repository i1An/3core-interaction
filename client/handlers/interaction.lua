Interaction = {

    LastEntity = nil,

    SendData = function(endCoords, entityHit)
        if entityHit == 0 then return end
        if #(GetEntityCoords(PlayerPedId()) - endCoords) > Config.MaxDistance then return end
        LastEntity = entityHit
        for key, interaction in pairs(Config.DefaultInteractions) do
            if interaction.Info.Type == 'EntityBone' then
                local boneCoords = GetWorldPositionOfEntityBone(entityHit, GetEntityBoneIndexByName(entityHit, interaction.Info.Value))
                if #(boneCoords - endCoords) < 1.0 then
                    local interactionData = Helpers.GenerateData(interaction.Options)
                    SendNUIMessage({ type = 'ShowInteraction', data = interactionData })
                end
            elseif interaction.Info.Type == 'PedBone' then
                local boneCoords = GetPedBoneCoords(entityHit, interaction.Info.Value, 0.0, 0.0, 0.0)
                if #(boneCoords - endCoords) < 0.1 then
                    local interactionData = Helpers.GenerateData(interaction.Options)
                    SendNUIMessage({ type = 'ShowInteraction', data = interactionData })
                end
            elseif interaction.Info.Type == 'Prop' then
                if GetHashKey(interaction.Info.Value) == GetEntityModel(entityHit) then
                    local interactionData = Helpers.GenerateData(interaction.Options)
                    SendNUIMessage({ type = 'ShowInteraction', data = interactionData })
                end
            elseif interaction.Info.Type == 'Entity' then
                if interaction.Info.Value == entityHit then
                    local interactionData = Helpers.GenerateData(interaction.Options)
                    SendNUIMessage({ type = 'ShowInteraction', data = interactionData })
                end
            elseif interaction.Info.Type == 'Player' then
                if IsPedAPlayer(entityHit) and entityHit ~= PlayerPedId() then
                    local interactionData = Helpers.GenerateData(interaction.Options)
                    SendNUIMessage({ type = 'ShowInteraction', data = interactionData })
                end
            end
        end
    end,

    StartRaycast = function()
        local retval, hit, endCoords, surfaceNormal, entityHit = Raycast.Start()
        Interaction.SendData(endCoords, entityHit)
    end,

    Destroy = function()
        SendNUIMessage({ type = 'HideInteraction' })
    end,

    GetLastEntity = function()
        return Interaction.LastEntity
    end

}