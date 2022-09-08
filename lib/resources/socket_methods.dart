import 'package:flutter/material.dart';
import 'package:mp_tictactoe/resources/game_methods.dart';
import '../core/navigation.dart';
import 'socket_client.dart';
import '../screens/game_screeen.dart';
import '../utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../provider/room_data_providre.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;

  Socket get socket => _socketClient;

  // Emits
  void createRoom(String nickname) {
    if (nickname.trim().isNotEmpty) {
      _socketClient.emit('createRoom', {'nickname': nickname});
    }
  }

  void joinRoom(String nickname, String roomId) {
    if (nickname.trim().isNotEmpty && roomId.trim().isNotEmpty) {
      _socketClient.emit('joinRoom', {
        'nickname': nickname,
        'roomId': roomId,
      });
    }
  }

  void tapGrid(int index, String roomId, List<String> displayElements) {
    if (displayElements[index] == '') {
      _socketClient.emit('tap', {
        'index': index,
        'roomId': roomId,
      });
    }
  }

  // Listeners
  void createRoomSuccessListener(BuildContext context) {
    _socketClient.on(
      'CreateRoomSuccess',
      (room) {
        Provider.of<RoomDataProvider>(
          context,
          listen: false,
        ).updateRoomData(room);
        Navigation.pushNamed(GameScreen.routeName);
      },
    );
  }

  void joinRoomSuccessListener(BuildContext context) {
    _socketClient.on('joinRoomSuccess', (room) {
      Provider.of<RoomDataProvider>(
        context,
        listen: false,
      ).updateRoomData(room);
      Navigation.pushNamed(GameScreen.routeName);
    });
  }

  void updateRoomListener(BuildContext context) {
    _socketClient.on('updateRoom', (room) {
      Provider.of<RoomDataProvider>(
        context,
        listen: false,
      ).updateRoomData(room);
    });
  }

  void errorOccuredListener() {
    _socketClient.on('errorOccured', (err) {
      showSnackBar(err);
    });
  }

  void updatePlayersStateListener(BuildContext context) {
    _socketClient.on('updatePlayers', (playersData) {
      Provider.of<RoomDataProvider>(
        context,
        listen: false,
      ).updatePlayer1(playersData[0]);

      Provider.of<RoomDataProvider>(
        context,
        listen: false,
      ).updatePlayer2(playersData[1]);
    });
  }

  void tappedListener(BuildContext context) {
    _socketClient.on('tapped', (data) {
      Provider.of<RoomDataProvider>(
        context,
        listen: false,
      ).updateDisplayElements(data['index'], data['choice']);

      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(data['room']);

      GameMethods().checkWinner(_socketClient);
    });
  }

  void updatePointListener(BuildContext context) {
    _socketClient.on('updatePoint', (playerData) {
      RoomDataProvider roomDataProvider =
          Provider.of<RoomDataProvider>(context, listen: false);
      if (playerData['socketID'] == roomDataProvider.player1.socketID) {
        roomDataProvider.updatePlayer1(playerData);
      } else {
        roomDataProvider.updatePlayer2(playerData);
      }
    });
  }

  void endGameListener(BuildContext context) {
    _socketClient.on('endGame', (playerData) {
      GameMethods().endGame(playerData['nickname']);
    });
  }

  // dispose socket client
  void dispose() => _socketClient.dispose();
}
