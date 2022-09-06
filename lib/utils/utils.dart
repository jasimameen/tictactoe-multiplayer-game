import 'package:flutter/material.dart';
import 'package:mp_tictactoe/core/navigation.dart';

void showSnackBar(String msg) {
  ScaffoldMessenger.of(Navigation.currentStateContext)
      .showSnackBar(SnackBar(content: Text(msg)));
}
