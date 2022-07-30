------------------------------
----- Server Menu Page ------
------------------------------
QBCore = {}

RegisterNetEvent('qbr-admin:ServerMenuPage', function()

    ServerMenu = {
        {
            header = "| SERVER SETTINGS |",
            isMenuHeader = true,
        },
        {
            header = "⛈️ | Weather",
            txt = "",
            params = {
                event = 'qbr-admin:WeatherPage',
                isServer = false,
            }
        },
        {
            header = "⌚ | Server Time",
            txt = "",
            params = {
                event = 'qb-admin:ServerTimeInput',
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
            header = "❌ Close Menu",
            txt = '',
            params = {
                event = 'qbr-menu:closeMenu',
            }
        },
    }

    exports['qbr-menu']:openMenu(ServerMenu)
end)

-- INPUT SERVER TIME --
RegisterNetEvent("qb-admin:ServerTimeInput", function()

    local dialog = exports['qbr-input']:ShowInput({
        header = "Input Server Time",
        submitText = "Submit",
        inputs = {
            {
                text = '[ HOURS ]',
                name = "hour",
                type = "text",
                isRequired = true,
            },
            {
                text = '[ MINUTES ]',
                name = "minute",
                type = "text",
                isRequired = true,
            }
        },
    })

    if dialog ~= nil then
        TriggerServerEvent('qbr-weathersync:server:setTime', dialog.hour, dialog.minute)
    end
end)

-- SERVER WEATHER --
RegisterNetEvent('qbr-admin:WeatherPage', function()

    ServerMenu = {
        {
            header = "| WEATHER |",
            isMenuHeader = true,
        },
        {
            header = "🌨️ | Blizzard",
            txt = "",
            params = {
                event = 'qbr-weathersync:server:setWeather',
                isServer = true,
                args = "BLIZZARD"
            }
        },
        {
            header = "☁ | Cloudy",
            txt = "",
            params = {
                event = 'qbr-weathersync:server:setWeather',
                isServer = true,
                args = "CLOUDS"
            }
        },
        {
            header = "☀ | Drizzle",
            txt = "",
            params = {
                event = 'qbr-weathersync:server:setWeather',
                isServer = true,
                args = "DRIZZLE"
            }
        },
        {
            header = "☀ | Foggy",
            txt = "",
            params = {
                event = 'qbr-weathersync:server:setWeather',
                isServer = true,
                args = "FOG"
            }
        },
        {
            header = "☀ | Ground Blizzard",
            txt = "",
            params = {
                event = 'qbr-weathersync:server:setWeather',
                isServer = true,
                args = "GROUNDBLIZZARD"
            }
        },
        {
            header = "🌁 | Hailing",
            txt = "",
            params = {
                event = 'qbr-weathersync:server:setWeather',
                isServer = true,
                args = "HAIL"
            }
        },
        {
            header = "🌁 | High Pressure",
            txt = "",
            params = {
                event = 'qbr-weathersync:server:setWeather',
                isServer = true,
                args = "HIGHPRESSURE"
            }
        },
        {
            header = "🌁 | Hurricane",
            txt = "",
            params = {
                event = 'qbr-weathersync:server:setWeather',
                isServer = true,
                args = "HURRICANE"
            }
        },
        {
            header = "🌁 | Misty",
            txt = "",
            params = {
                event = 'qbr-weathersync:server:setWeather',
                isServer = true,
                args = "MISTY"
            }
        },
        {
            header = "⛅ | Overcast",
            txt = "",
            params = {
                event = 'qbr-weathersync:server:setWeather',
                isServer = true,
                args = "OVERCAST"
            }
        },
        {
            header = "⛅ | Dark Overcast",
            txt = "",
            params = {
                event = 'qbr-weathersync:server:setWeather',
                isServer = true,
                args = "OVERCASTDARK"
            }
        },
        {
            header = "☂️ | Rain",
            txt = "",
            params = {
                event = 'qbr-weathersync:server:setWeather',
                isServer = true,
                args = "RAIN"
            }
        },
        {
            header = "☂️ | Sandstorm",
            txt = "",
            params = {
                event = 'qbr-weathersync:server:setWeather',
                isServer = true,
                args = "SANDSTORM"
            }
        },
        {
            header = "☂️ | Rain Shower",
            txt = "",
            params = {
                event = 'qbr-weathersync:server:setWeather',
                isServer = true,
                args = "SHOWER"
            }
        },
        {
            header = "☂️ | Sleet",
            txt = "",
            params = {
                event = 'qbr-weathersync:server:setWeather',
                isServer = true,
                args = "SLEET"
            }
        },
        {
            header = "❄️ | Snow",
            txt = "",
            params = {
                event = 'qbr-weathersync:server:setWeather',
                isServer = true,
                args = "SNOW"
            }
        },
        {
            header = "❄️ | Light Snow",
            txt = "",
            params = {
                event = 'qbr-weathersync:server:setWeather',
                isServer = true,
                args = "SNOWLIGHT"
            }
        },
        {
            header = "🌤 | Sunny",
            txt = "",
            params = {
                event = 'qbr-weathersync:server:setWeather',
                isServer = true,
                args = "SUNNY"
            }
        },
        {
            header = "⛈️ | Thunder",
            txt = "",
            params = {
                event = 'qbr-weathersync:server:setWeather',
                isServer = true,
                args = "THUNDER"
            }
        },
        {
            header = "⛈️ | Thunderstorm",
            txt = "",
            params = {
                event = 'qbr-weathersync:server:setWeather',
                isServer = true,
                args = "THUNDERSTORM"
            }
        },
        {
            header = "❄️ | Whiteout",
            txt = "",
            params = {
                event = 'qbr-weathersync:server:setWeather',
                isServer = true,
                args = "WHITEOUT"
            }
        },
        {
            header = "⬅️ | Go Back",
            txt = "",
            params = {
                event = 'qbr-admin:ServerMenuPage',
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

    exports['qbr-menu']:openMenu(ServerMenu)
end)