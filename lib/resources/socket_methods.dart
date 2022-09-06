import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mp_tictactoe/core/navigation.dart';
import 'package:mp_tictactoe/resources/socket_client.dart';
import 'package:mp_tictactoe/screens/game_screeen.dart';
import 'package:mp_tictactoe/utils/utils.dart';
import 'package:provider/provider.dart';

import '../provider/room_data_providre.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;

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

  // Listeners
  void createRoomSuccessListener() {
    _socketClient.on(
      'CreateRoomSuccess',
      (room) {
        Provider.of<RoomDataProvider>(
          Navigation.currentStateContext,
          listen: false,
        ).updateRoomData(room);
        Navigation.pushNamed(GameScreen.routeName);
      },
    );
  }

  void joinRoomSuccessListener() {
    _socketClient.on('joinRoomSuccess', (room) {
      Provider.of<RoomDataProvider>(
        Navigation.currentStateContext,
        listen: false,
      ).updateRoomData(room);
      Navigation.pushNamed(GameScreen.routeName);
    });
  }

  void updateRoomListener() {
    _socketClient.on('updateRoom', (room) {
      Provider.of<RoomDataProvider>(
        Navigation.currentStateContext,
        listen: false,
      ).updateRoomData(room);
    });
  }

  void errorOccuredListener() {
    _socketClient.on('errorOccured', (err) {
      showSnackBar(err);
    });
  }

  void updatePlayersStateListener() {
    _socketClient.on('updatePlayers', (playersData) {
      Provider.of<RoomDataProvider>(
        Navigation.currentStateContext,
        listen: false,
      ).updatePlayer1(playersData[0]);

      Provider.of<RoomDataProvider>(
        Navigation.currentStateContext,
        listen: false,
      ).updatePlayer2(playersData[1]);
    });
  }
}
