Helpers = {

    CopyTable = function(orig, copies)
        copies = copies or {}
        local orig_type = type(orig)
        local copy
        if orig_type == 'table' then
            if copies[orig] then
                copy = copies[orig]
            else
                copy = {}
                copies[orig] = copy
                for orig_key, orig_value in next, orig, nil do
                    copy[Helpers.CopyTable(orig_key, copies)] = Helpers.CopyTable(orig_value, copies)
                end
                setmetatable(copy, Helpers.CopyTable(getmetatable(orig), copies))
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
                if tempTable[oIndex].CanShow then
                    if not tempTable[oIndex].CanShow() then
                        tempTable[oIndex] = { }
                    end
                    if tempTable[oIndex] then
                        tempTable[oIndex].CanShow = ''
                    end
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