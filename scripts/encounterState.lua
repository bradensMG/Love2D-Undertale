if game_state == "encounter" then

    function battle_init()
        kr_time_since = 0
        on_button = 1

        soul_state = "buttons" -- i recommend either having this be "buttons" or "enemy turn dialogue"
        movement = 1

        box_x, box_y, box_width, box_height = 35, 253, 569, 134 -- starting positions of the box

        set_params('/f/w* A /y/aweird encounter/w/f lies beneath/n  you.', 52, 274, 2, fonts.main, 1 / 60, false, 'wave', ui_font)

        render_text = true

        show_debug = true
    end

    function love.draw()
        love.graphics.setBackgroundColor(.4, .4, .4)
        
        -- love.graphics.draw(background_img)
                
        draw_hp_and_healthbar()
        draw_buttons()
        draw_box(box_x, box_y, box_width, box_height)
        draw_soul()

        if soul_state == "enemy turn" then
            draw_attack()
        end

        if render_text == false then
            prog_string = ""
        else
            draw()
        end

        if show_debug then
            love.graphics.setColor(1, 1, 1)
            love.graphics.setFont(fonts.dialogue)
            love.graphics.print("FPS: " .. math.floor(1 / love.timer.getDelta()) .. '\nDelta: ' .. love.timer.getDelta() .. '\nTime: ' .. love.timer.getTime() .. '\n\nCurrent state: ' .. game_state)
        end

        love.graphics.setColor(1, 1, 1, 1)
    end

    function love.update(dt)
        if render_text then
            upd()
        end

        love.audio.setVolume(0)

        battle_mus:setLooping(true)
        battle_mus:play()
    end
end