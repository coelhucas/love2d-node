# Lua (LÖVE) <-> Node

## About
This is a sample of how to communicate between "pure" [node:net](https://nodejs.org/api/net.html) module and [Lua Socket](https://github.com/lunarmodules/luasocket) using LÖVE & lua socket.

Take a look at [sock.lua](./sock.lua) for the simple client abstraction, which IMO was the hardest to find online so I ended up digging the source and making it myself.

## Running
Server
```bash
node index.js
```

Client
```bash
love main.lua
```

## Acknowledgements
Thanks to [Diego Nehab](https://github.com/diegonehab) for the amazing work with lua socket and [Sasha Szpakowski](https://twitter.com/slime73) for creating our lovely LÖVE!
