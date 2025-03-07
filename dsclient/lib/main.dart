// import 'package:dsclient/game_screen.dart';
// import 'package:dsclient/game_start.dart';
import 'package:flutter/material.dart';
import '../Contents/login_screen.dart';
//import 'package:flame/game.dart';

String lootUrl = 'http://127.0.0.1:5192/';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}

