Options = {
    {
        Image = 'https://cdn.discordapp.com/attachments/921477563832991824/1119608737838141510/badge.png',
        Title = 'Police',
        SubTitle = 'Search, cuff, escort, etc..',
        CanShow = function()
            return ESX.GetPlayerData().job.name == 'police'
        end,
        SubMenu = {
            {
                Image = 'https://cdn.discordapp.com/attachments/921477563832991824/1119612777238106122/handcuffs.png',
                Title = 'Cuff / Uncuff',
                SubTitle = 'Cuff the closest player',
                OnClick = {
                    Type = 'client-event',
                    Value = 'police:cuffPlayer',
                    Close = true
                }
            },
            {
                Title = 'Escort',
                SubTitle = 'Escort the closest player',
                OnClick = {
                    Type = 'client-event',
                    Value = 'police:escortPlayer',
                    Close = true
                }
            },
            {
                Image = 'https://cdn.discordapp.com/attachments/921477563832991824/1119613510188535858/magnifying-glass.png',
                Title = 'Search',
                SubTitle = 'Search the closest player',
                OnClick = {
                    Type = 'client-event',
                    Value = 'police:searchPlayer',
                    Close = true
                }
            },
            {
                Title = 'Props',
                SubTitle = 'Spawn available police props',
                SubMenu = {
                    {
                        Image = 'https://cdn.discordapp.com/attachments/921477563832991824/1119614237661200475/box.png',
                        Title = 'Box',
                        SubTitle = 'Spawn a box',
                        OnClick = {
                            Type = 'client-event',
                            Value = 'police:spawnBox',
                            Close = true
                        }
                    },
                    {
                        Image = 'https://cdn.discordapp.com/attachments/921477563832991824/1119614300391215114/cone.png',
                        Title = 'Cone',
                        SubTitle = 'Spawn a cone',
                        OnClick = {
                            Type = 'client-event',
                            Value = 'police:spawnCone',
                            Close = true
                        }
                    },
                    {
                        Image = 'https://cdn.discordapp.com/attachments/921477563832991824/1119614374500376706/traffic-barrier.png',
                        Title = 'Barrier',
                        SubTitle = 'Test a barrier',
                        OnClick = {
                            Type = 'client-event',
                            Value = 'police:spawnBarrier',
                            Close = true
                        }
                    }
                }
            }
        }
    },
    {
        Image = 'https://cdn.discordapp.com/attachments/921477563832991824/1119609699113902170/emergency-ambulance.png',
        Title = 'EMS',
        SubTitle = 'Revive, heal, etc...',
        CanShow = function()
            return ESX.GetPlayerData().job.name == 'ambulance'
        end,
        SubMenu = {
            {
                Image = 'https://cdn.discordapp.com/attachments/921477563832991824/1119616862850912308/heart_1.png',
                Title = 'Revive',
                SubTitle = 'Revive the closest player',
                OnClick = {
                    Type = 'client-event',
                    Value = 'ems:revivePlayer',
                    Close = true
                }
            },
            {
                Image = 'https://cdn.discordapp.com/attachments/921477563832991824/1119616621976240148/first-aid-kit.png',
                Title = 'Heal',
                SubTitle = 'Heal the closest player',
                OnClick = {
                    Type = 'client-event',
                    Value = 'ems:healPlayer',
                    Close = true
                }
            },
            {
                Title = 'Props',
                SubTitle = 'Spawn available EMS props',
                SubMenu = {
                    {
                        Image = 'https://cdn.discordapp.com/attachments/921477563832991824/1119617313210106007/hospital-bed.png',
                        Title = 'Stretcher',
                        SubTitle = 'Spawn a stretcher',
                        OnClick = {
                            Type = 'client-event',
                            Value = 'ems:spawnStretcher',
                            Close = true
                        }
                    }
                }
            }
        }
    }
}