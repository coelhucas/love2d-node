const net = require('net');

const server = net.createServer(socket => {
  socket.on('error', (er) => {
    console.log('error', er);
  })

  socket.on('data', data => {
    console.log("Message from LOVE2D: " + data);
    socket.write('Server received your msg ;)\n', 'utf8');
  });

  socket.on('close', (a) => {
    console.log('connection closed', a ? 'with error' : 'without error');
    socket.end()
  })
})

server.on('connection', socket => {
  console.log('started connection');
  let updates = 0;

  let batata = setInterval(() => {
    if (socket.destroyed) {
      clearInterval(batata);
      return;
    }
      const test = {
        text: `update number ${updates}`
      }
      socket.write(`${JSON.stringify(test)}\n`, 'utf8');
    updates++;
  }, 100);
});

server.listen(4000, 'localhost');