import 'package:flutter/material.dart';

class RetroDiamondPainter extends CustomPainter {
  final Color color;
  final int? number;
  final bool isBase;

  RetroDiamondPainter({required this.color, this.number, this.isBase = false});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();

    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(0, size.height / 2);
    path.close();

    if (!isBase) {
      final shadowPath = Path()
        ..moveTo(size.width / 2, 2)
        ..lineTo(size.width - 2, size.height / 2)
        ..lineTo(size.width / 2, size.height - 2)
        ..lineTo(2, size.height / 2)
        ..close();

      canvas.drawShadow(shadowPath, Colors.black, 8, true);
    }

    canvas.drawPath(path, paint);

    final borderPaint = Paint()
      ..color = isBase ? Colors.grey.shade600 : Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    canvas.drawPath(path, borderPaint);

    if (number != null) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: '$number',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'PressStart2P',
          ),
        ),
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          (size.width - textPainter.width),
          (size.height - textPainter.height),
        ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
