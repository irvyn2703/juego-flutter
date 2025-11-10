import 'package:flutter/material.dart';
import '../widgets/board_widget.dart';

class ValidateQuestionScreen extends StatelessWidget {
  const ValidateQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'ROMBOPECABEZAS',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            shadows: [Shadow(color: Colors.white, blurRadius: 10)],
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: const BoardWidget(),
    );
  }
}
