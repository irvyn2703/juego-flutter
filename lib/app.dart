import 'package:flutter/material.dart';
import './features/puzzle/presentantion/pages/puzzle_size_screen.dart';

class Game extends StatelessWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        useMaterial3: true,
        fontFamily: 'PressStart2P',
      ),
      home: const PuzzleSizeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
