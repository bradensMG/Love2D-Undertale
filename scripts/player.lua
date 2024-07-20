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
        inv_frames = 30,
        hitbox_leniency = 6,
        img = love.graphics.newImage("/assets/images/ut-heart.png"),
        x = 313,
        y = 310
    }
end

function hurt_player()
    player.hp = player.hp - 5
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

function draw_soul()
    love.graphics.setColor(1, 1, 1, 1)

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

    maxright = box_x + (box_width) - 18
    maxleft = box_x + 2
    maxup = box_y + (box_height) - 18
    maxdown = box_y + 2

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
        end
        if player.x > maxright then
            player.x = maxright
        end
        if player.x < maxleft then
            player.x = maxleft
        end
        if player.y > maxup then
            player.y = maxup
        end
        if player.y < maxdown then
            player.y = maxdown
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
    end

    function love.keypressed(key, scancode, isrepeat)
        if (key == "left" and soul_state == "buttons") then
            love.audio.play(menu_move)
            on_button = on_button - 1
            if on_button == 0 then
                on_button = 4
            end
        end

        if (key == "right" and soul_state == "buttons") then
            on_button = on_button + 1
            love.audio.play(menu_move)
            if on_button == 5 then
                on_button = 1
            end
        end

        if ((key == "z" or key == "return") and soul_state == "buttons") then
            love.audio.play(menu_confirm)
        end
    end

    love.graphics.draw(player.img, math.floor(player.x), math.floor(player.y))
end