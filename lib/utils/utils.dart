import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mp_tictactoe/resources/game_methods.dart';
import '../core/navigation.dart';

void showSnackBar(String msg) {
  ScaffoldMessenger.of(Navigation.currentStateContext)
      .showSnackBar(SnackBar(content: Text(msg)));
}

void showGameDialog(String text, {String? actionText}) {
  showCupertinoDialog(
    barrierDismissible: false,
    context: Navigation.currentStateContext,
    builder: (context) => CupertinoAlertDialog(
      title: Text(text),
      actions: [
        TextButton(
          onPressed: () {
            GameMethods().clearBoard();
            Navigation.pop();
          },
          child: Text(actionText ?? 'Start NextRound'),
        )
      ],
    ),
  );
}
