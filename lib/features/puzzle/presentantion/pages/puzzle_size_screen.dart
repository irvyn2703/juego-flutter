import 'package:flutter/material.dart';
import 'package:awesome_number_picker/awesome_number_picker.dart';
import '../widgets/board_widget.dart';

class PuzzleSizeScreen extends StatefulWidget {
  const PuzzleSizeScreen({super.key});

  @override
  State<PuzzleSizeScreen> createState() => _PuzzleSizeScreenState();
}

class _PuzzleSizeScreenState extends State<PuzzleSizeScreen> {
  int selectedSize = 3;

  @override
  Widget build(BuildContext context) {
    double sizeW = MediaQuery.of(context).size.width;
    double sizeH = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 4,
              child: Center(
                child: Text(
                  'Selecciona el tamaño del tablero',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),

            Expanded(
              flex: 2,
              child: SizedBox(
                height: 150,
                child: IntegerNumberPicker(
                  otherItemsTextStyle: TextStyle(
                    fontSize: 40,
                    color: const Color.fromARGB(255, 247, 251, 254),
                  ),
                  pickedItemTextStyle: TextStyle(
                    fontSize: 40,
                    color: const Color.fromARGB(255, 54, 54, 54),
                  ),
                  initialValue: selectedSize,
                  minValue: 3,
                  maxValue: 8,
                  size: 100,
                  axis: Axis.horizontal,
                  pickedItemDecoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 247, 251, 254),
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  otherItemsDecoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 61, 61, 61),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  onChanged: (value) {
                    setState(() {
                      selectedSize = value;
                    });
                  },
                ),
              ),
            ),

            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  '${selectedSize}x$selectedSize',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),

            Expanded(
              flex: 1,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BoardScreen(size: selectedSize),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 46, 116, 151),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 16,
                  ),
                ),
                child: const Text(
                  'START',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),

            Expanded(
              flex: 4,
              child: Center(
                child: SizedBox(
                  height: 200,
                  child: Image.asset(
                    "images/evilRabbit.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
