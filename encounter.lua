if gameState == "encounter" then
    function battleInit()
        froggit_x_offset = 0
        froggit_y_offset = 0
        whimsun_x_offset = 0
        whimsun_y_offset = 0

        monsterAnimFrame = 0
        tcFrame = 0

        timeSinceLastKr = 0
        onButton = 1

        soulState = "buttons" -- i recommend either having this be "buttons" or "enemy turn dialogue"

        -- the first item is the encounter text. the rest are random text in the menu
        flavorText = {
            "* Froggit and Whimsun drew near!",
            "* The battlefield is filled with\n  the smell of mustard seed.",
            "* Whimsun avoids eye contact."
        }

        setTextPerimeters(flavorText[1], 52, 274, dtm, false)
        renderText = true

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
        amount_of_enemies = 2 -- if changed, you can delete the lists of enemies you don't need
        enemy1_stats = {
            "Froggit", -- name
            30, -- hp
            30, -- max
            4, -- def
            4, -- atk
            "Life is difficult for this enemy.", -- check msg
            "alive", -- state
            false -- can spare?
        }
        enemy2_stats = {
            "Whimsun", -- name
            10, -- hp
            10, -- max
            0, -- def
            4, -- atk
            "This monster is too sensitive to fight...", -- check msg
            "alive", -- state
            true -- can spare?
        }
    end

    function love.draw()
        love.graphics.setDefaultFilter("nearest", "nearest")

        if renderText == false then
            progString = ""
        end
        
            -- love.graphics.draw(referenceImage, 0, 0)
        love.graphics.draw(backgroundImage)

            -- love.graphics.setColor(255, 255, 255, .5)
        love.graphics.draw(froggitlegs[math.floor((monsterAnimFrame * 2))], 200 + froggit_x_offset, 194 + froggit_y_offset)
        love.graphics.draw(froggithead[math.floor((monsterAnimFrame * 2))], 196 + whimsun_x_offset, 134 + whimsun_y_offset)

        time = love.timer.getTime()

        love.graphics.draw(whimsun[math.floor((monsterAnimFrame * 2))], 350, 134 + math.floor((math.sin(time * 2) * 10)))

        love.graphics.setColor(1, 1, 1, 1)
                
        ui()
        drawBox(box_x, box_y, box_width, box_height)
        if soulState == "target" then
            love.graphics.draw(target, 38, 256)
        end
        if soulState == "target" then
            if choice == 1 then
                damage = math.floor(((((0 - math.abs(targetchoiceX)) + 277) / 4) * (player_stats[8] + 1)) / (enemy1_stats[4] + 1))
            elseif choice == 2 then
                damage = math.floor(((((0 - math.abs(targetchoiceX)) + 277) / 4) * (player_stats[8] + 1)) / (enemy2_stats[4] + 1))
            elseif choice == 3 then
                damage = math.floor(((((0 - math.abs(targetchoiceX)) + 277) / 4) * (player_stats[8] + 1)) / (enemy3_stats[4] + 1))
            end
            love.graphics.setFont(damageFont)
            love.graphics.setColor(1, 0, 0, 1)
            love.graphics.print(damage, 20, 20)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.draw(targetchoice[math.floor(tcFrame)], targetchoiceX + 312, 256)
            if (randomPos == 0 and movetarget == true) then
                targetchoiceX = targetchoiceX + 12
            elseif movetarget == true then
                targetchoiceX = targetchoiceX - 12
            end
            function love.keypressed(key, scancode, isrepeat)
                if ((key == "z" or key == "return") and soulState == "target") then
                    movetarget = false
                end
            end
            if (targetchoiceX > 275 or targetchoiceX < -274) then
                movetarget = false
                damage = "miss"
            end
        end       
        soul()

        love.graphics.setColor(1, 1, 1, 1)
            
        love.graphics.setFont(dtm)
        love.graphics.print(progString, x, y)
        if soulState == "choose enemy" then
            love.graphics.setFont(dtm)
            if amount_of_enemies > 0 then
                if enemy1_stats[7] == "alive" then
                    love.graphics.setColor(255, 0, 0, 1)
                    love.graphics.rectangle('fill', 140 + (#enemy1_stats[1] * 18), 280, 125, 17)
                    love.graphics.setColor(0, 255, 0, 1)
                    love.graphics.rectangle('fill', 140 + (#enemy1_stats[1] * 18), 280, enemy1_stats[2] / enemy1_stats[3] * 125, 17)
                        
                    if enemy1_stats[8] == true then
                        love.graphics.setColor(1, 1, 0, 1)
                    else
                        love.graphics.setColor(1, 1, 1, 1)
                    end
                else
                    love.graphics.setColor(1, 1, 1, .5)
                end
                love.graphics.print("* " .. enemy1_stats[1], 80, 274)

            end
            if amount_of_enemies > 1 then
                if enemy2_stats[7] == "alive" then
                    love.graphics.setColor(255, 0, 0, 1)
                    love.graphics.rectangle('fill', 140 + (#enemy2_stats[1] * 18), 312, 125, 17)
                    love.graphics.setColor(0, 255, 0, 1)
                    love.graphics.rectangle('fill', 140 + (#enemy2_stats[1] * 18), 312, enemy2_stats[2] / enemy2_stats[3] * 125, 17)

                    if enemy2_stats[8] == true then
                        love.graphics.setColor(1, 1, 0, 1)
                    else
                        love.graphics.setColor(1, 1, 1, 1)
                    end
                else
                    love.graphics.setColor(1, 1, 1, .5)
                end
                    love.graphics.print("* " .. enemy2_stats[1], 80, 306)

            end
            if amount_of_enemies > 2 then
                if enemy3_stats[7] == "alive" then
                    love.graphics.setColor(255, 0, 0, 1)
                    love.graphics.rectangle('fill', 140 + (#enemy3_stats[1] * 18), 344, 125, 17)
                    love.graphics.setColor(0, 255, 0, 1)
                    love.graphics.rectangle('fill', 140 + (#enemy3_stats[1] * 18), 344, enemy3_stats[2] / enemy3_stats[3] * 125, 17)

                    if enemy3_stats[8] == true then
                        love.graphics.setColor(1, 1, 0, 1)
                    else
                        love.graphics.setColor(1, 1, 1, 1)
                    end
                else
                    love.graphics.setColor(1, 1, 1, .5)
                end
                love.graphics.print("* " .. enemy3_stats[1], 80, 338)
            end
            love.graphics.setColor(1, 1, 1, 1)
        end
    end

    function love.update(dt)
        love.audio.setVolume(0.1)
        monsterAnimFrame = monsterAnimFrame + dt
        if monsterAnimFrame > 1 then
            monsterAnimFrame = 0
        end
        tcFrame = tcFrame + (dt * 10)
        if tcFrame > 2 then
            tcFrame = 0
        end
        battlemus:setLooping(true)
        battlemus:play()
        if renderText == true then
            beginTextRender()
        end
    end
end