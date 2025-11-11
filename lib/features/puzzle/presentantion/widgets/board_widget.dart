import 'package:flutter/material.dart';

class BoardScreen extends StatefulWidget {
  final int size;

  const BoardScreen({super.key, required this.size});

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  late List<int> tiles;

  @override
  void initState() {
    super.initState();
    _generateTiles();
  }

  void _generateTiles() {
    final count = widget.size * widget.size;
    tiles = List.generate(count, (i) => i + 1);
    tiles[tiles.length - 1] = 0;
    tiles.shuffle();
  }

  void _onTileTap(int index) {
    final emptyIndex = tiles.indexOf(0);
    final canMove = _isAdjacent(index, emptyIndex);

    if (canMove) {
      setState(() {
        tiles[emptyIndex] = tiles[index];
        tiles[index] = 0;
      });
    }
  }

  bool _isAdjacent(int index, int emptyIndex) {
    final size = widget.size;
    final row = index ~/ size;
    final col = index % size;
    final emptyRow = emptyIndex ~/ size;
    final emptyCol = emptyIndex % size;

    // Movimientos válidos: arriba, abajo, izquierda, derecha
    return (row == emptyRow && (col - emptyCol).abs() == 1) ||
        (col == emptyCol && (row - emptyRow).abs() == 1);
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('${size}x$size Puzzle'),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: tiles.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: size,
                  ),
                  itemBuilder: (context, index) {
                    final value = tiles[index];
                    final isEmpty = value == 0;

                    return GestureDetector(
                      onTap: () => _onTileTap(index),
                      child: AnimatedScale(
                        curve: Curves.easeOut,
                        duration: const Duration(milliseconds: 500),
                        scale: isEmpty ? 0 : 1,
                        child: Center(
                          child: isEmpty
                              ? const SizedBox.shrink()
                              : Container(
                                  margin: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                      255,
                                      34,
                                      76,
                                      148,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 3,
                                      ),
                                    ],
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '$value',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    tiles.shuffle();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 16,
                  ),
                ),
                child: const Text(
                  'REINICIAR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
