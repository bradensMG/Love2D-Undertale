if game_state == "encounter" then
    function update_kr()
        if player.hp < 1 then
            if player.amt_of_kr > 0 then
                player.hp = 1
            else
                game_state = "death"
            end
        end

        if player.hp + player.amt_of_kr > player.max_hp then
            player.hp = player.max_hp - player.amt_of_kr
        end

        if player.amt_of_kr > 0 then
            kr_time_since = kr_time_since + love.timer.getDelta()
            if kr_time_since > 1.8 / player.amt_of_kr then
                kr_time_since = 0
                player.amt_of_kr = player.amt_of_kr - 1
            end
        end
    end

    function battle_init()
        kr_time_since = 0
        on_button = 1

        soul_state = "buttons" -- i recommend either having this be "buttons" or "enemy turn dialogue"
        movement = 1

        -- the first item is the encounter text. the rest are random text in the menu
        flavor_text = {
            "* I feel so UNDERLOVE right now!"
        }

        set_text_params(flavor_text[1], 52, 274, fonts.main, false, tick.dt)
        render_text = true

        box_x, box_y, box_width, box_height = 35, 253, 569, 134 -- starting positions of the box

        player = {
            name = "chara",
            lv = 1,
            hp = 20,
            max_hp = 20,
            has_kr = false,
            amt_of_kr = 0,
            def = 0,
            atk = 0
        }
    end

    function love.draw()
        love.graphics.setDefaultFilter("nearest", "nearest")

        if render_text == false then
            prog_string = ""
        end

        love.graphics.setBackgroundColor(.25, 0, .5)
        
        -- love.graphics.draw(background_img)
                
        draw_hp_and_healthbar()
        draw_buttons()
        draw_box(box_x, box_y, box_width, box_height)
        soul()

        love.graphics.setColor(1, 1, 1, 1)
            
        love.graphics.setFont(fonts.main)
        love.graphics.print(prog_string, x, y)
    end

    function love.update(dt)
        love.audio.setVolume(0.1)

        battle_mus:setLooping(true)
        battle_mus:play()
        if render_text == true then
            begin_text_render()
        end
    end
end