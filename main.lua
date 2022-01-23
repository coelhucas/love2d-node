local host, port = 'localhost', 4000
local socket = require('socket')
local tcp = socket.tcp()
local utf8 = require("utf8")

status = "not connected"


current_answer = "Waiting for messages..."

-- tcp:connect(host, port)


-- tcp:send("hello there\n\r")
-- local answer = tcp:receive()
-- print(answer)

thread = love.thread.newThread("test.lua")
channel = love.thread.getChannel("request")

thread:start()

if tcp:getpeername() then
  status = "connected"
else
  -- print("not connected")
end
-- tcp:close()

function love.textinput(t)
  text = text .. t

  love.keyboard.setKeyRepeat(true)
end

function love.load()
  text = ""
end

function love.update(dt)
  -- local a = tcp:receive()
  data = channel:pop(a)

  if data then
    current_answer = data .. "\n" .. current_answer

  end
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
    -- tcp:send(text .. "\n\r")
    -- channel:set('msg', text)
    text = ""
    thread:start()
  end
end


function love.draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.print(current_answer, 10, 10)
  love.graphics.printf(text, 10, 30, love.graphics.getWidth())

  -- if status == "connected" then
  --   love.graphics.setColor(0, 1, 0)
  -- else
  --   love.graphics.setColor(1, 0, 0)
  -- end

  -- love.graphics.print(status, 10, 50)
end