--================================--
--      B-vMenuLogs 1.0           --
--      by BreezyTheDev           --
--		GNU License v3.0		  --
--================================--

-- Webhook Configuration
webhookmsg = '' -- Webhook for the vMenu message logger.
webhookvmenu = '' -- Webhook for the following events: ClearArea, KillPlayer, & SummonPlayer.
whcolor = '44270' -- 44270 is the preset color.

-- Net Events

-- (Credits: FreeStyle#0001 | https://github.com/FSSynthetic/Private-vMenu-Message-Logger)
RegisterNetEvent('vMenu:SendMessageToPlayer', function(target, message)
    local sourceID = source
    local sourceName = GetPlayerName(sourceID)
    local targetName = GetPlayerName(target)
    sendToDiscord(webhookmsg, whcolor, "vMenu Event: Private Message", "**From:**\n**ID: "..sourceID.."** | "..sourceName.."\n\n**To:**\n**ID: "..target.."** | "..targetName.."\n\n**Message:** `"..message.."`")  
end)

RegisterNetEvent('vMenu:ClearArea', function()
    local sourceID = source
    local sourceName = GetPlayerName(sourceID)
    sendToDiscord(webhookvmenu, whcolor, "vMenu Event: Clear Area", "**ID: "..sourceID.."** | "..sourceName.." has cleared the area")
end)

RegisterNetEvent('vMenu:KillPlayer', function(target)
    local sourceID = source
    local sourceName = GetPlayerName(sourceID)
    local targetName = GetPlayerName(target)
    sendToDiscord(webhookvmenu, whcolor, "vMenu Event: Kill Player", "**ID: "..sourceID.."** | "..sourceName.. " has killed ".."**ID: "..target.."** | ".. targetName)
end)

RegisterNetEvent('vMenu:SummonPlayer', function(target)
    local sourceID = source
    local sourceName = GetPlayerName(sourceID)
    local targetName = GetPlayerName(target)
    sendToDiscord(webhookvmenu, whcolor, "vMenu Event: Summon Player", "**ID: "..sourceID.."** | "..sourceName.. " has summoned ".."**ID: "..target.."** | ".. targetName)
end)

-- Functions
function sendToDiscord(webhook, color, name, message, footer)
    -- This is the embed configuration that will be sent in the http request below.
    local embed = {
          {
              ["color"] = color,
              ["title"] = "**".. name .."**",
              ["description"] = message,
              ["footer"] = {
                  ["text"] = footer,
              },
          }
      }
    
    -- This is the function that sends the embed above as a Discord webhook message.
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({embeds = embed}), { ['Content-Type'] = 'application/json' })
end

-- VERSION CHECKER
expectedName = "B-vMenuLogs" -- This is the resource and is not suggested to be changed.
resource = GetCurrentResourceName()

-- check if resource is renamed
if resource ~= expectedName then
    print("^1[^4" .. expectedName .. "^1] WARNING^0")
    print("Change the resource name to ^4" .. expectedName .. " ^0or else it won't work!")
end


print("^0This resource was created by ^5Breezy#0001 ^0for support you can join his ^5discord: ^0https://discord.gg/zzUfkfRHzP")

-- check if resource version is up to date
PerformHttpRequest("https://raw.githubusercontent.com/BreezyTheDev/B-vMenuLogs/main/fxmanifest.lua", function(error, res, head)
    i, j = string.find(tostring(res), "version")
    res = string.sub(tostring(res), i, j + 6)
    res = string.gsub(res, "version ", "")

    res = string.gsub(res, '"', "")
    resp = tonumber(res)
    verFile = GetResourceMetadata(expectedName, "version", 0)
    if verFile then
        if tonumber(verFile) < resp then
            print("^1[^4" .. expectedName .. "^1] WARNING^0")
            print("^4" .. expectedName .. " ^0is outdated. Please update it from ^5https://github.com/BreezyTheDev/B-vMenuLogs^0| Current Version: ^1" .. verFile .. " ^0| New Version: ^2" .. resp .. " ^0|")
        elseif tonumber(verFile) > tonumber(resp) then
            print("^1[^4" .. expectedName .. "^1] WARNING^0")
            print("^4" .. expectedName .. "s ^0version number is higher than we expected. | Current Version: ^3" .. verFile .. " ^0| Expected Version: ^2" .. resp .. " ^0|")
        else
            print("^4" .. expectedName .. " ^0is up to date | Current Version: ^2" .. verFile .. " ^0|")
        end
    else
        print("^1[^4" .. expectedName .. "^1] WARNING^0")
        print("You may not have the latest version of ^4" .. expectedName .. "^0. A newer, improved version may be present at ^5https://github.com/BreezyTheDev/B-vMenuLogs")
    end
end)
