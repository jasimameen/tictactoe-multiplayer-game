import 'package:flutter/material.dart';
import 'package:mp_tictactoe/core/navigation.dart';
import 'package:mp_tictactoe/screens/main_menu_screen.dart';
import 'package:provider/provider.dart';

import '../provider/room_data_providre.dart';
import '../resources/socket_methods.dart';
import '../views/game_board.dart';
import '../views/score_board.dart';
import '../views/waiting_lobby.dart';

class GameScreen extends StatefulWidget {
  static String routeName = '/game';
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.updateRoomListener(context);
    _socketMethods.updatePlayersStateListener(context);
    _socketMethods.updatePointListener(context);
    _socketMethods.endGameListener(context);
  }

  @override
  void dispose() {
    super.dispose();
    _socketMethods.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigation.popUntil(MainMenuScreen.routeName);
      }),
      body: roomDataProvider.roomData['isJoin']
          ? const WaitingLobby()
          : SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Player Score Board
                  const ScoreBoard(),

                  // GameBoard
                  const GameBoard(),

                  // Turn Status
                  Text(
                    '${roomDataProvider.roomData['turn']['nickname']}\'s turn',
                  ),
                ],
              ),
            ),
    );
  }
}
