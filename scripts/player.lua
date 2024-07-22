function init_player()
    player = {
        name = " ",
        lv = 1,
        hp = 20,
        max_hp = 20,
        has_kr = false,
        amt_of_kr = 0,
        def = 0,
        atk = 0,
        inv_frames = 15,
        hitbox_leniency = 5,
        img = love.graphics.newImage("/assets/images/ut-heart.png"),
        x = 313,
        y = 0,
        gravity = 0,
        hurt = love.audio.newSource("/assets/sound/sfx/snd_hurt1.wav", "stream"),
        sub_choice = 1
    }

    inventory = {
        "Item 1",
        "Item 2",
        "Item 3",
        "Item 4",
        "Item 5",
        "Item 6",
        "Item 7",
        "Item 8"
    }
end

function hurt_player()
    player.hurt:stop()
    player.hurt:play()
    
    player.hp = player.hp - 4
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
    elseif soul_state == "items" then
        player.x, player.y = 64, 278
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
        end

        if key == "right" then
            if soul_state == "buttons" then
                on_button = on_button + 1
                love.audio.play(menu_move)
                if on_button == 5 then
                    on_button = 1
                end
            end
        end

        if (key == "z" or key == "return") then
            if soul_state == "buttons" then
                love.audio.play(menu_confirm)
                if on_button == 1 or on_button == 2 then
                    soul_state = "choose enemy"
                elseif on_button == 3 then
                    items_page = 1
                    soul_state = "items"
                elseif on_button == 4 then
                    soul_state = "mercy"
                end
            end
        end

        if (key == "x" or key == "return") then
            if soul_state == "choose enemy" or "items" or "mercy" then
                soul_state = "buttons"
                instance.prog_string = instance.text
            end
        end
    end

    love.graphics.draw(player.img, math.floor(player.x), math.floor(player.y))
end