import 'dart:math';
import 'package:flutter/material.dart';
import './title_widget.dart';
import 'retro_diamond_painter.dart';

class BoardWidget extends StatefulWidget {
  const BoardWidget({super.key});

  @override
  State<BoardWidget> createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> {
  static const int size = 4;
  late List<int> board;
  bool _isCompleted = false;

  final double tileW = 80;
  final double tileH = 80;

  @override
  void initState() {
    super.initState();
    board = List.generate(size * size, (i) => i);
    shuffleBoard(100);
  }

  int idx(int r, int c) => r * size + c;
  int rowOf(int index) => index ~/ size;
  int colOf(int index) => index % size;
  int emptyIndex() => board.indexOf(0);

  bool isAdjacent(int fromIdx, int toIdx) {
    final r1 = rowOf(fromIdx), c1 = colOf(fromIdx);
    final r2 = rowOf(toIdx), c2 = colOf(toIdx);
    return (r1 == r2 && (c1 - c2).abs() == 1) ||
        (c1 == c2 && (r1 - r2).abs() == 1);
  }

  void moveTile(int index) {
    if (_isCompleted) return;

    final eIdx = emptyIndex();
    if (!isAdjacent(index, eIdx)) return;

    setState(() {
      board[eIdx] = board[index];
      board[index] = 0;
      _isCompleted = _checkSolution();
    });
  }

  bool _checkSolution() {
    for (int i = 0; i < board.length - 1; i++) {
      if (board[i] != i + 1) return false;
    }
    return board.last == 0;
  }

  void shuffleBoard(int steps) {
    final rand = Random();
    setState(() {
      _isCompleted = false;
      for (int s = 0; s < steps; s++) {
        final e = emptyIndex();
        final er = rowOf(e), ec = colOf(e);
        final neighbors = <int>[];
        if (er > 0) neighbors.add(idx(er - 1, ec));
        if (er < size - 1) neighbors.add(idx(er + 1, ec));
        if (ec > 0) neighbors.add(idx(er, ec - 1));
        if (ec < size - 1) neighbors.add(idx(er, ec + 1));
        final pick = neighbors[rand.nextInt(neighbors.length)];
        final tmp = board[pick];
        board[pick] = 0;
        board[e] = tmp;
      }
    });
  }

  Offset isoPosition(int r, int c) {
    final x = c * tileW;
    final y = r * tileH;
    return Offset(x, y);
  }

  Color _getTileColor(int value) {
    final grays = [
      Colors.white,
      Colors.grey.shade100,
      Colors.grey.shade200,
      Colors.grey.shade300,
      Colors.grey.shade400,
      Colors.grey.shade500,
      Colors.grey.shade500,
      Colors.grey.shade400,
      Colors.grey.shade300,
      Colors.grey.shade200,
    ];
    return grays[value % grays.length];
  }

  @override
  Widget build(BuildContext context) {
    final positions = List.generate(
      size,
      (r) => List.generate(size, (c) => isoPosition(r, c)),
    );

    final totalWidth = size * tileW;
    final totalHeight = size * tileH;

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 1.5,
              colors: [Colors.grey.shade900, Colors.black],
            ),
          ),
        ),
        if (_isCompleted)
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 3),
              ),
              child: const Text(
                '¡FELICIDADES!',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
        Center(
          child: SizedBox(
            width: totalWidth,
            height: totalHeight,
            child: Stack(
              children: [
                // base del tablero
                for (int r = 0; r < size; r++)
                  for (int c = 0; c < size; c++)
                    Positioned(
                      left: positions[r][c].dx + totalWidth / 2 - tileW / 2,
                      top: positions[r][c].dy,
                      child: SizedBox(
                        width: tileW,
                        height: tileH,
                        child: CustomPaint(
                          painter: RetroDiamondPainter(
                            color: Colors.grey.shade800,
                            isBase: true,
                          ),
                        ),
                      ),
                    ),

                // fichas
                for (int index = 0; index < board.length; index++)
                  if (board[index] != 0)
                    TileWidget(
                      number: board[index],
                      color: _getTileColor(board[index]),
                      left:
                          positions[rowOf(index)][colOf(index)].dx +
                          totalWidth / 2 -
                          tileW / 2,
                      top: positions[rowOf(index)][colOf(index)].dy,
                      tileW: tileW,
                      tileH: tileH,
                      onMove: () => moveTile(index),
                    ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
