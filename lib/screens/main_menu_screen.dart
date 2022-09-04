import 'package:flutter/material.dart';
import 'package:mp_tictactoe/core/navigation.dart';
import 'package:mp_tictactoe/responsive/responsive.dart';
import 'package:mp_tictactoe/screens/create_room_screen.dart';
import 'package:mp_tictactoe/screens/join_room_screen.dart';
import 'package:mp_tictactoe/widgets/custom_button.dart';

class MainMenuScreen extends StatelessWidget {
  static const String routeName =
      '/main-menu'; // acces main menu screen with routeName
  const MainMenuScreen({super.key});

  void createRoom() => Navigation.pushNamed(CreateRoomScreen.routeName);
  void joinroom() => Navigation.pushNamed(JoinRoomScreen.routeName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(onTap: createRoom, text: 'Create Room'),
            const SizedBox(height: 20),
            CustomButton(onTap: joinroom, text: 'Join Room'),
          ],
        ),
      ),
    );
  }
}
