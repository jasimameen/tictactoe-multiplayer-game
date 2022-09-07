import 'package:flutter/material.dart';
import '../core/navigation.dart';
import '../responsive/responsive.dart';
import 'create_room_screen.dart';
import 'join_room_screen.dart';
import '../widgets/custom_button.dart';

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
