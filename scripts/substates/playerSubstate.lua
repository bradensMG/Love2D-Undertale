heart, player_x, player_y = love.graphics.newImage("/assets/images/ut-heart.png"), 313, 310

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

function hurt_player()
    player.hp = player.hp - 1
    if player_stats[5] == true then
        if player.hp > 1 then
            player.amt_of_kr = player.amt_of_kr + 1
        else
            player.amt_of_kr = player.amt_of_kr - 1
        end
    end
end

function update_kr()
    if player.hp < 1 then
        if player.amt_of_kr > 0 then
            player.hp = 1
        else
            game_state = "death"
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
        player_speed = 2 * love.timer.getDelta() * 30
    else
        player_speed = 4 * love.timer.getDelta() * 30
    end

    if soul_state == "enemy turn" then
        if movement == 1 then
            if love.keyboard.isDown("down") then 
                player_y = player_y + player_speed 
            end
            if love.keyboard.isDown("up") then 
                player_y = player_y - player_speed
            end
            if love.keyboard.isDown("right") then 
                player_x = player_x + player_speed
            end
            if love.keyboard.isDown("left") then 
                player_x = player_x - player_speed
            end
        end
        if player_x > maxright then
            player_x = maxright
        end
        if player_x < maxleft then
            player_x = maxleft
        end
        if player_y > maxup then
            player_y = maxup
        end
        if player_y < maxdown then
            player_y = maxdown
        end
    end

    if soul_state == "buttons" then
        if on_button == 1 then 
            player_x = 40
            player_y = 446
        elseif on_button == 2 then
            player_x = 193
            player_y = 446
        elseif on_button == 3 then
            player_x = 353
            player_y = 446
        elseif on_button == 4 then
            player_x = 508
            player_y = 446
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

    love.graphics.draw(heart, math.floor(player_x), math.floor(player_y))
end