if game_state == "encounter" then
    function update_kr()
        if player_stats[3] < 1 then
            if player_stats[6] > 0 then
                player_stats[3] = 1
            else
                game_state = "death"
            end
        end

        if player_stats[3] + player_stats[6] > player_stats[4] then
            player_stats[3] = player_stats[4] - player_stats[6]
        end

        if player_stats[6] > 0 then
            kr_time_since = kr_time_since + love.timer.getDelta()
            if kr_time_since > 1.8 / (player_stats[6]) then
                kr_time_since = 0
                player_stats[6] = player_stats[6] - 1
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

        set_text_params(flavor_text[1], 52, 274, dtm, false)
        render_text = true

        box_x, box_y, box_width, box_height = 35, 253, 569, 134 -- starting positions of the box

        player_stats = {
            "Chara", -- name
            1, -- lv
            20, -- hp
            20, -- max hp
            false, -- has kr?
            0, -- amt of kr (don't change)
            0, -- def
            0 -- atk
        }
    end

    function love.draw()
        love.graphics.setDefaultFilter("nearest", "nearest")

        if render_text == false then
            prog_string = ""
        end

        love.graphics.setBackgroundColor(0, 0, 0)
        
        love.graphics.draw(background_img)
                
        draw_hp_and_healthbar()
        draw_buttons()
        draw_box(box_x, box_y, box_width, box_height)
        soul()

        love.graphics.setColor(1, 1, 1, 1)
            
        love.graphics.setFont(dtm)
        love.graphics.print(progString, x, y)
        
        if love.keyboard.isDown("1") then
            love.graphics.setFont(dotumche)
        end
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