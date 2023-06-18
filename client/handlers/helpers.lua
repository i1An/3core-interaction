Helpers = {

    CopyTable = function(orig)
        local orig_type = type(orig)
        local copy
        if orig_type == 'table' then
            copy = { }
            for orig_key, orig_value in pairs(orig) do
                copy[orig_key] = orig_value
            end
        else
            copy = orig
        end
        return copy
    end,

    GenerateData = function(options)
        local tempTable = Helpers.CopyTable(options)
        for oIndex = 1, #tempTable do
            if tempTable[oIndex] then
                if tempTable[oIndex].SubMenu then
                    tempTable[oIndex].SubMenu = Helpers.GenerateData(tempTable[oIndex].SubMenu)
                end
                if tempTable[oIndex].CanShow and not tempTable[oIndex].CanShow() then
                    tempTable[oIndex] = { }
                end
                if type(tempTable[oIndex].CanShow) == 'function' then
                    tempTable[oIndex].CanShow = nil
                end
            end
        end
        return tempTable
    end,
    
    CheckIfDuplicate = function(cType, value)
        for key, interaction in pairs(Config.DefaultInteractions) do
            if interaction.Info.Type == cType then
                if interaction.Info.Value == value then
                    return true
                end
            end
        end
        return false
    end

}
