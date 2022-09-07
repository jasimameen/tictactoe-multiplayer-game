import 'package:flutter/material.dart';
import '../core/navigation.dart';

void showSnackBar(String msg) {
  ScaffoldMessenger.of(Navigation.currentStateContext)
      .showSnackBar(SnackBar(content: Text(msg)));
}
