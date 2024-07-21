-- update --

game_functions = require "functions"

local update = {}

function update.update_start()
    if (love.keyboard.isDown("space")) then
        game_state = "game"
    end
end

function update.update_game(time_var)
    game_functions.screenMode()

    -- move stars
    game_functions.move_stars(time_var)

    -- input move keys
    ship.x_axis = (love.keyboard.isDown('a')) and -1 or (love.keyboard.isDown('d')) and 1 or 0
    ship.y_axis = (love.keyboard.isDown('w')) and -1 or (love.keyboard.isDown('s')) and 1 or 0
    
    -- magnitude move
    ship.vector_magn = math.sqrt(ship.x_axis^2 + ship.y_axis^2)
    
    -- ship magnitude move apply
    if ship.vector_magn > 0 then
        ship.x_axis = ship.x_axis / ship.vector_magn
        ship.y_axis = ship.y_axis / ship.vector_magn
    end

    -- ship move apply
    ship.x = ship.x + (ship.x_axis * ship.speed * time_var)
    ship.y = ship.y + (ship.y_axis * ship.speed * time_var)

    -- fire cooldown
    ship.fire_cooldown = (ship.fire_cooldown > 0) and ship.fire_cooldown - time_var or ship.fire_cooldown

    -- shoot
    if (ship.fire_cooldown <= 0 and love.keyboard.isDown('space')) then
        ship.fire_cooldown = 0.25 -- restart fire cooldown
        local newBullet = {x = ship.x + 24, y = ship.y - 10}
        table.insert(ship.bullets, newBullet) -- add the new bullet in game
        ship.sounds.shoot:stop()
        ship.sounds.shoot:play()
    end

    -- move bullets
    if (#ship.bullets > 0) then
        for i = #ship.bullets, 1, -1 do
            ship.bullets[i].y = ship.bullets[i].y - (ship.bullet_speed * time_var)

            -- delete bullets
            if (ship.bullets[i].y <= -16) then
                table.remove(ship.bullets, i)
                --break
            end
        end
    end

    rndTime = rndTime + time_var
    if (rndTime >= 3) then
        rndValue = math.random(1, 10)
        rndTime = 0
    end

    sinx = 700 + 100 * math.sin(love.timer.getTime() * 4)
    siny = 400 + 100 * math.sin(love.timer.getTime() * 4)
end

return update