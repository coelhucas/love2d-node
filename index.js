const net = require("net");

const server = net.createServer(socket => {
  socket.on("error", (e) => {
    console.log(e);
  })

  socket.on("data", data => {
    console.log("Received message from Love2D: " + data);
    
    socket.write("Message received\n", "utf8");
  });

  socket.on("close", (e) => {
    if (e) {
      console.error("Connection closed with error")
    }
    else {
      console.log("Connection closed")
    }
    socket.end()
  })
})

server.on("connection", socket => {
  console.log("Started new connection");
  let updates = 0;

  const process = setInterval(() => {
    // We don"t need to keep sending messages after the connection is closed
    if (socket.destroyed) {
      clearInterval(process);
      return;
    }
      const example = {
        text: `Sent ${updates} update(s)`
      }
      socket.write(`${JSON.stringify(example)}\n`, "utf8");
    
      updates++;
  }, 100);
});

server.listen(4000, "localhost");