const mongoose = require('mongoose');
const playerScheme = require('./player');

const roomSchema = new mongoose.Schema({
    // occupancy is how long is the room  or How many Players can fit in this roomk
    occupancy: {
        type: Number,
        default: 2,
    },
    maxRounds: {
        type: Number,
        default: 6,
    },
    currentRound: {
        required: true,
        type: Number,
        default: 1,
    },
    // List of All Players and their data
    players: [playerScheme],
    isJoin: {
        type: Boolean,
        default: true,
    },
    // Identify whose turn is now
    turn: playerScheme,
    turnIndex: {
        type: Number,
        default: 0,
    }
});

const roomModel = mongoose.model('Room', roomSchema);
module.exports = roomModel;