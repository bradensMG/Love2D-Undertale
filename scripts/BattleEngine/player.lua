function init_player()
    player = {
        name = " ",
        lv = 1,
        hp = 10,
        max_hp = 109,
        has_kr = false,
        amt_of_kr = 0,
        def = 0,
        atk = 0,
        inv_frames = 1,
        hitbox_leniency = 5,
        img = love.graphics.newImage("/assets/images/ut-heart.png"),
        x = 313,
        y = 0,
        gravity = 0,
        hurt = love.audio.newSource("/assets/sound/sfx/snd_hurt1.wav", "stream"),
        sub_choice = 1
    }

    inventory = {
        "Heal",
        "Weapon",
        "Armor"
    }
end

function hurt_player()
    player.hurt:stop()
    player.hurt:play()
    
    player.hp = player.hp - 1
    if player.has_kr then
        if player.hp > 1 then
            player.amt_of_kr = player.amt_of_kr + 1
        else
            player.amt_of_kr = player.amt_of_kr - 1
        end
    end
end

function update_kr()
    if player.hp < 1 then
        if player.amt_of_kr > 1 then
            player.hp = 1
        else
            game_state = 'game over'
        end
    end
end

function update_inv_frames()
    inv_frame_timer = inv_frame_timer + (love.timer.getDelta() * 30)
    player.darken = true
    if inv_frame_timer > player.inv_frames then
        inv_frame_timer = player.inv_frames
        player.darken = false
    end
end

function draw_soul()
    if player.darken then
        love.graphics.setColor(.75, .75, .75)
    else
        love.graphics.setColor(1, 1, 1)
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

    maxright = arena.x + (arena.width) - 18
    maxleft = arena.x + 2
    maxup = arena.y + 2
    maxdown = arena.y + (arena.height) - 18

    if love.keyboard.isDown("x") then
        player.speed = 2 * love.timer.getDelta() * 30
    else
        player.speed = 4 * love.timer.getDelta() * 30
    end

    if soul_state == "enemy turn" then

        if movement == 1 then
            if love.keyboard.isDown("down") then 
                player.y = player.y + player.speed 
            end
            if love.keyboard.isDown("up") then 
                player.y = player.y - player.speed
            end
            if love.keyboard.isDown("right") then 
                player.x = player.x + player.speed
            end
            if love.keyboard.isDown("left") then 
                player.x = player.x - player.speed
            end

        elseif movement == 2 then
            if love.keyboard.isDown("left") then 
                player.x = player.x - player.speed
            end

            if love.keyboard.isDown("right") then 
                player.x = player.x + player.speed
            end

            if player.y < maxdown then
                player.gravity = player.gravity + 1
            end

            if love.keyboard.isDown("up") and player.y == maxdown then
                player.gravity = -6
            end

            player.y = player.y + player.gravity
            
        end

        if player.x > maxright then
            player.x = maxright
        end
        if player.x < maxleft then
            player.x = maxleft
        end
        if player.y > maxdown then
            player.y = maxdown
            player.gravity = 0
        end
        if player.y < maxup then
            player.y = maxup
        end
    end

    if soul_state == "buttons" then
        if on_button == 1 then 
            player.x = 40
            player.y = 446
        elseif on_button == 2 then
            player.x = 193
            player.y = 446
        elseif on_button == 3 then
            player.x = 353
            player.y = 446
        elseif on_button == 4 then
            player.x = 508
            player.y = 446
        end 
           
    elseif soul_state == "choose enemy" then

        player.x = 52

        if player.sub_choice == 1 then
            player.y = 278
        elseif player.sub_choice == 2 then
            player.y = 310
        elseif player.sub_choice == 3 then
            player.y = 342
        end

    elseif soul_state == "act" then

        if chosen_enemy == 1 then
            if player.sub_choice > #enemy1_acts then
                player.sub_choice = 1
            elseif player.sub_choice < 1 then
                player.sub_choice = #enemy1_acts
            end
        elseif chosen_enemy == 2 then
            if player.sub_choice > #enemy2_acts then
                player.sub_choice = 1
            elseif player.sub_choice < 1 then
                player.sub_choice = #enemy2_acts
            end
        elseif chosen_enemy == 3 then
            if player.sub_choice > #enemy3_acts then
                player.sub_choice = 1
            elseif player.sub_choice < 1 then
                player.sub_choice = #enemy3_acts
            end
        end

        if player.sub_choice == 1 then
            player.x = 52
            player.y = 278
        elseif player.sub_choice == 2 then
            player.x = 288
            player.y = 278
        elseif player.sub_choice == 3 then
            player.x = 52
            player.y = 310
        elseif player.sub_choice == 4 then
            player.x = 288
            player.y = 310
        elseif player.sub_choice == 5 then
            player.x = 52
            player.y = 342
        elseif player.sub_choice == 6 then
            player.x = 288
            player.y = 342
        end

    elseif soul_state == "items" then
        if player.sub_choice > #inventory then
            player.sub_choice = 1
        elseif player.sub_choice < 1 then
            player.sub_choice = #inventory
        end

        if player.sub_choice == 1 or player.sub_choice == 5 then
            player.x, player.y = 64, 278
        elseif player.sub_choice == 2 or player.sub_choice == 6 then
            player.x, player.y = 304, 278
        elseif player.sub_choice == 3 or player.sub_choice == 7 then
            player.x, player.y = 64, 310
        elseif player.sub_choice == 4 or player.sub_choice == 8 then
            player.x, player.y = 304, 310
        end

        if player.sub_choice > 4 then
            items_page = 2
        elseif player.sub_choice < 5 then
            items_page = 1
        end

    elseif soul_state == "mercy" then

        player.x = 52

        if player.sub_choice == 1 then
            player.y = 278
        elseif player.sub_choice == 2 then
            player.y = 310
        end
    end

    function love.keypressed(key, scancode, isrepeat)
        if key == "left" then

            if soul_state == "buttons" then
                love.audio.play(menu_move)
                on_button = on_button - 1
                if on_button == 0 then
                    on_button = 4
                end
            end

            if soul_state == "act" or soul_state == "items" then
                love.audio.play(menu_move)
                player.sub_choice = player.sub_choice - 1
            end

            if player.sub_choice == 4 then
                player.sub_choice = 2
            elseif player.sub_choice == 6 then
                player.sub_choice = 4
            end

        end

        if key == "right" then

            if soul_state == "buttons" then
                on_button = on_button + 1
                love.audio.play(menu_move)
                if on_button == 5 then
                    on_button = 1
                end
            end

            if soul_state == "act" or soul_state == "items" then
                love.audio.play(menu_move)
                player.sub_choice = player.sub_choice + 1
            end

            if soul_state == "items" then
                if player.sub_choice == 3 then
                    player.sub_choice = 5
                elseif player.sub_choice == 5 then
                    player.sub_choice = 7
                end
            end

        end

        if key == "up" then

            if soul_state == "choose enemy" and player.sub_choice > 1 then
                love.audio.play(menu_move)
                player.sub_choice = player.sub_choice - 1
            end

            if soul_state == "act" or soul_state == "items" then
                love.audio.play(menu_move)
                player.sub_choice = player.sub_choice - 2
            end

            if soul_state == "mercy" and player.sub_choice > 1 then
                love.audio.play(menu_move)
                player.sub_choice = player.sub_choice - 1
            end

        end

        if key == "down" then

            if soul_state == "choose enemy" and player.sub_choice < enemies.amount then
                love.audio.play(menu_move)
                player.sub_choice = player.sub_choice + 1
            end

            if soul_state == "act" or soul_state == "items" then
                love.audio.play(menu_move)
                player.sub_choice = player.sub_choice + 2
            end

            if soul_state == "mercy" and (enemies.can_flee and player.sub_choice == 1) then
                love.audio.play(menu_move)
                player.sub_choice = player.sub_choice + 1
            end

        end

        if (key == "z" or key == "return") then

            if soul_state == "act" then
                do_act()
                on_button = 0
                soul_state = nil
            end

            if soul_state == "choose enemy" then
                if on_button == 1 then
                    soul_state = nil
                    on_button = 0
                elseif on_button == 2 then
                    chosen_enemy = player.sub_choice
                    player.sub_choice = 1
                    soul_state = "act"
                end
            end

            if soul_state == "buttons" then
                love.audio.play(menu_confirm)
                if on_button == 1 or on_button == 2 then
                    player.sub_choice = 1
                    soul_state = "choose enemy"
                elseif on_button == 3 then
                    items_page = 1
                    player.sub_choice = 1
                    soul_state = "items"
                elseif on_button == 4 then
                    player.sub_choice = 1
                    soul_state = "mercy"
                end
            end

        end

        if (key == "x" or key == "rshift") then

            if soul_state == "choose enemy" or soul_state == "items" or soul_state == "mercy" then
                soul_state = "buttons"
                instance.prog_string = instance.text
            end

            if soul_state == "act" then
                player.sub_choice = 1
                soul_state = "choose enemy"
            end

        end
    end

    if soul_state ~= nil then
        love.graphics.draw(player.img, math.floor(player.x), math.floor(player.y))
    end
end