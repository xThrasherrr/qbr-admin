----------------------------
----- Admin Menu Page ------
----------------------------
QBCore = {}
local GodModeStatus = false
local Invisible = false

---------------------------
--------- FUNCTIONS -------
---------------------------
RevivePlayer = function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    NetworkResurrectLocalPlayer(pos.x, pos.y, pos.z, GetEntityHeading(ped), true, false)
    SetEntityInvincible(ped, false)
    SetEntityMaxHealth(ped, 300)
    SetEntityHealth(ped, 300)
    ClearPedBloodDamage(ped)
    TriggerServerEvent('hud:server:RelieveStress', 100)
    exports['qbr-core']:Notify(9, 'You feel healthy again', 5000, 0, 'blips', 'blip_radius_search', 'COLOR_WHITE')
end

HealPlayer = function()
    local ped = PlayerPedId()
    SetEntityInvincible(ped, false)
    SetEntityMaxHealth(ped, 300)
    SetEntityHealth(ped, 300)
    ClearPedBloodDamage(ped)
    TriggerServerEvent('hud:server:RelieveStress', 100)
end

GodMode = function()
    local ped = PlayerPedId()
    if not GodModeStatus then
        SetEntityInvincible(ped, true)
        SetEntityMaxHealth(ped, 300)
        SetEntityHealth(ped, 300)
        ClearPedBloodDamage(ped)
        GodModeStatus = true
        exports['qbr-core']:Notify(9, 'Godmode Activated', 5000, 0, 'blips', 'blip_radius_search', 'COLOR_WHITE')
    else
        SetEntityInvincible(ped, false)
        GodModeStatus = false
        exports['qbr-core']:Notify(9, 'Godmode Deactivated', 5000, 0, 'blips', 'blip_radius_search', 'COLOR_RED')
    end
end

findZ = function(x, y)
    local found = true
    local start_z = 1500
    local z = start_z

    while found and z > 0 do
      local _found, _z, _normal = GetGroundZAndNormalFor_3dCoord(x, y, z + 0.0)
      if _found then
          z = _z + 0.0
      end
      found = _found
      Wait(0)
    end

    if z == start_z then
      return nil
    end

    return z + 0.0
end

GotoCoords = function(coords)
    if type(coords) ~= 'vector3' then
      exports['qbr-core']:Notify(9, 'Invalid Coordinates', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_RED')
    end

    local x = coords[1]
    local y = coords[2]
    local z = coords[3]
    local ped = PlayerPedId()

    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
      Wait(0)
    end

    SetEntityCoords(ped, x, y, 100.0)
    if z == 0 then
      local _finalZ
      local delay = 500
      for i = 1, 5 do
        if _finalZ ~= nil then
          break
        end

        _finalZ = findZ(x, y)
        if _z == nil then
          Wait(delay)
        end
      end

      if _finalZ ~= nil then
        z = _finalZ
      end
    end

    SetEntityCoords(ped, x, y, z)
    DoScreenFadeIn(500)
end

------------------------
------- EVENTS ---------
------------------------
RegisterNetEvent('qbr-admin:GoToMarker', function()
    local waypoint = GetWaypointCoords()
    if waypoint.x ~= 0 and waypoint.y ~= 0 then
      GotoCoords(vec3(waypoint.x, waypoint.y, 0))
      TriggerServerEvent('qbr-logs:server:CreateLog', 'admin', 'Admin Options', 'red', GetPlayerName() .. ' > TELEPORTED <')
    else
      exports['qbr-core']:Notify(9, "Invalid Coordinates", 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_RED')
    end
end)

RegisterNetEvent('admin:client:revivePlayer', function()
    TriggerServerEvent('qbr-logs:server:CreateLog', 'admin', 'Admin Options', 'red', GetPlayerName() .. ' > REVIVED SELF <')
    RevivePlayer()
end)

RegisterNetEvent('admin:client:healPlayer', function()
    TriggerServerEvent('qbr-logs:server:CreateLog', 'admin', 'Admin Options', 'red', GetPlayerName() .. ' > REVIVED SELF <')
    HealPlayer()
end)

RegisterNetEvent('admin:client:godmode', function()
    TriggerServerEvent('qbr-logs:server:CreateLog', 'admin', 'Admin Options', 'red', GetPlayerName() .. ' > TOGGLED GODMODE <')
    GodMode()
end)

RegisterNetEvent('admin:client:invisible', function()
    TriggerServerEvent('qbr-logs:server:CreateLog', 'admin', 'Admin Options', 'red', GetPlayerName() .. ' toggled > INVISIBILITY <')
    if Invisible then
        SetEntityVisible(PlayerPedId(), true)
        Invisible = false
    else
        SetEntityVisible(PlayerPedId(), false)
        Invisible = true
    end
end)

--------------------------
------- MENU PAGES ------
--------------------------
RegisterNetEvent('qbr-admin:OpenMainPage', function()

    MainPage = {
        {
            header = "| ADMIN MENU |",
            isMenuHeader = true,
        },
        {
            header = "😀 | Admin Options",
            txt = "",
            params = {
                event = 'qbr-admin:OpenAdminPage',
                isServer = false,
            }
        },
        {
            header = "👨‍👩‍👧 | Online Players",
            txt = "",
            params = {
                event = 'qbr-admin:PlayersPage',
                isServer = false,
            }
        },
        {
            header = "🌍 | Manage Server",
            txt = "",
            params = {
                event = 'qbr-admin:ServerMenuPage',
                isServer = false,
            }
        },
        {
            header = "🔧 | Developer Options",
            txt = "",
            params = {
                event = 'qbr-admin:DevMenuPage',
                isServer = false,
            }
        },
        {
            header = "❌ Close Menu",
            txt = '',
            params = {
                event = 'qbr-menu:closeMenu',
            }
        },
    }

    exports['qbr-core']:TriggerCallback('admin:server:hasperms', function(hasperms)
        if hasperms then
            exports['qbr-menu']:openMenu(MainPage)
        end
    end, 'perms')
end)

RegisterNetEvent('qbr-admin:OpenAdminPage', function()

    AdminPage = {
        {
            header = "| ADMIN PAGE |",
            isMenuHeader = true,
        },
        {
            header = "🔳 | Teleport to Waypoint",
            txt = "",
            params = {
                event = 'qbr-admin:GoToMarker',
                isServer = false,
            }
        },
        {
            header = "🔳 | Revive Self",
            txt = "",
            shouldClose = false,
            params = {
                event = 'admin:client:revivePlayer',
                isServer = false,
            }
        },
        {
            header = "🔳 | Heal Self",
            txt = "",
            shouldClose = false,
            params = {
                event = 'admin:client:healPlayer',
                isServer = false,
            }
        },
        {
            header = "🔳 | Invisible",
            txt = "",
            shouldClose = false,
            params = {
                event = 'admin:client:invisible',
                isServer = false,
            }
        },
        {
            header = "🔳 | Godmode",
            txt = "",
            shouldClose = false,
            params = {
                event = 'admin:client:godmode',
                isServer = false,
            }
        },
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
            exports['qbr-menu']:openMenu(AdminPage)
        end
    end, 'perms')
end)
