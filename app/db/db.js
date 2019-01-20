const http = require('http');
const os = require('os');
const bind = '0.0.0.0';
const port = process.argv[2] || 5001;
const data = 'data.json';
const fs = require('fs');

const version = '2.0';

if (!fs.existsSync(process.env.MOUNT + '/' + data)) {
  fs.writeFile(
    process.env.MOUNT + '/' + data,
    JSON.stringify({
      data: 0,
    }),
    function(err) {
      if(err) return console.log(err);
    }
  )
}

const server = http.createServer((req, res) => {
  console.log(
    JSON.stringify({
      url: req.url,
      method: req.method,
      headers: req.headers,
    })
  );

  res.setHeader('Content-Type', 'application/json');

  if (req.url == '/data' && req.method == 'POST') {
    let token = '';
    req.on('data', (chunk) => {
      token = JSON.parse(chunk).token;
      if (typeof process.env.TOKEN !== 'undefined' && token == process.env.TOKEN) {
        res.statusCode = 200;
        var content = fs.readFileSync(process.env.MOUNT + '/' + data)
        fs.writeFile(
          process.env.MOUNT + '/' + data,
          JSON.stringify({
            data: JSON.parse(content).data + 1,
          }),
          function(err) {
            if(err) return console.log(err);
          }
        );
        res.end(content);
      }
      else {
        res.statusCode = 401;
        res.end(JSON.stringify('Unauthorized'));
      }
    })
  }

  else {
    res.statusCode = 200;
    res.end(
      JSON.stringify({
        data: 'backend',
        version: version,
        build: process.argv[3],
        lang: 'js',
        hostname: os.hostname(),
      })
    )
  }
});

server.listen(port, bind, () => {
  console.log(`Server running at http://${bind}:${port}/`)
});
