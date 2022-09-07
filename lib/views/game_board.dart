import 'package:flutter/material.dart';
import 'package:mp_tictactoe/provider/room_data_providre.dart';
import 'package:mp_tictactoe/resources/socket_methods.dart';
import 'package:provider/provider.dart';

/// Tick-Tac-Toe 3 x 3 Game Board with 'X' and 'O'
class GameBoard extends StatefulWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.tappedListener(context);
  }

  @override
  void dispose() {
    super.dispose();
    _socketMethods.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: size.height * 0.7, maxWidth: 500),
      child: AbsorbPointer(
        absorbing: roomDataProvider.roomData['turn']['socketID'] !=
            _socketMethods.socket.id,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemBuilder: (context, index) {
            String fieldLabel = roomDataProvider.displayElements[index];
            Color shadowColor = fieldLabel == 'X' ? Colors.blue : Colors.red;

            return InkWell(
              onTap: () => cellTaped(index, roomDataProvider),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white24)),
                child: Center(
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 250),
                    child: Text(
                      fieldLabel,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 100,
                          shadows: [
                            Shadow(blurRadius: 40, color: shadowColor)
                          ]),
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: 9,
        ),
      ),
    );
  }

  cellTaped(int index, RoomDataProvider roomDataProvider) {
    _socketMethods.tapGrid(
      index,
      roomDataProvider.roomData['_id'],
      roomDataProvider.displayElements,
    );
  }
}
