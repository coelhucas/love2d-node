local socket = require('socket')
local tcp = socket.tcp()

local client = {}
local callback = nil
local process = true

function client:connect(host, port)
  status, err = tcp:connect(host, port)
  tcp:settimeout(0)
  return status, err
end

function client:update()
  if not process then return end
  data, err = tcp:receive()

  if data and not err and callback then
    callback(data)
  end

  if err == 'closed' then
    tcp:shutdown()
  end

end

function client:setCallback(cb)
  callback = cb
end

function client:send(data)
  tcp:send(data)
end

return client