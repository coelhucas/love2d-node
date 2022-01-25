local host, port = 'localhost', 4000
local utf8 = require("utf8")
local socket = require 'sock'

status = 0 -- 0 = disconnected, 1 = connected

x = 0
y = 100

current_answer = "Waiting for messages..."

-- connectionThread:start()

function cb(data)
  current_answer = data .. '\n' .. current_answer
end

function love.textinput(t)
  text = text .. t

  love.keyboard.setKeyRepeat(true)
end

function love.load()
  text = ""
  socket:connect('localhost', 4000)
  socket:setCallback(cb)
end

function process_data(data) -- data: string
  current_answer = data .. '\n' .. current_answer

  if data == 'disconnected' then
    status = 0
    love.timer.sleep(1.5)
    return
  end
  if data == 'connected' then status = 1 end
end

function love.update(dt)
  x = x + 100 * dt

  if x > love.graphics.getWidth() then
    x = 0
  end

  socket:update()
end

function love.keypressed(key)
  if key == "backspace" then
      -- get the byte offset to the last UTF-8 character in the string.
      local byteoffset = utf8.offset(text, -1)

      if byteoffset then
          -- remove the last UTF-8 character.
          -- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do string.sub(text, 1, -2).
          text = string.sub(text, 1, byteoffset - 1)
      end
  end

  if key == "return" then
    socket:send(text)
    text = ""
  end
end


function love.draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.print(current_answer, 10, 10)
  love.graphics.printf(text, 10, 30, love.graphics.getWidth())

  love.graphics.circle('line', x, y, 10)

  if status == 1 then
    love.graphics.setColor(0, 1, 0)
  else
    love.graphics.setColor(1, 0, 0)
  end

  love.graphics.print(status == 1 and 'connected' or 'disconnected', love.graphics.getWidth() - 128, love.graphics.getHeight() - 64)
end