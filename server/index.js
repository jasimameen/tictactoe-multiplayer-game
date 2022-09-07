const express = require('express');
const http = require('http');
const mongoose = require('mongoose');

const app = express();
const port = process.env.PORT || 3000;
var server = http.createServer(app);
const Room = require('./models/room');

var io = require('socket.io')(server);

// middleWare
app.use(express.json());

const DB = "mongodb+srv://admin:admin@cluster0.q0okive.mongodb.net/?retryWrites=true&w=majority";

io.on('connection', (socket) => {
    console.log('Client connected.');

    socket.on('createRoom', async ({ nickname }) => {
        console.log('NickName: ', nickname, '\tSocketID: ', socket.id);

        try {
            // create and store the player in the romm
            let room = new Room();
            let player = {
                nickname,
                socketID: socket.id,
                playerType: 'X',
            };
            room.players.push(player);
            room.turn = player;
            // Save Data into MongoDB
            room = await room.save();
            const roomID = room._id.toString(); // id is generated from mongoDB

            console.log(room);

            socket.join(room);
            // io -> send data to everyone
            // socket -> send data self
            // 
            // send data to everyone in the romm
            io.to(room).emit('CreateRoomSuccess', room);

        } catch (err) {
            console.log(err);
        }

    });

    socket.on('joinRoom', async ({ nickname, roomId }) => {
        try {

            if (!roomId.match(/^[0-9a-fA-F]{24}$/)) {
                socket.emit('errorOccured', 'Plz Enter a valid RoomID.');
                return;
            }
            let room = await Room.findById(roomId);

            if (room.isJoin) {
                let player = {
                    nickname,
                    socketID: socket.id,
                    playerType: 'O'
                }

                socket.join(roomId);
                room.players.push(player);
                room.isJoin = false;
                room = await room.save();
                io.to(roomId).emit('joinRoomSuccess', room);
                io.emit('updatePlayers', room.players);
                io.emit('updateRoom', room);

            } else {
                socket.emit('errorOccured', 'No slots left for now in this Room. The game is in progress')
            }

        } catch (err) {
            console.log(err);
        }
    });

    socket.on('tap', async ({ index, roomId }) => {
        try {
            let room = await Room.findById(roomId);
            let choice = room.turn.playerType; // X or O
            if (room.turnIndex == 0) {
                room.turnIndex = 1;
                room.turn = room.players[1];
            } else {
                room.turnIndex = 0;
                room.turn = room.players[0];
            }
            await room.save();
            io.emit('tapped', {
                index,
                choice,
                room,
            });

        } catch (error) {
            console.log(error);
        }
    });

});

mongoose.connect(DB).then(() => {
    console.log("DB Connection Succesfull");
}).catch((e) => {
    console.log(e);
});

server.listen(port, '0.0.0.0', () => {
    console.log(`Server started and running on port ${port}`);
});