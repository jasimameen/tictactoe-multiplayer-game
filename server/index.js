const express = require('express');
const http = require('http');
const mongoose = require('mongoose');

const app = express();
const port = process.env.PORT || 3000;
var server = http.createServer(app);

var io = require('socket.io')(server);

// middleWare
app.use(express.json());

const DB = "mongodb+srv://admin:admin@cluster0.q0okive.mongodb.net/?retryWrites=true&w=majority";

io.on('connection', (socket) => {
    console.log('Socket Client connected.');
});

mongoose.connect(DB).then(() => {
    console.log("DB Connection Succesfull");
}).catch((e) => {
    console.log(e);
});

server.listen(port, '0.0.0.0', () => {
    console.log(`Server started and running on port ${port}`);
});