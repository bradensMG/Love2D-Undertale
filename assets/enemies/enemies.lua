-- setup
enemy1_setup = {
    x = 175,
    y = 30,
    image = love.graphics.newImage('assets/enemies/images/test1.png'),
    name = 'Monster 1',
    def = 1,
    atk = 1,
    check_msg = "/f/w* A big heart and a big build./s/s/s/s/s/n* Please be gentle with it.",
    can_spare = true,
    status = "alive"
}

enemy2_setup = {
    x = 350,
    y = 196,
    image = love.graphics.newImage('assets/enemies/images/test2.png'),
    name = 'Monster 2',
    def = 5,
    atk = 2,
    check_msg = "/f/w* He's as heavy as a rock./s/s/s/s/s/n* Just as strong as one, too.",
    can_spare = false,
    status = "alive"
}

function draw_enemies()
    if enemy1_setup.status == "alive" then
        love.graphics.setColor(1, 1, 1)
    else
        love.graphics.setColor(1, 1, 1, .5)
    end

    if enemy1_setup.status ~= "dead" then
        love.graphics.draw(enemy1_setup.image, enemy1_setup.x, enemy1_setup.y)
    end

    if enemy2_setup.status == "alive" then
        love.graphics.setColor(1, 1, 1)
    else
        love.graphics.setColor(1, 1, 1, .5)
    end

    if enemy2_setup.status ~= "dead" then
        love.graphics.draw(enemy2_setup.image, enemy2_setup.x, enemy2_setup.y)
    end
end

function enemies_attack()
    if attack_timer == 10 then
        create_bullet(0, 275, 5, 0)
    end
    if attack_timer == 15 then
        create_bullet(0, 275, 10, 0)
    end
end

-- acts

enemy1_acts = {
    "Check"
}

enemy2_acts = {
    "Check"
}

enemies = {
    amount = 2,
    encounter_text = "/f/w* /cTest Monster /wand its /ycohort/n  /wdraw near!",
    start_first = false,
    can_flee = true
}