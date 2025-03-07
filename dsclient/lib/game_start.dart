// import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'game_screen.dart';

class GameStartScreen extends StatelessWidget {
  const GameStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const GameScreen(),
              ),
            );
          },
          child: const Text('Start Game'),
        ),
      ),
    );
  }
}