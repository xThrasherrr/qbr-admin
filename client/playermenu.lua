-------------------------------
----- Players Menu Page ------
-------------------------------
QBCore = {}
local playertab = {}
local lastSpectateCoord = nil
local isSpectating = false

RegisterNetEvent('qbr-admin:client:BanMenu', function(data)
    BanMenu = {
        {
            header = "| Set Permissions |",
            isMenuHeader = true,
        },
        {
            header = "🔳 | Input Reason",
            txt = "",
            params = {
                event = 'qbr-admin:BanReason',
                isServer = false,
                args = {id = data.id}
            }
        },
        {
            header = "⬅️ | Go Back",
            txt = "",
            params = {
                event = 'qbr-admin:PlayersPage',
                isServer = false,
            }
        },
        {
            header = "❌ | Close Menu",
            txt = '',
            params = {
                event = 'qbr-menu:closeMenu',
            }
        },
    }

    exports['qbr-core']:TriggerCallback('admin:server:hasperms', function(hasperms)
        if hasperms then
            exports['qbr-menu']:openMenu(BanMenu)
        end
    end, 'perms')
end)

RegisterNetEvent("qbr-admin:BanReason", function(id)

    local dialog = exports['qbr-input']:ShowInput({
        header = "Ban Player",
        submitText = "Submit",
        inputs = {
            {
                text = '[ REASON ]',
                name = "reason",
                type = "text",
                isRequired = true,
            },
            {
                text = '[ LENGTH ]',
                name = "length",
                type = "number",
                isRequired = true,
            },
        },
    })

    if dialog ~= nil then
        TriggerServerEvent('admin:server:ban', id, dialog.length, dialog.reason)
    end
end)

RegisterNetEvent('qbr-admin:client:KickMenu', function(data)
    KickMenu = {
        {
            header = "| Set Permissions |",
            isMenuHeader = true,
        },
        {
            header = "🔳 | Input Reason",
            txt = "",
            params = {
                event = 'qbr-admin:KickReason',
                isServer = false,
                args = {id = data.id}
            }
        },
        {
            header = "⬅️ | Go Back",
            txt = "",
            params = {
                event = 'qbr-admin:PlayersPage',
                isServer = false,
            }
        },
        {
            header = "❌ | Close Menu",
            txt = '',
            params = {
                event = 'qbr-menu:closeMenu',
            }
        },
    }
    exports['qbr-core']:TriggerCallback('admin:server:hasperms', function(hasperms)
        if hasperms then
            exports['qbr-menu']:openMenu(KickMenu)
        end
    end, 'perms')
end)

RegisterNetEvent("qbr-admin:KickReason", function(id)

    local dialog = exports['qbr-input']:ShowInput({
        header = "Kick Player",
        submitText = "Submit",
        inputs = {
            {
                text = '[ REASON ]',
                name = "reason",
                type = "text",
                isRequired = true,
            },
        },
    })

    if dialog ~= nil then
        TriggerServerEvent('admin:server:kick', id, dialog.reason)
    end
end)

RegisterNetEvent('qbr-admin:client:PermissionsMenu', function(data)
    PermissionsMenu = {
        {
            header = "| Set Permissions |",
            isMenuHeader = true,
        },
        {
            header = "🔳 | Set Group",
            txt = "",
            params = {
                event = 'qbr-admin:PermissionsInput',
                isServer = false,
                args = {id = data.id}
            }
        },
        {
            header = "⬅️ | Go Back",
            txt = "",
            params = {
                event = 'qbr-admin:PlayersPage',
                isServer = false,
            }
        },
        {
            header = "❌ | Close Menu",
            txt = '',
            params = {
                event = 'qbr-menu:closeMenu',
            }
        },
    }

    exports['qbr-core']:TriggerCallback('admin:server:hasperms', function(hasperms)
        if hasperms then
            exports['qbr-menu']:openMenu(PermissionsMenu)
        end
    end, 'perms')
end)

RegisterNetEvent("qbr-admin:PermissionsInput", function(data)

    local dialog = exports['qbr-input']:ShowInput({
        header = "Set Player Permissions",
        submitText = "Submit",
        inputs = {
            {
                text = '[ MOD, ADMIN, GOD ]',
                name = "group",
                type = "text",
                isRequired = true,
            },
        },
    })

    if dialog ~= nil then
        TriggerServerEvent('admin:server:setpermission', data.id, dialog.group)
    end
end)

RegisterNetEvent('qbr-admin:PlayersPage', function()

    exports['qbr-core']:TriggerCallback('admin:server:getplayers', function(players)
        local PlayersPage = {
            {
                header = '| Online Players |',
                isMenuHeader = true,
            },
        }

        for k, v in pairs(players) do
            PlayersPage[#PlayersPage + 1] = {
                header = 'ID: '..k..' | '..v.name,
                txt = "",
                params = {
                    event = 'qbr-admin:OpenPlayerMenu',
                    args = {name = v.name, player = k},
                }
            }
        end

        PlayersPage[#PlayersPage + 1] = {
            header = "⬅️ | Go Back",
            text = "",
            params = {
                event = "qbr-admin:OpenMainPage",
            }
        }

        PlayersPage[#PlayersPage + 1] = {
            header = "❌ | Close Menu",
            text = "",
            params = {
                event = "qbr-menu:closeMenu",
            }
        }

        exports['qbr-core']:TriggerCallback('admin:server:hasperms', function(hasperms)
            if hasperms then
                exports['qbr-menu']:openMenu(PlayersPage)
            end
        end, 'perms')
    end)
end)

RegisterNetEvent('qbr-admin:OpenPlayerMenu', function(data)

    PlayerPage = {
        {
            header = "| "..data.name.." |",
            isMenuHeader = true,
        },
        {
            header = "🔳 | Revive",
            txt = "",
            params = {
                event = 'admin:server:revive',
                isServer = true,
                args = {id = data.player}
            }
        },
        {
            header = "🔳 | Heal",
            txt = "",
            shouldClose = false,
            params = {
                event = 'admin:server:heal',
                isServer = true,
                args = {id = data.player}
            }
        },
        {
            header = "🔳 | Kill",
            txt = "",
            shouldClose = false,
            params = {
                event = 'admin:server:kill',
                isServer = true,
                args = {id = data.player}
            }
        },
        {
            header = "🔳 | Spectate",
            txt = "",
            shouldClose = false,
            params = {
                event = 'admin:server:spectate',
                isServer = true,
                args = {id = data.player}
            }
        },
        {
            header = "🔳 | Freeze",
            txt = "",
            shouldClose = false,
            params = {
                event = 'admin:server:freeze',
                isServer = true,
                args = {id = data.player}
            }
        },
        {
            header = "🔳 | Goto",
            txt = "",
            shouldClose = false,
            params = {
                event = 'admin:server:goto',
                isServer = true,
                args = {id = data.player}
            }
        },
        {
            header = "🔳 | Bring",
            txt = "",
            shouldClose = false,
            params = {
                event = 'admin:server:bring',
                isServer = true,
                args = {id = data.player}
            }
        },
        {
            header = "🔳 | Sit on Mount",
            txt = "",
            shouldClose = false,
            params = {
                event = 'admin:server:sitonmount',
                isServer = false,
                args = {id = data.player}
            }
        },
        {
            header = "🔳 | Open Inventory",
            txt = "",
            shouldClose = false,
            params = {
                event = 'admin:server:inventory',
                isServer = true,
                args = {id = data.player}
            }
        },
        {
            header = "🔳 | Give Clothing Menu",
            txt = "",
            shouldClose = false,
            params = {
                event = 'admin:server:cloth',
                isServer = true,
                args = {id = data.player}
            }
        },
        {
            header = "🔳 | Kick",
            txt = "",
            shouldClose = false,
            params = {
                event = 'qbr-admin:client:KickMenu',
                isServer = false,
                args = {id = data.player}
            }
        },
        {
            header = "🔳 | Ban",
            txt = "",
            shouldClose = false,
            params = {
                event = 'qbr-admin:client:BanMenu',
                isServer = false,
                args = {id = data.player}
            }
        },
        -- {
        --     header = "🔳 | Permissions",
        --     txt = "",
        --     shouldClose = false,
        --     params = {
        --         event = 'qbr-admin:client:PermissionsMenu',
        --         isServer = false,
        --         args = {id = data.player}
        --     }
        -- },
        {
            header = "⬅️ | Go Back",
            txt = "",
            params = {
                event = 'qbr-admin:OpenMainPage',
                isServer = false,
            }
        },
        {
            header = "❌ | Close Menu",
            txt = '',
            params = {
                event = 'qbr-menu:closeMenu',
            }
        },
    }

    exports['qbr-core']:TriggerCallback('admin:server:hasperms', function(hasperms)
        if hasperms then
            exports['qbr-menu']:openMenu(PlayerPage)
        end
    end, 'perms')
end)

------------------------
------- EVENTS ---------
------------------------
-- SEND REPORTS --
RegisterNetEvent('qb-admin:client:SendReport', function(name, src, msg)
    TriggerServerEvent('qb-admin:server:SendReport', name, src, msg)
end)

-- OPEN INVENTORY --
RegisterNetEvent('qb-admin:client:inventory', function(targetPed)
    TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", targetPed)
end)

-- SPECTATE --
RegisterNetEvent('qb-admin:client:spectate', function(targetPed)
    local myPed = PlayerPedId()
    local targetplayer = GetPlayerFromServerId(targetPed)
    local target = GetPlayerPed(targetplayer)
    if not isSpectating then
        isSpectating = true
        SetEntityVisible(myPed, false) -- Set invisible
        SetEntityCollision(myPed, false, false) -- Set collision
        SetEntityInvincible(myPed, true) -- Set invincible
        NetworkSetEntityInvisibleToNetwork(myPed, true) -- Set invisibility
        lastSpectateCoord = GetEntityCoords(myPed) -- save my last coords
        NetworkSetInSpectatorMode(true, target) -- Enter Spectate Mode
    else
        isSpectating = false
        NetworkSetInSpectatorMode(false, target) -- Remove From Spectate Mode
        NetworkSetEntityInvisibleToNetwork(myPed, false) -- Set Visible
        SetEntityCollision(myPed, true, true) -- Set collision
        SetEntityCoords(myPed, lastSpectateCoord) -- Return Me To My Coords
        SetEntityVisible(myPed, true) -- Remove invisible
        SetEntityInvincible(myPed, false) -- Remove godmode
        lastSpectateCoord = nil -- Reset Last Saved Coords
    end
end)
