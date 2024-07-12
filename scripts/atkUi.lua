function attackUi()
    if soulState == "target" then
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(target, 38, 256)

        if choice == 1 then
            damage = math.floor(((((0 - math.abs(targetchoiceX)) + 277) / 4) * (player_stats[8] + 1)) / (enemy1_stats[4] + 1))
        elseif choice == 2 then
            damage = math.floor(((((0 - math.abs(targetchoiceX)) + 277) / 4) * (player_stats[8] + 1)) / (enemy2_stats[4] + 1))
        elseif choice == 3 then
            damage = math.floor(((((0 - math.abs(targetchoiceX)) + 277) / 4) * (player_stats[8] + 1)) / (enemy3_stats[4] + 1))
        end

        love.graphics.setColor(1, 1, 1, 1)

        if showtargetchoice == true then
            love.graphics.draw(targetchoice[math.floor(tcFrame)], targetchoiceX + 312, 256)
        end

        if (randomPos == 0 and movetarget == true) then
            targetchoiceX = targetchoiceX + 12 * love.timer.getDelta() * 30
        elseif movetarget == true then
            targetchoiceX = targetchoiceX - 12 * love.timer.getDelta() * 30
        end

        function love.keypressed(key, scancode, isrepeat)
            if ((key == "z" or key == "return") and soulState == "target") then
                show_slice = true
                movetarget = false
            end
        end

        if (targetchoiceX > 275 or targetchoiceX < -274) then
            movetarget = false
            showtargetchoice = false
            love.graphics.setFont(damageFont)
            love.graphics.setColor(.75, .75, .75)
            love.graphics.print("MISS", 240, 50)
        end

        if show_slice == true then
            if choice == 1 then
                love.graphics.draw(sliceSprite[sliceframe], 230, 110)
            elseif choice == 2 then
                love.graphics.draw(sliceSprite[sliceframe], 385, 110)
            elseif choice == 3 then
                -- there is no 3rd enemy but you just change it to your monster's x and y and stuff
            end
            
            sliceAnimTimer = sliceAnimTimer + love.timer.getDelta()
            
            if sliceAnimTimer > .1 and sliceframe < 6 then
                sliceAnimTimer = 0
                sliceframe = sliceframe + 1
            elseif sliceAnimTimer > .1 and sliceframe == 6 then
                show_slice = false
            end
        end
    end
end