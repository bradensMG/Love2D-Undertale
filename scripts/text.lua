function clear()
    prog_string = ""
    time_since = 0
    progress = 0
    txt_can_prog = false
end

function set_params(my_str, my_x, my_y, my_rad, my_font, my_timing, my_mode, my_effect, my_sound)
    text = my_str
    prog_string = ""
    srt_x = my_x
    srt_y = my_y
    letter_shake_amount = my_rad
    font = my_font
    interv_speed = my_timing
    is_instant = my_mode
    text_animation = my_effect
    text_sound = my_sound

    txt_can_prog = false

    time_since = 0
    progress = 0
end

function draw()
    love.graphics.setFont(font)
    
    local x = srt_x
    local y = srt_y

    for i = 1, #text do
        local char = prog_string:sub(i, i)
        local char_next = text:sub((i + 1), (i + 1))
        local char_prev = prog_string:sub((i - 1), (i - 1))

        if txt_color == 'w' then
            love.graphics.setColor(1, 1, 1, 1)
        elseif txt_color == 'r' then
            love.graphics.setColor(1, 0, 0, 1)
        elseif txt_color == 'g' then
            love.graphics.setColor(0, 1, 0, 1)
        elseif txt_color == 'b' then
            love.graphics.setColor(0, 0, 1, 1)
        elseif txt_color == 'y' then
            love.graphics.setColor(1, 1, 0, 1)
        elseif txt_color == 'p' then
            local colorOffset = i * 0.1
            local r = 0.5 + math.sin(love.timer.getTime() * letter_shake_amount * 2 + i) * 0.5 + 0.2
            local g = 0.5 + math.sin(love.timer.getTime() * letter_shake_amount * 2 + i + math.pi / 2) * 0.5 + 0.2
            local b = 0.5 + math.sin(love.timer.getTime() * letter_shake_amount * 2 + i + math.pi) * 0.5 + 0.2
            love.graphics.setColor(r, g, b, 1)
        end
        
        if char == '/' then
            love.graphics.setColor(0, 0, 0, 0)
            if char_next == 'n' then
                y = y + font:getHeight(char) + 4
            else
                x = x - (font:getWidth(char))
            end
        elseif char_prev == '/' then
            love.graphics.setColor(0, 0, 0, 0)
            if char == 'n' then
                x = srt_x - (font:getWidth(char))
            elseif char == 'p' then
                x = x - (font:getWidth(char))
                txt_color = char
            elseif char == 's' then
                x = x - (font:getWidth(char))
            elseif char == 'w' then
                x = x - (font:getWidth(char))
                txt_color = char
            elseif char == 'r' then
                x = x - (font:getWidth(char))
                txt_color = char
            elseif char == 'g' then
                x = x - (font:getWidth(char))
                txt_color = char
            elseif char == 'b' then
                x = x - (font:getWidth(char))
                txt_color = char
            elseif char == 'y' then
                x = x - (font:getWidth(char))
                txt_color = char
            elseif char == 'a' then
                x = x - (font:getWidth(char))
                text_animates = true
            elseif char == 'f' then
                x = x - (font:getWidth(char))
                text_animates = false
            end
        end

        if text_animates == true then
            if text_animation == 'shake' then
                shakeX = love.math.random(-letter_shake_amount, letter_shake_amount)
                shakeY = love.math.random(-letter_shake_amount, letter_shake_amount)
            elseif text_animation == 'wave' then
                shakeX = math.cos((love.timer.getTime() * 8) + (i *.5)) * letter_shake_amount
                shakeY = math.sin((love.timer.getTime() * 8) + (i *.5)) * letter_shake_amount
            end
        else
            shakeX = 0
            shakeY = 0
        end

        love.graphics.print(char, x + shakeX, y + shakeY)

        x = x + font:getWidth(char)
    end
end

function upd()
    time_since = time_since + tick.dt

    if love.keyboard.isDown('x') or is_instant then
        txt_can_prog = true
        progress = #text + 1
        prog_string = text
    end

    while (time_since >= interv_speed and progress <= #text) do
        txt_can_prog = false
        local current_char = text:sub(progress, progress)
        local next_char = text:sub(progress + 1, progress + 1)

        if current_char == '/' and next_char ~= 's' then
            progress = progress + 2
        else
            if current_char ~= '/' then
                text_sound:stop()
                if not (text:sub(progress - 1, progress - 1) == '/') then
                    text_sound:play(text_sound)
                end
            end
            time_since = 0
            prog_string = text:sub(1, progress)
            progress = progress + 1
        end
    end

    if progress > #text then
        txt_can_prog = true
    end
end
