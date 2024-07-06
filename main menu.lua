if gameState == "main menu" then
    function love.draw()
    love.graphics.setFont(dtm)
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.print("UNDERTALE Love Engine", 135, 25)

    love.graphics.setFont(dotumche)
    love.graphics.setColor(1, 1, 1, .5)

    love.graphics.print("Engine by sawby_. Original UNDERTALE by Toby Fox and Temmie Chang", 50, 460)

    love.graphics.setFont(dtm)

        if mainMenuState == "root" then
            if choice == 1 then
                love.graphics.setColor(1, 1, 0, 1)
            else
                love.graphics.setColor(1, 1, 1, 1)
            end
            love.graphics.print("Start", 50, 165)
            if choice == 2 then
                love.graphics.setColor(1, 1, 0, 1)
            else
                love.graphics.setColor(1, 1, 1, 1)
            end
            love.graphics.print("Options", 50, 215)
            if choice == 3 then
                love.graphics.setColor(1, 1, 0, 1)
            else
                love.graphics.setColor(1, 1, 1, 1)
            end
            love.graphics.print("Exit", 50, 265)
        elseif mainMenuState == "options" then
            if choice == 1 then
                love.graphics.setColor(1, 1, 0, 1)
            else
                love.graphics.setColor(1, 1, 1, 1)
            end
            love.graphics.print("Fullscreen", 50, 165)
            if choice == 2 then
                love.graphics.setColor(1, 1, 0, 1)
            else
                love.graphics.setColor(1, 1, 1, 1)
            end
            love.graphics.print("Volume", 50, 215)
            if choice == 3 then
                love.graphics.setColor(1, 1, 0, 1)
            else
                love.graphics.setColor(1, 1, 1, 1)
            end
            love.graphics.print("Framerate", 50, 265)
        end
    end

    function love.update()
        function love.keypressed(key, scancode, isrepeat)
            if gameState == "main menu" then
                if key == "down" then
                    love.audio.play(menumove)
                    choice = choice + 1
                    if choice == 4 then
                        choice = 1
                    end
                elseif key == "up" then
                    love.audio.play(menumove)
                    choice = choice - 1
                    if choice == 0 then
                        choice = 3
                    end
                elseif key == "z" then
                    if mainMenuState == "root" then
                        if choice == 1 then
                            gameState = "encounter"
                            require(gameState)
                            battleInit()
                        elseif choice == 2 then
                            choice = 1
                            mainMenuState = "options"
                        elseif choice == 3 then
                            love.event.quit()
                        end
                    end
                elseif key == "x" then
                    if mainMenuState == "options" then
                        choice = 2
                        mainMenuState = "root"
                    end
                end
            end
        end
    end
end