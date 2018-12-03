const http = require('http');
const version = '1.5';

const hostname = '0.0.0.0';
const port = 5000;

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end(
    JSON.stringify({
      data: 'welcome',
      version: version,
    })
  );
});

server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`)
})
