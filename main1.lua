
Class = require 'class'
push = require 'push'

require 'Ball'
require 'Paddle'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH =432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200


 

function love.load()

    math.randomseed(os.time() )
    love.graphics.setDefaultFilter('nearest','nearest')

    smallFont = love.graphics.newFont('font.ttf',32) 

    scoreFont = love.graphics.newFont('font.ttf',32) 


    love.graphics.setFont(scoreFont)
    if gameState == 'start' then

    elseif gameState =='play' then

    end


    player1Score = 0
    player2Score = 0

    paddle1 = Paddle(5, 20, 5, 20)
    paddle2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT -30, 5, 20)
    ball = Ball(VIRTUAL_WIDTH /2 -2, VIRTUAL_HEIGHT /2 -2, 5, 5)
  

    gameState = 'start'



   push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_WIDTH,{
       fullscreen = false,
       vsync = true,
       resizabble = false
    } )

end

function love.update(dt)

    paddle1:update(dt)
    paddle2:update(dt)

    -- player 1 movement
    if love.keyboard.isDown('w') then
        --add negative paddle speed to current Y scaled by deltaTime
        paddle1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
       paddle1.dy = PADDLE_SPEED
    
    else
        paddle1.dy = 0
    end

    -- player 2 movement
    if love.keyboard.isDown('up') then

        paddle2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
       paddle2.dy = PADDLE_SPEED

    else
        paddle2.dy = 0

    end

    if gameState == 'play' then
        ballX = ballX + ballDx * dt
        ballY = ballY + ballDy * dt
    end
     
end

function love.keypressed (key)
    if key == 'escape' then

    --terminate application
        love.event.quit()
    elseif key =='enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        else 
            gameState = 'start'
            ball:reset()     

               
        end

    end
end
        

function love.draw ()

    push:apply('start')

    love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)

   
    paddle1:render()
    paddle2:render()

    ball:render()
    love.graphics.rectangle('fill',VIRTUAL_WIDTH - 10, player2Y, 5, 20)


    if gameState == 'start' then

        love.graphics.printf("Hello Start State!", 0, 20, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'play' then
        love.graphics.printf("Hello Play State!", 0, 20, VIRTUAL_WIDTH, 'center')

    end
    love.graphics.setFont(scoreFont)
    love.graphics.print(player1Score, VIRTUAL_WIDTH /2 - 50, VIRTUAL_HEIGHT / 3 )
    love.graphics.print(player2Score, VIRTUAL_WIDTH /2 + 30, VIRTUAL_HEIGHT / 3 )

    push:apply('end')
end 