import 'package:flutter/material.dart';
import '../provider/room_data_providre.dart';
import '../widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class WaitingLobby extends StatefulWidget {
  const WaitingLobby({super.key});

  @override
  State<WaitingLobby> createState() => _WaitingLobbyState();
}

class _WaitingLobbyState extends State<WaitingLobby> {
  late TextEditingController roomIdontroller;

  @override
  void initState() {
    super.initState();
    roomIdontroller = TextEditingController(
        text: Provider.of<RoomDataProvider>(context, listen: false)
            .roomData['_id']);
  }

  @override
  void dispose() {
    super.dispose();
    roomIdontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Waiting for Other Player to Join...'),
        const SizedBox(height: 20),
        CustomTextField(
          controller: roomIdontroller,
          hintText: '',
          textAlign: TextAlign.center,
          isReadOnly: true,
        ),
      ],
    );
  }
}
