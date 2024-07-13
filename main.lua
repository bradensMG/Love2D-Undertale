tick = require "lib/tick"

require("scripts/utils/text_utils")
require("/scripts/soul")
require("/scripts/ui")

function preload()
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

    -- audio
    ui_font = love.audio.newSource("assets/sound/sfx/Voices/uifont.wav", "static")

    battle_mus = love.audio.newSource("assets/sound/mus/mus_battle2.ogg", "stream")

    menu_move = love.audio.newSource("assets/sound/sfx/menumove.wav", "static")
    menu_confirm = love.audio.newSource("assets/sound/sfx/menuconfirm.wav", "static")
end

function set_text_params(my_string, my_x, my_y, my_font, my_mode, my_interval)
    time_since = 0
    i = 1
    string = my_string
    prog_string = ""
    interval = my_interval
    x = my_x
    y = my_y
    font = my_font
    is_instant = my_mode
end

function hurt_player()
    player.hp = player.hp - 1
    if player_stats[5] == true then
        if player.hp > 1 then
            player.amt_of_kr = player.amt_of_kr + 1
        else
            player.amt_of_kr = player.amt_of_kr - 1
        end
    end
end

function love.load(arg)
    preload()

    love.graphics.setBackgroundColor(0, 0, 0, 1)

    tick.framerate = 60
    love.window.setMode("640", "480")
    love.window.setTitle("UNDERTALE")

    game_state = "encounter"
    require(game_state)
    battle_init()
end