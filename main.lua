tick = require "lib/tick"

require("scripts/utils/textUtils")
require("/scripts/soul")
require("/scripts/ui")

local moonshine = require 'lib/moonshine'

globalVol = 1

function preload()
    -- fonts
    dtm = love.graphics.newFont("assets/fonts/determination-mono.ttf", 32)
    uiFont = love.graphics.newFont("assets/fonts/Mars_Needs_Cunnilingus.ttf", 23)
    dotumche = love.graphics.newFont("assets/fonts/undertale-dotumche.ttf", 12)

    -- images
    referenceImage = love.graphics.newImage("assets/images/ref.png")
    backgroundImage = love.graphics.newImage("assets/images/spr_battlebg_0.png")

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

    -- audio
    uifont = love.audio.newSource("assets/sound/sfx/Voices/uifont.wav", "static")
    battlemus = love.audio.newSource("assets/sound/mus/mus_battle2.ogg", "stream")

    menumove = love.audio.newSource("assets/sound/sfx/menumove.wav", "static")
    menuconfirm = love.audio.newSource("assets/sound/sfx/menuconfirm.wav", "static")
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

    tick.framerate = 30
    love.window.setMode("640", "480")
    love.window.setTitle("UNDERTALE")

    mainMenuState = "root"
    choice = 1

    gameState = "encounter"
    require(gameState)
    battleInit()
end