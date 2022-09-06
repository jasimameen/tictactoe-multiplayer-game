const mongoose = require('mongoose');

const playerScheme = mongoose.Schema({
    nickname: {
        type: String,
        // exclude all white spaces of the nickname
        trim: true,
    },
    socketID: {
        type: String,
    },
    points: {
        type: Number,
        default: 0,
    },
    playerType: {
        required: true,
        type: String,
    }
});

module.exports = playerScheme;