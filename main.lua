-- main / init --

local game_functions = require "functions"
local update_module = require "update"
local draw_module = require "draw"

gameScale = 7
love.graphics.setDefaultFilter("nearest", "nearest")

function love.load()
    game_state = "start"

    -- load stars
    stars = {}
    game_functions.stars_generator()

    -- load ship
    ship = {
        sprites = {
            ship = {love.graphics.newImage("sprites/fighter0.png"), love.graphics.newImage("sprites/fighter1.png"), love.graphics.newImage("sprites/fighter2.png"), love.graphics.newImage("sprites/fighter3.png"), love.graphics.newImage("sprites/fighter4.png")},
            ship_frame = 3.5,

            bullet = love.graphics.newImage("sprites/bullet.png")
        },

        sounds = {shoot = love.audio.newSource("sounds/newShot", "static")},

        bullets = {},
        bullet_speed = 500,
        fire_cooldown = 0,

        actual_spr = 4.5,        
        flip = 1,
        flip_position = 0,

        x = (love.graphics.getWidth() / 2) - ((8 * gameScale) / 2),
        y = (love.graphics.getHeight() / 4) * 3,

        blaze_x = 0,
        blaze_y = 0,

        x_axis = 0,
        y_axis = 0,
        vector_magn = 0,

        speed = 250
    }

    rndTime = 0
    rndValue = math.random(1, 10)
end

function love.update(dt)
    if (game_state == "start") then
        update_module.update_start()
    else
        update_module.update_game(dt)
    end
end

function love.draw()
    if (game_state == "start") then
        draw_module.draw_start()
    else
        draw_module.draw_game()
    end
end