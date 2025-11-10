import 'package:flutter/material.dart';
import 'retro_diamond_painter.dart';

class TileWidget extends StatelessWidget {
  final int number;
  final Color color;
  final double left;
  final double top;
  final double tileW;
  final double tileH;
  final VoidCallback onMove;

  const TileWidget({
    super.key,
    required this.number,
    required this.color,
    required this.left,
    required this.top,
    required this.tileW,
    required this.tileH,
    required this.onMove,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.elasticOut,
      left: left,
      top: top,
      width: tileW,
      height: tileH,
      child: GestureDetector(
        onTap: onMove,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: CustomPaint(
            size: Size(tileW, tileH),
            painter: RetroDiamondPainter(color: color, number: number),
          ),
        ),
      ),
    );
  }
}
