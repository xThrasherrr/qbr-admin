-------------------------------
----- Players Menu Page ------
-------------------------------
QBCore = {}
local playertab = {}

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
                event = 'qb-admin:PlayersPage',
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

    exports['qbr-menu']:openMenu(BanMenu)
end)

RegisterNetEvent("qbr-admin:BanReason", function(data)

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
        TriggerServerEvent('admin:server:ban', data.id, dialog.length, dialog.reason)
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
                event = 'qb-admin:PlayersPage',
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

    exports['qbr-menu']:openMenu(KickMenu)
end)

RegisterNetEvent("qbr-admin:KickReason", function(data)

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
        TriggerServerEvent('admin:server:kick', data.id, dialog.reason)
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
                event = 'qb-admin:PlayersPage',
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

    exports['qbr-menu']:openMenu(PermissionsMenu)
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

RegisterNetEvent('qb-admin:PlayersPage', function()

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
                    event = 'qb-admin:OpenPlayerMenu',
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

        exports['qbr-menu']:openMenu(PlayersPage)
    end)
end)

RegisterNetEvent('qb-admin:OpenPlayerMenu', function(data)
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

    exports['qbr-menu']:openMenu(PlayerPage)
end)
