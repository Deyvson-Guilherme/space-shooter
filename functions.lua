-- function --

-- generate stars
function stars_generator()
    for i = 1, 30 do
        local newStar = {}

        newStar.min_speed = 60
        newStar.max_speed = 220
        newStar.delta_speed = newStar.max_speed - newStar.min_speed
        newStar.speed_partition = newStar.delta_speed / 3

        newStar.x = math.random(1, love.graphics.getWidth())
        newStar.y = math.random(1, love.graphics.getHeight())

        newStar.speed = math.random(newStar.min_speed, newStar.max_speed)

        newStar.speed_meter = (newStar.speed >= newStar.min_speed and newStar.speed <= newStar.min_speed + newStar.speed_partition) and "slow" or
                              (newStar.speed >= newStar.min_speed + newStar.speed_partition and newStar.speed <= newStar.min_speed + 2 * newStar.speed_partition) and "quick" or
                              (newStar.speed >= newStar.min_speed + 2 * newStar.speed_partition and newStar.speed <= newStar.min_speed + 3 * newStar.speed_partition) and "fast"

        newStar.r = 0
        newStar.g = 0                 
        newStar.b = 0                             

        if (newStar.speed_meter == "slow") then
            newStar.r = 0  newStar.g = 0  newStar.b = 128
        elseif (newStar.speed_meter == "quick") then
            newStar.r = 128  newStar.g = 128  newStar.b = 128
        elseif (newStar.speed_meter == "fast") then
            --newStar.r = 255  newStar.g = 255  newStar.b = 255
            newStar.r = 29  newStar.g = 43  newStar.b = 83
        end

        table.insert(stars, newStar)
    end
end

-- move stars
function move_stars(time_var)
    for i = 1, #stars do
        stars[i].y = stars[i].y + (stars[i].speed * time_var)

        if (stars[i].y > (love.graphics.getHeight() + 16)) then
            stars[i].x = math.random(1, love.graphics.getWidth())
            stars[i].y = 0
        end
    end
end

-- change screen mode
function screenMode()
    screen_interval = (screen_interval > 0) and screen_interval - 0.07 or screen_interval

    if (screen_interval <= 0) then
        if (fullScreen == true and love.keyboard.isDown('f11')) then
            screen_interval = 0.5
            fullScreen = false
             
        elseif (fullScreen == false and love.keyboard.isDown('f11')) then
            screen_interval = 0.5
            fullScreen = true
        end
    end

    love.window.setFullscreen(fullScreen, "desktop")
end

return{
    stars_generator = stars_generator,
    move_stars = move_stars,
    screenMode = screenMode
}