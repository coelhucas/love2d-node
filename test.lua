require 'love.timer'
require 'love.keyboard'

local host, port = 'localhost', 4000
local socket = require('socket')
local tcp = socket.tcp()
local utf8 = require("utf8")
local processing = true

tcp:connect(host, port)
tcp:send("hello there\n\r")



-- require(love.timer)
channel = love.thread.getChannel("request")
channel:push("connected")

repeat
  local answer, err = tcp:receive()

  if err then
    tcp:close()
    channel:push('disconnected')
    processing = false
  end

  if answer then
    -- print(answer)
    channel:push(answer)
    -- current_answer = answer
  end
  love.timer.sleep(0.003)
until not processing