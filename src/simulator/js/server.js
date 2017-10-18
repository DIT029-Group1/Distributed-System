var net = require('net'),
    http = require('http'),
	data = '';


net.createServer(function(socket) {
	socket.setEncoding('utf8');
	socket.on('data', function(chunk) {
		data += '<br>' + chunk;
	});
}).listen(8080, '127.0.0.1');


http.createServer(function (req, res) {
    res.writeHead(200, {
    	'Content-Type': 'text/html',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'GET, POST, OPTIONS, PUT, PATCH, DELETE',
        'Access-Control-Allow-Headers': 'X-Requested-With,content-type',
        'Access-Control-Allow-Credentials': 'true'
		});
	res.write(data);
	res.end();
}).listen(8080);
