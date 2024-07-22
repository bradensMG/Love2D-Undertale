tick = require "lib/tick"
screen = require "lib/shack"
attacks = require "scripts/attacks"

function preload()

    require("lib/writer")

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

function love.load(arg)
    preload()

    screen:setDimensions(640, 480)

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

    raw_attack_timer = 0

    arena = {
        x = 35,
        y = 253,
        width = 569,
        height = 134
    }

    box_x, box_y, box_width, box_height = 35, 253, 569, 134 -- starting positions of the box

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

function love.draw()
    screen:apply()

    love.graphics.setBackgroundColor(0, 0, 0)

    if game_state == 'encounter' then
        love.graphics.print(player.gravity, 4, 24)
        love.graphics.setBackgroundColor(0.15, 0.2, 0.25)
            
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
            if enemies.amount > 0 then love.graphics.print("  * " .. enemy1_setup.name, 52, 274) end
            if enemies.amount > 1 then love.graphics.print("  * " .. enemy2_setup.name, 52, 306) end
            if enemies.amount > 2 then love.graphics.print("  * " .. enemy3_setup.name, 52, 338) end
        end

        draw()

        love.graphics.setColor(1, 1, 1)
        love.graphics.setFont(fonts.dialogue)
        love.graphics.print("FPS: " .. math.floor(1 / love.timer.getDelta()), 4, 4)

        love.graphics.setColor(1, 1, 1, 1)
    end

    if game_state == 'game over' then
        love.graphics.setFont(love.graphics.newFont(12))
        love.graphics.print("you died but i havent coded a game over screen in yet\n\npress z to retry\npress x to exit", 20, 20)
    end

end

function love.update(dt)
    screen:update(dt)

    if game_state == 'encounter' then

        if render_text then
            upd()
        end

        if soul_state == "enemy turn" then
            update_bullets()
            raw_attack_timer = raw_attack_timer + tick.dt * 30
            attack_timer = math.floor(raw_attack_timer)
            enemies_attack()
        else
            raw_attack_timer = 0
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