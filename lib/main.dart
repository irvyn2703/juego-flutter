import 'package:flutter/material.dart';
import './screens/valide_question_screen.dart';

void main() {
  runApp(const LivenessTestApp());
}

class LivenessTestApp extends StatelessWidget {
  const LivenessTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rompecabezas Retro',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        useMaterial3: true,
        fontFamily: 'PressStart2P',
      ),
      home: const ValidateQuestionScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
