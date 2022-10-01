import 'package:flutter/material.dart';
import 'dart:math' as math;

class RectangularProgressIndicatorPainter extends CustomPainter {
  RectangularProgressIndicatorPainter({
    this.backgroundColor,
    required this.valueColor,
    required this.value,
    required this.headValue,
    required this.tailValue,
    required this.offsetValue,
    required this.rotationValue,
    required this.strokeWidth,
  })  : arcStart = value != null
            ? _startAngle
            : _startAngle +
                tailValue * 3 / 2 * math.pi +
                rotationValue * math.pi * 2.0 +
                offsetValue * 0.5 * math.pi,
        arcSweep = value != null
            ? value.clamp(0.0, 1.0) * _sweep
            : math.max(
                headValue * 3 / 2 * math.pi - tailValue * 3 / 2 * math.pi,
                _epsilon);

  final Color? backgroundColor;
  final Color valueColor;
  final double? value;
  final double headValue;
  final double tailValue;
  final double offsetValue;
  final double rotationValue;
  final double strokeWidth;
  final double arcStart;
  final double arcSweep;

  static const double _twoPi = math.pi * 2.0;
  static const double _epsilon = .001;
  // Canvas.drawArc(r, 0, 2*PI) doesn't draw anything, so just get close.
  static const double _sweep = _twoPi - _epsilon;
  static const double _startAngle = -math.pi / 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = valueColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    if (backgroundColor != null) {
      final Paint backgroundPaint = Paint()
        ..color = backgroundColor!
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke;
      canvas.drawArc(Offset.zero & size, 0, _sweep, false, backgroundPaint);
    }

    if (value == null) {
      paint.strokeCap = StrokeCap.square;
    }

    // canvas.drawArc(Offset.zero & size, arcStart, arcSweep, true, paint);

    // final path = Path()
    //   ..addPolygon(
    //     const [
    //       Offset(0, 0),
    //       Offset(100, 0),
    //       Offset(100, 60),
    //       Offset(0, 60),
    //       Offset(0, 0)
    //     ],
    //     false,
    //   );

    // canvas.drawPath(path, paint);

    // final smallPath = Path();
    // final wValue = rotationValue * size.width;
    // final nwValue = wValue + 20;
    // final hValue = rotationValue * size.height;
    // final nhValue = hValue + 20;
    // smallPath.lineTo(wValue, 0);
    // smallPath.lineTo(nwValue, 0);
    // canvas.drawPath(smallPath, paint..color = Colors.red);

    // final path1 = Path();
    // path1.addPolygon(
    //   [
    //     const Offset(0, 0),
    //     Offset(0, -rotationValue * size.height * 0.4),
    //   ],
    //   false,
    // );

    // canvas.drawPath(path1, paint..color = Colors.red);

    // final path2 = Path();
    // path2.addPolygon(
    //   [
    //     const Offset(5, 0),
    //     Offset(5, -rotationValue * size.height * 0.8),
    //   ],
    //   false,
    // );

    // canvas.drawPath(path2, paint..color = Colors.red);

    // final path3 = Path();
    // path3.addPolygon(
    //   [
    //     const Offset(10, 0),
    //     Offset(10, -rotationValue * size.height * 0.6),
    //   ],
    //   false,
    // );

    // canvas.drawPath(path3, paint..color = Colors.red);

    // final path4 = Path();
    // path4.addPolygon(
    //   [
    //     const Offset(15, 0),
    //     Offset(15, -rotationValue * size.height * 0.45),
    //   ],
    //   false,
    // );

    // canvas.drawPath(path4, paint..color = Colors.red);

    final path = Path();
    path.addPolygon(
      const [
        Offset(0, 0),
        Offset(100, 0),
        Offset(100, 60),
        Offset(0, 60),
        Offset(0, 30)
      ],
      false,
    );

    canvas.drawPath(path, paint);

    // canvas.drawArc(path.getBounds(), arcStart, arcSweep, true, paint);
    // path.addPolygon(
    //   const [
    //     Offset(60, 0),
    //     Offset(100, 0),
    //     Offset(100, 60),
    //     Offset(0, 60),
    //     Offset(0, 0),
    //     Offset(30, 0),
    //   ],
    //   false,
    // );

    // path.addPolygon(
    //   const [
    //     Offset(90, 0),
    //     Offset(100, 0),
    //     Offset(100, 60),
    //     Offset(0, 60),
    //     Offset(0, 0),
    //     Offset(60, 0),
    //   ],
    //   false,
    // );

    // path.addPolygon(
    //   const [
    //     Offset(100, 10),
    //     Offset(100, 60),
    //     Offset(0, 60),
    //     Offset(0, 0),
    //     Offset(90, 0),
    //   ],
    //   false,
    // );

    // path.addPolygon(
    //   const [
    //     Offset(100, 30),
    //     Offset(100, 60),
    //     Offset(0, 60),
    //     Offset(0, 0),
    //     Offset(100, 0),
    //   ],
    //   false,
    // );

    // path.addPolygon(
    //   const [
    //     Offset(100, 60),
    //     Offset(100, 60),
    //     Offset(0, 60),
    //     Offset(0, 0),
    //     Offset(100, 0),
    //     Offset(100, 30),
    //   ],
    //   false,
    // );

    // path.addPolygon(
    //   const [
    //     Offset(90, 60),
    //     Offset(0, 60),
    //     Offset(0, 0),
    //     Offset(100, 0),
    //     Offset(100, 40),
    //   ],
    //   false,
    // );

    // canvas.drawPath(path, paint);

    // RRect fullRect = RRect.fromRectAndRadius(
    //   Rect.fromLTWH(30, 100, 100, 50),
    //   const Radius.circular(8.0),
    // );

    // canvas.drawRRect(fullRect, paint);
  }

  @override
  bool shouldRepaint(RectangularProgressIndicatorPainter oldDelegate) {
    return oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.valueColor != valueColor ||
        oldDelegate.value != value ||
        oldDelegate.headValue != headValue ||
        oldDelegate.tailValue != tailValue ||
        oldDelegate.offsetValue != offsetValue ||
        oldDelegate.rotationValue != rotationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
