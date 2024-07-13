function begin_text_render()
    time_since = time_since + love.timer.getDelta()
    if (love.keyboard.isDown("x") or love.keyboard.isDown("rshift")) or is_instant == true then
        i = #string + 1
        prog_string = string
    end
    if (time_since >= interval and i <= #string) then
        ui_font:stop()
        if string.sub(string, i, i) == " " then -- IF NOT WOULDNT WORK IM SORRY THIS LOOKS SO BAD
        else
            ui_font:play(uifont)
        end
        time_since = 0
        prog_string = string.sub(string, 1, i)
        i = i + 1
    end
end
