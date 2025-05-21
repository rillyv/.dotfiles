-- if you want to use a different keyboard combo, define it here.
local hyper = { "cmd", "alt", "ctrl", "shift" }

-- define your own shortcut list here
local windows = {
["0"] = "com.tinyapp.TablePlus-setapp", -- TablePlus
["1"] = "com.google.Chrome", -- Google Chrome
["2"] = "org.alacritty", -- Alacritty
-- ["3"] = "com.todesktop.230313mzl4w4u92", -- Cursor
["4"] = "com.spotify.client",
-- ["5"] = "Slack",
["6"] = "com.apple.Notes", -- Notes
["7"] = "org.gimp.gimp-3.0", -- Gimp
["8"] = "com.openai.chat", -- ChatGPT
W = "net.whatsapp.WhatsApp", -- Whatsapp
F = "com.figma.Desktop", -- Figma
D = "com.docker.docker", -- Docker
S = "com.google.Chrome.app.cbnofoppjfbjdmendfcknghaagbdblif", -- Servd
C = "com.clickup.desktop-app", -- ClickUp
G = "com.google.Chrome.app.hknobdmmohljcbkbojibpjaaidnnjghk", -- Gripp
['\\'] = "Hammerspoon", -- Hammerspoon
}

-- if the app has to be launched by a different name
-- than the one the windows are found by, this list
-- will take precedence when opening the app.
local windowLaunchNames = {
}

local lastKey = ''
local lastKeyTime = 0
local lastWindowIndex = 1
local appWindows = nil
local doubleKeyThreshold = .8

-- set up the binding for each key combo
for key, appName in pairs(windows) do
    hs.hotkey.bind(hyper, key, function()
        local keyTime = hs.timer.secondsSinceEpoch()
        -- for a repeated key press, cycle through windows
        if key == lastKey and keyTime - lastKeyTime < doubleKeyThreshold then
            if appWindows == nil then
                -- find the switchable windows
                local app = hs.application.find(appName)
                if app then
                    appWindows = hs.fnutils.filter(app:allWindows(), function(w)
                        return w:isStandard()
                    end)
                end
            end

            if appWindows and #appWindows > 0 then
                -- increment and loop
                lastWindowIndex = lastWindowIndex % #appWindows + 1

                --cycle apps
                appWindows[lastWindowIndex]:focus()
            end
        else
            -- switch to window
            appWindows = nil
            lastWindowIndex = 1

            local app = hs.application.get(appName)
            if app then
                app:activate(true)
            else
                local launchName = windowLaunchNames[key] or appName
                if string.match(launchName, "%.") then
                    -- It's a bundle ID, not a normal app name
                    hs.application.launchOrFocusByBundleID(launchName)
                else
                    hs.application.launchOrFocus(launchName)
                end
            end
        end

        lastKey = key
        lastKeyTime = keyTime
    end)
end
