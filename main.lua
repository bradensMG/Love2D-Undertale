tick = require "lib/tick"

require("scripts/utils/textUtils")
require("/scripts/soul")
require("/scripts/ui")
require("/scripts/atkUi")

globalVol = 1


function preload()
    -- fonts
    dtm = love.graphics.newFont("assets/fonts/determination-mono.ttf", 32)
    uiFont = love.graphics.newFont("assets/fonts/Mars_Needs_Cunnilingus.ttf", 23)
    dotumche = love.graphics.newFont("assets/fonts/undertale-dotumche.ttf", 12)
    damageFont = love.graphics.newFont("assets/fonts/attack.ttf", 24)

    -- images
    referenceImage = love.graphics.newImage("assets/images/ref.png")
    backgroundImage = love.graphics.newImage("assets/images/spr_battlebg_0.png")

    target = love.graphics.newImage("assets/images/spr_target_0.png")

    targetchoice = {}
    targetchoice[0] = love.graphics.newImage("assets/images/spr_targetchoice_0.png")
    targetchoice[1] = love.graphics.newImage("assets/images/spr_targetchoice_1.png")

    sliceSprite = {}
    sliceSprite[1] = love.graphics.newImage("assets/images/ui/slice/spr_slice_o_0.png")
    sliceSprite[2] = love.graphics.newImage("assets/images/ui/slice/spr_slice_o_1.png")
    sliceSprite[3] = love.graphics.newImage("assets/images/ui/slice/spr_slice_o_2.png")
    sliceSprite[4] = love.graphics.newImage("assets/images/ui/slice/spr_slice_o_3.png")
    sliceSprite[5] = love.graphics.newImage("assets/images/ui/slice/spr_slice_o_4.png")
    sliceSprite[6] = love.graphics.newImage("assets/images/ui/slice/spr_slice_o_5.png")

    fightUnselected = love.graphics.newImage("/assets/images/ui/bt/fight0.png")
    fightSelected = love.graphics.newImage("/assets/images/ui/bt/fight1.png")
    actUnselected = love.graphics.newImage("/assets/images/ui/bt/act0.png")
    actSelected = love.graphics.newImage("/assets/images/ui/bt/act1.png")
    itemUnselected = love.graphics.newImage("/assets/images/ui/bt/item0.png")
    itemSelected = love.graphics.newImage("/assets/images/ui/bt/item1.png")
    mercyUnselected = love.graphics.newImage("/assets/images/ui/bt/mercy0.png")
    mercySelected = love.graphics.newImage("/assets/images/ui/bt/mercy1.png")

    hpName = love.graphics.newImage("/assets/images/ui/spr_hpname_0.png")
    kr = love.graphics.newImage("/assets/images/ui/spr_krmeter_0.png")

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

    -- audio
    uifont = love.audio.newSource("assets/sound/sfx/Voices/uifont.wav", "static")

    battlemus = love.audio.newSource("assets/sound/mus/mus_battle2.ogg", "stream")

    menumove = love.audio.newSource("assets/sound/sfx/menumove.wav", "static")
    menuconfirm = love.audio.newSource("assets/sound/sfx/menuconfirm.wav", "static")
    hitsound = love.audio.newSource("assets/sound/sfx/hitsound.wav", "static")
    slice = love.audio.newSource("assets/sound/sfx/slice.wav", "static")
end

function setTextPerimeters(stringAwesome, xAwesome, yAwesome, fontAwesome, isInstantAwesome)
    timeSince = 0
    i = 1
    string = stringAwesome
    progString = ""
    interval = 1 / 60
    x = xAwesome
    y = yAwesome
    font = fontAwesome
    isInstant = isInstantAwesome
end

function love.load(arg)
    preload()

    love.graphics.setBackgroundColor(0, 0, 0, 1)

    tick.framerate = 60
    love.window.setMode("640", "480")
    love.window.setTitle("UNDERTALE")

    gameState = "encounter"
    require(gameState)
    battleInit()
end