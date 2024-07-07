if gameState == "encounter" then
    function battleInit()
        monsterAnimFrame = 0

        froggithead = {}
        froggithead[0] = love.graphics.newImage("/assets/images/enemies/froggit/spr_froggithead_0.png")
        froggithead[1] = love.graphics.newImage("/assets/images/enemies/froggit/spr_froggithead_1.png")
        froggitlegs = {}
        froggitlegs[0] = love.graphics.newImage("/assets/images/enemies/froggit/spr_froggitlegs_0.png")
        froggitlegs[1] = love.graphics.newImage("/assets/images/enemies/froggit/spr_froggitlegs_1.png")
        whimsun = {}
        whimsun[0] = love.graphics.newImage("assets/images/enemies/whimsun/spr_whimsun_0.png")
        whimsun[1] = love.graphics.newImage("assets/images/enemies/whimsun/spr_whimsun_1.png")
        whimsunhurt = love.graphics.newImage("assets/images/enemies/whimsun/spr_whimsun_hurt.png")

        timeSinceLastKr = 0
        onButton = 1

        soulState = "buttons" -- i recommend either having this be "buttons" or "enemy turn dialogue"

        -- the first item is the encounter text. the rest are random text in the menu
        flavorText = {
            "* Froggit and Whimsun drew near!",
            "* Glad Dummy keeps smiling.",
            "* Dummy remains idle.",
            "* Pissed Dummy wants to be left\n  alone."
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
            love.graphics.draw(froggitlegs[math.floor((monsterAnimFrame * 2))], 200, 194)
            love.graphics.draw(froggithead[math.floor((monsterAnimFrame * 2))], 196, 134)

            time = love.timer.getTime()

            love.graphics.draw(whimsun[math.floor((monsterAnimFrame * 2))], 350, 134 + math.floor((math.sin(time * 2) * 10)))

            love.graphics.setColor(1, 1, 1, 1)
                
            ui()
            drawBox(box_x, box_y, box_width, box_height)
            soul()
                
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
        monsterAnimFrame = monsterAnimFrame + dt
        if monsterAnimFrame > 1 then
            monsterAnimFrame = 0
        end
        battlemus:setLooping(true)
        battlemus:play()
        if renderText == true then
            beginTextRender()
        end
    end
end