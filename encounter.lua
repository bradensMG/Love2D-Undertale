function battleInit()
    timeSinceLastKr = 0
    onButton = 1

    soulState = "buttons" -- i recommend either having this be "buttons" or enemy turn "dialogue"
    gameState = "encounter" -- only existing states are "death" and "encounter". any other states will make the game do nothing

    -- the first item is the encounter text. the rest are random text in the menu
    flavorText = {
        "* You enconter the Dummies.",
        "* Glad Dummy keeps smiling.",
        "* Dummy remains idle.",
        "* Pissed Dummy wants to be left\n  alone."
    }

    setTextPerimeters(flavorText[1], 52, 274, dtm, false)
    renderText = true

    box_x, box_y, box_width, box_height = 35, 253, 569, 134 -- starting positions of the box

    player_stats = {
        "sawby", -- name
        1, -- lv
        20, -- hp
        20, -- max hp
        false, -- has kr?
        0, -- amt of kr (don't change)
        0, -- def
        0 -- atk
    }
    amount_of_enemies = 3 -- if changed, you can delete the lists of enemies you don't need
    enemy1_stats = {
        "Glad Dummy", -- name
        10, -- hp
        10, -- max
        2, -- def
        10, -- atk
        "Glad to be here!", -- check msg
        "alive", -- state
        100, -- x
        136, -- y
        0, -- x offset
        0, -- y offset
        love.graphics.newImage("assets/images/enemies/spr_dummybattle_glad_0.png"), -- sprite
        true, -- can spare?
        false -- is spared?
    }
    enemy2_stats = {
        "Dummy", -- name
        10, -- hp
        10, -- max
        0, -- def
        0, -- atk
        "Indifferent. Won't attack.", -- check msg
        "alive", -- state
        250, -- x
        136, -- y
        0, -- x offset
        0, -- y offset
        love.graphics.newImage("assets/images/enemies/spr_dummybattle_0.png"), -- sprite
        false, -- can spare?
        false -- is spared?
    }
    enemy3_stats = {
        "Pissed Dummy", -- name
        100, -- hp
        100, -- max
        10, -- def
        5, -- atk
        "Hates being here. Wants to kill you.", -- check msg
        "alive", -- state
        400, -- x
        136, -- y
        0, -- x offset
        0, -- y offset
        love.graphics.newImage("assets/images/enemies/spr_dummybattle_angry.png"), -- sprite
        false, -- can spare?
        false -- is spared?
    }
end

function love.draw()
    effect(function()
        love.graphics.setDefaultFilter("nearest", "nearest")

        if renderText == false then
            progString = ""
        end
    
        -- love.graphics.draw(referenceImage, 0, 0)
        if gameState == "encounter" then
            love.graphics.draw(backgroundImage)

            -- love.graphics.setColor(255, 255, 255, .5)

            if amount_of_enemies > 0 then
                love.graphics.draw(enemy1_stats[12], enemy1_stats[8], enemy1_stats[9])
            end
            if amount_of_enemies > 1 then
                love.graphics.draw(enemy2_stats[12], enemy2_stats[8], enemy2_stats[9])
            end
            if amount_of_enemies > 2 then
                love.graphics.draw(enemy3_stats[12], enemy3_stats[8], enemy3_stats[9])
            end

            love.graphics.setColor(255, 255, 255, 1)
            
            ui()
            drawBox(box_x, box_y, box_width, box_height)
            soul()
            
            love.graphics.setFont(dtm)
            love.graphics.print(progString, x, y)
        end
        if soulState == "choose enemy" then
            love.graphics.setFont(dtm)
            if amount_of_enemies > 0 then
                if enemy1_stats[7] == "alive" then
                    if enemy1_stats[13] == true then
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
                    love.graphics.setColor(1, 1, 1, 1)
                else
                    love.graphics.setColor(1, 1, 1, .5)
                end
                love.graphics.print("* " .. enemy2_stats[1], 80, 274 + 32)
            end
            if amount_of_enemies > 2 then
                if enemy3_stats[7] == "alive" then
                    love.graphics.setColor(1, 1, 1, 1)
                else
                    love.graphics.setColor(1, 1, 1, .5)
                end
                love.graphics.print("* " .. enemy3_stats[1], 80, 274 + 64)
            end
        end
    end)
end

function love.update()
    love.audio.setVolume(0.5)
    if love.keyboard.isDown("n") then
        gameState = "none"
    end

    if love.keyboard.isDown("y") then
        gameState = "encounter"
        battleInit()
    end

    if gameState == "encounter" then
        battlemus:setLooping(true)
        battlemus:play()
        if renderText == true then
            beginTextRender()
        end
    else
        battlemus:stop()
    end
end