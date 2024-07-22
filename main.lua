tick = require "lib/tick"

function preload()

    require("lib/text")

    require("assets/enemies/enemies")
    
    require("/scripts/ui")
    require("/scripts/player")
    require("scripts/attacks")

    -- fonts
    fonts = {
        main = love.graphics.newFont("assets/fonts/determination-mono.ttf", 32),
        ui = love.graphics.newFont("assets/fonts/Mars_Needs_Cunnilingus.ttf", 23),
        dialogue = love.graphics.newFont("assets/fonts/undertale-dotumche.ttf", 12),
        damage = love.graphics.newFont("assets/fonts/attack.ttf", 24)
    }

    -- images
    reference_img = love.graphics.newImage("assets/images/ref.png")
    background_img = love.graphics.newImage("assets/images/spr_battlebg_0.png")

    button = {
        fight_unselected = love.graphics.newImage("/assets/images/ui/bt/fight0.png"),
        fight_selected = love.graphics.newImage("/assets/images/ui/bt/fight1.png"),
        act_unselected = love.graphics.newImage("/assets/images/ui/bt/act0.png"),
        act_selected = love.graphics.newImage("/assets/images/ui/bt/act1.png"),
        item_unselected = love.graphics.newImage("/assets/images/ui/bt/item0.png"),
        item_selected = love.graphics.newImage("/assets/images/ui/bt/item1.png"),
        mercy_unselected = love.graphics.newImage("/assets/images/ui/bt/mercy0.png"),
        mercy_selected = love.graphics.newImage("/assets/images/ui/bt/mercy1.png")
    }

    hp_name = love.graphics.newImage("/assets/images/ui/spr_hpname_0.png")
    kr = love.graphics.newImage("/assets/images/ui/spr_krmeter_0.png")

    bone = love.graphics.newImage("sprite.png")

    -- audio
    ui_font = love.audio.newSource("assets/sound/sfx/Voices/uifont.wav", "static")

    battle_mus = love.audio.newSource("assets/sound/mus/mus_battle2.ogg", "stream")

    menu_move = love.audio.newSource("assets/sound/sfx/menumove.wav", "static")
    menu_confirm = love.audio.newSource("assets/sound/sfx/menuconfirm.wav", "static")
end

function shake_screen(times, radius)
    local count = 0
    repeat
        x_rad = love.math.random(-radius, radius) 
        y_rad = love.math.random(-radius, radius)
        count = count + 1
    until count > times
end

function love.load(arg)
    preload()

    for _, font in pairs(fonts) do
        font:setFilter("nearest", "nearest")
    end

    love.graphics.setDefaultFilter("nearest", "nearest")

    love.graphics.setBackgroundColor(0, 0, 0, 1)

    tick.framerate = 30

    game_state = "encounter"
    battle_init()
end

function battle_init()
    kr_time_since = 0
    movement = 1

    box_x, box_y, box_width, box_height = 35, 253, 569, 134 -- starting positions of the box

    if enemies.start_first then
        on_button = 0
        soul_state = "enemy turn"
    else
        on_button = 1
        soul_state = "buttons"
        set_params(enemies.encounter_text, 52, 274, 2, fonts.main, 1 / 60, false, 'wave', ui_font)
        render_text = true
    end

    init_player()

    inv_frame_timer = player.inv_frames

    show_debug = true
end

function love.draw()
    love.graphics.setBackgroundColor(0, 0, 0)

    shake_screen(1, 1)
    love.graphics.translate(x_rad, y_rad)

    if game_state == 'encounter' then
        love.graphics.print(player.gravity, 4, 24)
        love.graphics.setBackgroundColor(0.15, 0.15, 0.15)
            
        -- love.graphics.draw(background_img)
            
        draw_hp_and_healthbar()
        draw_buttons()
        draw_box(box_x, box_y, box_width, box_height)
        draw_soul()
        draw_enemies()

        if soul_state == "enemy turn" then
            draw_attack()
        end

        if render_text then
            draw()     
        else
            prog_string = ""
        end

        if show_debug then
            love.graphics.setColor(1, 1, 1)
            love.graphics.setFont(fonts.dialogue)
            love.graphics.print("FPS: " .. math.floor(1 / love.timer.getDelta()), 4, 4)
        end

        love.graphics.setColor(1, 1, 1, 1)
    end

    if game_state == 'game over' then
        love.graphics.setFont(love.graphics.newFont(12))
        love.graphics.print("you died but i havent coded a game over screen in yet\n\npress z to retry\npress x to exit", 20, 20)
    end

end

function love.update(dt)

    if game_state == 'encounter' then
        if render_text then
            upd()
        end

        update_kr()
        update_inv_frames()

        love.audio.setVolume(1)

        battle_mus:setLooping(true)
        battle_mus:play()
    end

    if game_state == 'game over' then
        battle_mus:stop()
        if love.keyboard.isDown('z') then
            battle_init()
            game_state = 'encounter'
        elseif love.keyboard.isDown('x') then
            love.event.quit()
        end
    end

end