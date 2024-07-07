heart, player_x, player_y = love.graphics.newImage("/assets/images/ut-heart.png"), 313, 310

function soul()
    if love.keyboard.isDown("x") then
        player_speed = 2
    else
        player_speed = 4
    end

    if soulState == "choose enemy" then
        player_x = 52
        if choice == 1 then
            player_y = 280
        end
        if choice == 2 then
            player_y = 312
        end
        if choice == 3 then
            player_y = 344
        end
        function love.keypressed(key, scancode, isrepeat)
            if (key == "down" and soulState == "choose enemy") then
                love.audio.play(menumove)
                choice = choice + 1
                if choice == amount_of_enemies + 1 then
                    choice = 1
                end
            end
            if (key == "up" and soulState == "choose enemy") then
                love.audio.play(menumove)
                choice = choice - 1
                if choice == 0 then
                    choice = amount_of_enemies
                end
            end
            if (key == "x" and soulState == "choose enemy") then
                soulState = "buttons"
                renderText = true
            end
        end
    end

    if soulState == "enemy turn" then
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
        if player_x > box_x + (box_width) - 18 then
            player_x = box_x + (box_width) - 18
        end
        if player_x < box_x + 2 then
            player_x = box_x + 2
        end
        if player_y > box_y + (box_height) - 18 then
            player_y = box_y + (box_height) - 18
        end
        if player_y < box_y + 2 then
            player_y = box_y + 2
        end
    end

    if soulState == "buttons" then
        if onButton == 1 then 
            player_x = 40
            player_y = 446
        elseif onButton == 2 then
            player_x = 193
            player_y = 446
        elseif onButton == 3 then
            player_x = 353
            player_y = 446
        elseif onButton == 4 then
            player_x = 508
            player_y = 446
        end

        function love.keypressed(key, scancode, isrepeat)
            if (key == "left" and soulState == "buttons") then
                love.audio.play(menumove)
                onButton = onButton - 1
                if onButton == 0 then
                    onButton = 4
                end
            end
    
            if (key == "right" and soulState == "buttons") then
                onButton = onButton + 1
                love.audio.play(menumove)
                if onButton == 5 then
                    onButton = 1
                end
            end

            if (key == "z" and soulState == "buttons") then
                if onButton == 1 then
                    love.audio.play(menuconfirm)
                    renderText = false
                    soulState = "choose enemy"
                    choice = 1
                end
            end
        end
    end

    --[=====[
    love.graphics.circle("line", box_x + (box_width), box_y + (box_height / 2), 10)
    love.graphics.circle("line", box_x, box_y + (box_height / 2), 10)
    love.graphics.circle("line", box_x + (box_width / 2), box_y, 10)
    love.graphics.circle("line", box_x + (box_width / 2), box_y + (box_height), 10)
    --]=====]

    love.graphics.draw(heart, math.floor(player_x), math.floor(player_y))
end