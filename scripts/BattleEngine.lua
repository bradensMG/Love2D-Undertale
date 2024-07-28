function battle_init()
    kr_time_since = 0
    movement = 1

    raw_attack_timer = 0

    arena = {
        x = 35,
        y = 253,
        width = 569,
        height = 134
    }

    if enemies.start_first then
        on_button = 0
        soul_state = "enemy turn"
    else
        on_button = 1
        soul_state = "buttons"
        set_params(enemies.encounter_text, 52, 274, 2, fonts.main, 1 / 60, false, 'wave', ui_font, "")
        render_text = true
    end

    init_player()

    inv_frame_timer = player.inv_frames
end

function battleengine_run()
    if render_text then
        upd()
    end

    if soul_state == "enemy turn" then
        update_bullets()
        raw_attack_timer = raw_attack_timer + love.timer.getDelta() * tick.framerate
        attack_timer = math.floor(raw_attack_timer)
        enemies_attack()
    else
        raw_attack_timer = 0
    end

    update_kr()
    update_inv_frames()

    love.audio.setVolume(0.1)

    battle_mus:setLooping(true)
    battle_mus:play()
end

function battleengine_draw()
    love.graphics.print(player.gravity, 4, 24)
    -- love.graphics.setBackgroundColor(0.15, 0.2, 0.25)
        
    -- love.graphics.draw(background_img)
        
    draw_hp_and_healthbar()
    draw_buttons()
    draw_box(arena.x, arena.y, arena.width, arena.height)
    draw_soul()
    draw_enemies()

    if soul_state == "enemy turn" then
        draw_bullets()
        love.graphics.print(attack_timer, 0, 50)
    end

    if soul_state == "choose enemy" then
        render_text = false
        instance.prog_string = ""
        love.graphics.setFont(fonts.main)
        if enemies.amount > 0 then
            if enemy1_setup.can_spare then
                love.graphics.setColor(1, 1, 0, 1)
            else
                love.graphics.setColor(1, 1, 1, 1)
            end
            love.graphics.print("  * " .. enemy1_setup.name, 52, 274)
        end
        if enemies.amount > 1 then
            if enemy2_setup.can_spare then
                love.graphics.setColor(1, 1, 0, 1)
            else
                love.graphics.setColor(1, 1, 1, 1)
            end
            love.graphics.print("  * " .. enemy2_setup.name, 52, 306)
        end
        if enemies.amount > 2 then
            if enemy3_setup.can_spare then
                love.graphics.setColor(1, 1, 0, 1)
            else
                love.graphics.setColor(1, 1, 1, 1)
            end
            love.graphics.print("  * " .. enemy3_setup.name, 52, 338)
        end
    elseif soul_state == "act" then
        love.graphics.setFont(fonts.main)
        if chosen_enemy == 1 then
            if #enemy1_acts > 0 then love.graphics.print("  * " .. enemy1_acts[1], 52, 274) end
            if #enemy1_acts > 1 then love.graphics.print("  * " .. enemy1_acts[2], 288, 274) end
            if #enemy1_acts > 2 then love.graphics.print("  * " .. enemy1_acts[3], 52, 306) end
            if #enemy1_acts > 3 then love.graphics.print("  * " .. enemy1_acts[4], 288, 306) end
            if #enemy1_acts > 4 then love.graphics.print("  * " .. enemy1_acts[5], 52, 338) end
            if #enemy1_acts > 5 then love.graphics.print("  * " .. enemy1_acts[6], 288, 338) end
        elseif chosen_enemy == 2 then
            if #enemy2_acts > 0 then love.graphics.print("  * " .. enemy2_acts[1], 52, 274) end
            if #enemy2_acts > 1 then love.graphics.print("  * " .. enemy2_acts[2], 288, 274) end
            if #enemy2_acts > 2 then love.graphics.print("  * " .. enemy2_acts[3], 52, 306) end
            if #enemy2_acts > 3 then love.graphics.print("  * " .. enemy2_acts[4], 288, 306) end
            if #enemy2_acts > 4 then love.graphics.print("  * " .. enemy2_acts[5], 52, 338) end
            if #enemy2_acts > 5 then love.graphics.print("  * " .. enemy2_acts[6], 288, 338) end
        elseif chosen_enemy == 3 then
            if #enemy3_acts > 0 then love.graphics.print("  * " .. enemy3_acts[1], 52, 274) end
            if #enemy3_acts > 1 then love.graphics.print("  * " .. enemy3_acts[2], 288, 274) end
            if #enemy3_acts > 2 then love.graphics.print("  * " .. enemy3_acts[3], 52, 306) end
            if #enemy3_acts > 3 then love.graphics.print("  * " .. enemy3_acts[4], 288, 306) end
            if #enemy3_acts > 4 then love.graphics.print("  * " .. enemy3_acts[5], 52, 338) end
            if #enemy3_acts > 5 then love.graphics.print("  * " .. enemy3_acts[6], 288, 338) end
        end

    elseif soul_state == "items" then
        render_text = false
        instance.prog_string = ""
        love.graphics.setFont(fonts.main)
        if items_page == 1 then
            if #inventory > 0 then love.graphics.print("* " .. inventory[1], 100, 274) end
            if #inventory > 1 then love.graphics.print("* " .. inventory[2], 340, 274) end
            if #inventory > 2 then love.graphics.print("* " .. inventory[3], 100, 306) end
            if #inventory > 3 then love.graphics.print("* " .. inventory[4], 340, 306) end
            love.graphics.print("PAGE 1", 388, 338)
        elseif items_page == 2 then
            if #inventory > 4 then love.graphics.print("* " .. inventory[5], 100, 274) end
            if #inventory > 5 then love.graphics.print("* " .. inventory[6], 340, 274) end
            if #inventory > 6 then love.graphics.print("* " .. inventory[7], 100, 306) end
            if #inventory > 7 then love.graphics.print("* " .. inventory[8], 340, 306) end
            love.graphics.print("PAGE 2", 388, 338)
        else
            love.graphics.print("what", 52, 274)
        end
        -- love.graphics.setColor(1, 1, 1, .25)
        -- love.graphics.draw(refs.items, 0, 1, 0, .5)
    elseif soul_state == "mercy" then
        render_text = false
        instance.prog_string = ""
        love.graphics.setFont(fonts.main)
        if enemy1_setup.can_spare or enemy2_setup.can_spare or enemy3_setup.can_spare then
            love.graphics.setColor(1, 1, 0, 1)
        else
            love.graphics.setColor(1, 1, 1, 1)
        end
        love.graphics.print("  * Spare", 52, 274)
        love.graphics.setColor(1, 1, 1, 1)
        if enemies.can_flee then
            love.graphics.print("  * Flee", 52, 306)
        end
    end

    draw()

    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(fonts.dialogue)
    love.graphics.print("FPS: " .. math.floor(1 / love.timer.getDelta()), 4, 4)

    love.graphics.setColor(1, 1, 1, 1)
end