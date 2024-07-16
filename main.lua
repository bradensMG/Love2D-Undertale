tick = require "lib/tick"

function preload()

    require("scripts/text")
    
    require("/scripts/substates/uiSubstate")
    require("/scripts/substates/playerSubstate")
    require("scripts/substates/attackSubstate")

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

    for _, font in pairs(fonts) do
        font:setFilter("nearest", "nearest")
    end

    love.graphics.setDefaultFilter("nearest", "nearest")

    love.graphics.setBackgroundColor(0, 0, 0, 1)

    tick.framerate = 30

    game_state = "encounter"
    require('scripts/' .. game_state .. 'State')
    battle_init()
end