function ui()
    if player_stats[3] < 1 then
        if player_stats[6] > 0 then
            player_stats[3] = 1
        else
            gameState = "death"
        end
    end

    if player_stats[3] + player_stats[6] > player_stats[4] then
        player_stats[3] = player_stats[4] - player_stats[6]
    end

    if player_stats[6] > 0 then
        timeSinceLastKr = timeSinceLastKr + tick.dt
        if timeSinceLastKr > 1.8 / (player_stats[6]) then
            timeSinceLastKr = 0
            player_stats[6] = player_stats[6] - 1
        end
    end

    if onButton == 1 then
        love.graphics.draw(fightSelected, 32, 432)
    else
        love.graphics.draw(fightUnselected, 32, 432)
    end

    if onButton == 2 then
        love.graphics.draw(actSelected, 185, 432)
    else
        love.graphics.draw(actUnselected, 185, 432)
    end

    if onButton == 3 then
        love.graphics.draw(itemSelected, 345, 432)
    else
        love.graphics.draw(itemUnselected, 345, 432)
    end

    if onButton == 4 then
        love.graphics.draw(mercySelected, 500, 432)
    else
        love.graphics.draw(mercyUnselected, 500, 432)
    end

    love.graphics.setColor(255, 255, 255, 1)

    love.graphics.setFont(uiFont)   -- ui text stuffs (name, hp text, love)
    love.graphics.print(player_stats[1] .. "   lv " .. player_stats[2], 30, 400)

    love.graphics.draw(hpName, 240, 400)

    love.graphics.setColor(192, 0, 0, 1)
    love.graphics.rectangle('fill', 275, 400, (player_stats[4] * 1.2), 21)

    love.graphics.setColor(255, 0, 255, 1)
    love.graphics.rectangle('fill', 275, 400, (player_stats[3] * 1.2 + player_stats[6] * 1.2), 21)

    love.graphics.setColor(250, 255, 0, 1)
    love.graphics.rectangle('fill', 275, 400, (player_stats[3] * 1.2), 21)

    love.graphics.setColor(255, 255, 255, 1)

    if (player_stats[6] > 0 and player_stats[5] == true) then
        love.graphics.setColor(255, 0, 255, 1)
    else
        love.graphics.setColor(255, 255, 255, 1)
    end

    if player_stats[5] == true then
        love.graphics.draw(kr, 282 + (player_stats[4] * 1.2), 405)
    end

    if (player_stats[3] > -1 and (player_stats[3] + player_stats[6]) < 10) then
        if player_stats[5] == true then
            love.graphics.print("0" .. (player_stats[3] + player_stats[6]) .. " / " .. player_stats[4], 322 + (player_stats[4] * 1.2), 400)
        else
            love.graphics.print("0" .. player_stats[3] .. " / " .. player_stats[4], 289 + (player_stats[4] * 1.2), 400)
        end
    else
        if player_stats[5] == true then
            love.graphics.print((player_stats[3] + player_stats[6]) .. " / " .. player_stats[4], 322 + (player_stats[4] * 1.2), 400)
        else
            love.graphics.print(player_stats[3] .. " / " .. player_stats[4], 289 + (player_stats[4] * 1.2), 400)
        end
    end
end

function hurt_player()
    player_stats[3] = player_stats[3] - 1
    if player_stats[5] == true then
        if player_stats[3] > 1 then
            player_stats[6] = player_stats[6] + 1
        else
            player_stats[6] = player_stats[6] - 1
        end
    end
end

function drawBox(x, y, width, height)
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.graphics.setColor(0, 0, 0, .5)
    love.graphics.rectangle('fill', math.floor(x), math.floor(y), math.floor(width), math.floor(height), 0, 0)

    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.setLineWidth(2)
    love.graphics.rectangle('line', math.floor(x) - 0.5, math.floor(y), math.floor(width), math.floor(height), 0, 0)

    love.graphics.setColor(255, 255, 255, 1)
    love.graphics.setLineWidth(4)
    love.graphics.rectangle('line', math.floor(x), math.floor(y), math.floor(width), math.floor(height), 0, 0)

    love.graphics.setColor(255, 255, 255, 1)
    love.graphics.setLineWidth(4)
    love.graphics.rectangle('line', math.floor(x) - 1, math.floor(y) - 1, math.floor(width) + 2, math.floor(height) + 2, 0, 0)
end