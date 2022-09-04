import 'package:flutter/material.dart';

/// Widget Used to Change Screens Without passing Build Context
///
///
/// {@tool snippet}
///
/// Typical usage for Navigating to another route is as follows:
///
/// ```dart
/// void gotTo2ndScreen(BuildContext context) {
///   Navigator.pushNamed(context, '/screen-2'); // passing build context is mandatory
/// }
/// ```
/// {@end-tool}
///
/// Use this instead:
///
/// ```dart
/// void gotTo2ndScreen() {
///   Navigation.pushNamed('/screen-2'); // No need for passing context
/// }
/// ```
class Navigation {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static BuildContext get context => navigatorKey.currentState!.context;

  static Future<T?> pushNamed<T extends Object?>(String routeName,
      {Object? arguments}) {
    return Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  static void pop<T extends Object?>([T? result]) =>
      Navigator.pop(context, result);
}
