// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mp_tictactoe/provider/room_data_providre.dart';
import 'package:provider/provider.dart';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _PlayerScores(
            nickname: roomDataProvider.player1.nickname,
            points: roomDataProvider.player1.points),
        _PlayerScores(
            nickname: roomDataProvider.player2.nickname,
            points: roomDataProvider.player2.points),
      ],
    );
  }
}

class _PlayerScores extends StatelessWidget {
  final String nickname;
  final int points;
  const _PlayerScores({
    Key? key,
    required this.nickname,
    required this.points,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            nickname,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            points.toString(),
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
