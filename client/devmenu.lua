---------------------------
----- Dev Menu Page ------
---------------------------
QBCore = {}

DrawScreenText = function(text, x, y, centred)
    SetTextScale(0.35, 0.35)
    SetTextColor(255, 255, 255, 255)
    SetTextCentre(centred)
    SetTextDropshadow(1, 0, 0, 0, 200)
    SetTextFontForCurrentCommand(0)
    DisplayText(CreateVarString(10, "LITERAL_STRING", text), x, y)
end

round = function(input, decimalPlaces)
    return tonumber(string.format('%.' .. (decimalPlaces or 0) .. 'f', input))
end

ToggleShowCoordinates = function()
    ShowingCoords = not ShowingCoords
    CreateThread(function()
      while ShowingCoords do
        local coords = GetEntityCoords(PlayerPedId())
        local heading = GetEntityHeading(PlayerPedId())
        local c = {}
        c.x = round(coords.x, 2)
        c.y = round(coords.y, 2)
        c.z = round(coords.z, 2)
        c.w = round(heading, 2)
        Wait(0)
        DrawScreenText(string.format('~w~COORDS: ~b~vector4(~w~%s~b~, ~w~%s~b~, ~w~%s~b~, ~w~%s~b~)', c.x, c.y, c.z, c.w), 0.4, 0.025, true)
      end
    end)
end

CopyToClipboard = function(dataType)
    local ped = PlayerPedId()
    if dataType == 'coords3' then
      local coords = GetEntityCoords(ped)
      local x = round(coords.x, 2)
      local y = round(coords.y, 2)
      local z = round(coords.z, 2)
      SendNUIMessage({
          string = string.format('vector3(%s, %s, %s)', x, y, z)
      })
      exports['qbr-core']:Notify(9, 'Vector3 Coords Copied', 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
    elseif dataType == 'coords4' then
      local coords = GetEntityCoords(ped)
      local x = round(coords.x, 2)
      local y = round(coords.y, 2)
      local z = round(coords.z, 2)
      local heading = GetEntityHeading(ped)
      local h = round(heading, 2)
      SendNUIMessage({
          string = string.format('vector4(%s, %s, %s, %s)', x, y, z, h)
      })
      exports['qbr-core']:Notify(9, 'Vector4 Coords Copied', 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
    elseif dataType == 'heading' then
      local heading = GetEntityHeading(ped)
      local h = round(heading, 2)
      SendNUIMessage({
          string = h
      })
      exports['qbr-core']:Notify(9, 'Heading Copied', 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
    end
end


RegisterNetEvent('qbr-admin:DevMenuPage', function()

    DevPage = {
        {
            header = "| DEVELOPER PAGE |",
            isMenuHeader = true,
        },
        {
            header = "🔳 | Noclip",
            txt = "",
            params = {
                event = 'admin:client:ToggleNoClip',
                isServer = false,
            }
        },
        {
            header = "🔳 | Display Coords",
            txt = "",
            shouldClose = false,
            params = {
                event = 'qbr-admin:ToggleCoords',
                isServer = false,
            }
        },
        {
            header = "🔳 | Copy Vector3",
            txt = "",
            shouldClose = false,
            params = {
                event = 'qbr-admin:CopytoClipboard',
                isServer = false,
                args = 'coords3'
            }
        },
        {
            header = "🔳 | Copy Vector4",
            txt = "",
            shouldClose = false,
            params = {
                event = 'qbr-admin:CopytoClipboard',
                isServer = false,
                args = 'coords4'
            }
        },
        {
            header = "🔳 | Copy Heading",
            txt = "",
            shouldClose = false,
            params = {
                event = 'qbr-admin:CopytoClipboard',
                isServer = false,
                args = 'heading'
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
        -- {
        --     header = "🔳 | Delete Lazer",
        --     txt = "",
        --     shouldClose = false,
        --     params = {
        --         event = 'admin:client:deletelazer',
        --         isServer = false,
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

    exports['qbr-menu']:openMenu(DevPage)
end)

----------------------
------- EVENTS ------
----------------------
RegisterNetEvent('qbr-admin:CopytoClipboard', function(type)
    CopyToClipboard(type)
end)

RegisterNetEvent('qbr-admin:ToggleCoords', function()
    ToggleShowCoordinates()
end)