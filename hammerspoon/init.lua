hs.hotkey.bind({"cmd"}, "return", function()
    local wezterm = hs.application.find("WezTerm")
    
    -- If WezTerm is running
    if wezterm then
        local frontApp = hs.application.frontmostApplication()

        if frontApp:name() == "WezTerm" then
            -- If WezTerm is frontmost, hide it
            wezterm:hide()
        else
            -- Otherwise, bring it to front
            wezterm:activate()
        end
    else
        -- If not running, launch it
        hs.application.launchOrFocus("WezTerm")
    end

end)
