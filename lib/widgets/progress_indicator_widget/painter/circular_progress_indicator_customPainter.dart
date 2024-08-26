import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math';

class InfiniteCircularProgressPainter extends CustomPainter {
  final double progress;
  final Color fillColor;
  final Color unfilledColor;

  InfiniteCircularProgressPainter({
    required this.progress,
    required this.fillColor,
    required this.unfilledColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double radius = min(size.width / 2, size.height / 2);
    double strokeWidth = 2.0;

    Paint fillPaint = Paint()
      ..color = fillColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    Paint unfilledPaint = Paint()
      ..color = unfilledColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double angle = 2 * pi * progress;

    canvas.drawArc(
      Rect.fromCircle(center: size.center(Offset.zero), radius: radius),
      -pi / 2,
      angle,
      false,
      fillPaint,
    );


    Path dashedPath = Path();
    dashedPath.addArc(
      Rect.fromCircle(center: size.center(Offset.zero), radius: radius),
      angle - pi / 2,
      2 * pi - angle,
    );
    canvas.drawPath(_createDashedPath(dashedPath), unfilledPaint);
  }

  Path _createDashedPath(Path source) {
    double dashWidth = 5.0;
    double dashSpace = 10.0;
    final Path path = Path();
    for (PathMetric pathMetric in source.computeMetrics()) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        final double length = pathMetric.length - distance;
        if (length < dashWidth) break;
        final bool drawDash = distance + dashWidth < pathMetric.length;
        final double end = distance + (drawDash ? dashWidth : length);
        path.addPath(
          pathMetric.extractPath(distance, end),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
    }
    return path;
  }

  @override
  bool shouldRepaint(InfiniteCircularProgressPainter oldDelegate) {
    return true;
  }
}