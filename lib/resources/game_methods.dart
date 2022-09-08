import 'package:flutter/material.dart';
import 'package:mp_tictactoe/core/navigation.dart';
import 'package:mp_tictactoe/models/player.dart';
import 'package:mp_tictactoe/provider/room_data_providre.dart';
import 'package:mp_tictactoe/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

class GameMethods {
  RoomDataProvider get _roomDataProvider =>
      Provider.of<RoomDataProvider>(Navigation.currentStateContext,
          listen: false);

  String winner = '';
  void checkWinner(Socket SocketClient) {
    bool isWin =
        // Rows
        winOrNot(0, 1, 2) ||
            winOrNot(3, 4, 5) ||
            winOrNot(6, 7, 8) ||
            // Column
            winOrNot(0, 3, 6) ||
            winOrNot(1, 4, 7) ||
            winOrNot(2, 5, 8) ||
            // Cross
            winOrNot(0, 4, 8) ||
            winOrNot(2, 4, 6);

    if (winner.isNotEmpty) {
      print('\n-----------\n\n');
      print(
          'player1 ${_roomDataProvider.player1.nickname} ${_roomDataProvider.player1.playerType}');
      print(
          'player2 ${_roomDataProvider.player2.nickname} ${_roomDataProvider.player2.playerType}');
      print('Winner = $winner');
      print('\n\n----------\n');
      if (_roomDataProvider.player1.playerType == winner) {
        Player player1 = _roomDataProvider.player1;
        // Player1 Won
        showGameDialog('${player1.nickname} WON');
        SocketClient.emit('winner', {
          'winnerSocketId': player1.socketID,
          'roomId': _roomDataProvider.roomData['_id']
        });
      } else {
        Player player2 = _roomDataProvider.player2;

        // Player2 Won
        showGameDialog('${player2.nickname} WON');
        SocketClient.emit('winner', {
          'winnerSocketId': player2.socketID,
          'roomId': _roomDataProvider.roomData['_id']
        });
      }
    } else if (_roomDataProvider.filledBoxes == 9) {
      winner = '';
      // display Game Dialog Saying Draw
      showGameDialog('GAME OVER\nIt\'s a DRAW');
    }
  }

  void clearBoard() {
    for (int i = 0; i < _roomDataProvider.displayElements.length; i++) {
      _roomDataProvider.updateDisplayElements(i, '');
    }
    _roomDataProvider.resetFilledBoxes();
  }

  // Helpers Funtions
  bool winOrNot(int idx1, int idx2, int idx3) {
    if (_roomDataProvider.displayElements[idx1] != '' &&
        _roomDataProvider.displayElements[idx1] ==
            _roomDataProvider.displayElements[idx2] &&
        _roomDataProvider.displayElements[idx1] ==
            _roomDataProvider.displayElements[idx3]) {
      winner = _roomDataProvider.displayElements[idx1];
      return true;
    }
    return false;
  }
}
