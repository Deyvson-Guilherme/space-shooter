-- draw --

local draw = {}

function draw.draw_start()
    love.graphics.print("PRESS 'SPACE' TO START")
end

function draw.draw_game()
    -------- BACKGROUND --------

    love.graphics.setColor(0/255, 0/255, 0/255) -- set background color
    love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight()) -- draw background
    love.graphics.setColor(255, 255, 255) -- set normal game color

    -------- STARS --------
    for i = 1, #stars do
        love.graphics.setColor(stars[i].r/255, stars[i].g/255, stars[i].b/255) -- paint only the star color
        love.graphics.rectangle ('fill', stars[i].x, stars[i].y, 5, 5) -- draw star
        love.graphics.setColor(255/255, 255/255, 255/255) -- reset game color
    end

    -------- SHIP --------
    -- try centralize
    if (ship.sprites.ship_frame < 3.5) then
        ship.sprites.ship_frame = ship.sprites.ship_frame + 0.2

    elseif (ship.sprites.ship_frame > 3.5) then
        ship.sprites.ship_frame = ship.sprites.ship_frame - 0.2

    elseif (ship.sprites.ship_frame == 3.5) then
        ship.sprites.ship_frame = ship.sprites.ship_frame
    end
    
    -- turn ship animation
    ship.sprites.ship_frame = (ship.sprites.ship_frame >= 1.5 and love.keyboard.isDown("a")) and ship.sprites.ship_frame - 0.4 or
                      (ship.sprites.ship_frame <= 5.5 and love.keyboard.isDown("d")) and ship.sprites.ship_frame + 0.4 or ship.sprites.ship_frame

    -- flip the ship                      
    ship.flip = (ship.sprites.ship_frame < 4) and -1 or 1

    -- fix the flipped ship position
    ship.flip_position = (ship.flip == -1) and ship.sprites.ship[1]:getWidth() * gameScale or 0

    -- draw ship
    love.graphics.draw(ship.sprites.ship[math.floor(ship.sprites.ship_frame)], ship.x, ship.y)
    -- ship colisor
    --love.graphics.rectangle('line', ship.x, ship.y, ship.sprites.ship[1]:getWidth(), ship.sprites.ship[1]:getHeight())

    -- draw bullets
    if (#ship.bullets > 0) then
        for i = #ship.bullets, 1, -1 do
            -- draw bullets
            --love.graphics.circle('line', ship.bullets[i].x, ship.bullets[i].y, 5)
            love.graphics.draw(ship.sprites.bullet, ship.bullets[i].x, ship.bullets[i].y)
            -- bullets colisor
            --love.graphics.rectangle('line', ship.bullets[i].x, ship.bullets[i].y, ship.sprites.bullet:getWidth(), ship.sprites.bullet:getHeight())
        end
    end

    -- sin logic
    love.graphics.rectangle('line', sinx, 300, 25, 25)
    love.graphics.rectangle('line', 700, siny, 25, 25)

    -- print game infos
    --[[love.graphics.print(" ship_x: " .. ship.x .. "\n" ..
                        " ship_y: " .. ship.y .. "\n" ..
                        " actual_spr: " .. ship.sprites.ship_frame .. "\n" ..
                        " f_cooldown: " .. ship.fire_cooldown .. "\n" ..
                        " bullets: " .. #ship.bullets .. "\n" ..
                        " stars: " .. #stars .. "\n"..
                        " rndTime: " .. rndTime .. "\n" ..
                        " rndValue: " .. rndValue)]]--
end

return draw