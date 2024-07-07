function beginTextRender()
    timeSince = timeSince + tick.dt
    if love.keyboard.isDown("x") or isInstant == true then
        i = #string + 1
        progString = string
    end
    if (timeSince >= interval and i <= #string) then
        uifont:stop()
        if string.sub(string, i, i) == " " then -- IF NOT WOULDNT WORK IM SORRY THIS LOOKS SO BAD
        else
            uifont:play(uifont)
        end
        timeSince = 0
        progString = string.sub(string, 1, i)
        i = i + 1
    end
end