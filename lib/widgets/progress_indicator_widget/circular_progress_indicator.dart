
import 'package:flutter/material.dart';

import 'package:indicator/widgets/progress_indicator_widget/painter/circular_progress_indicator_customPainter.dart';

class CustomCircularProgressIndicator extends StatefulWidget {
  final Color fillColor; 
  final Color unfilledColor; 
  final Duration duration; 

  const CustomCircularProgressIndicator({
    super.key,
    required this.fillColor,
    required this.unfilledColor,
    this.duration = const Duration(seconds: 2),
  });

  @override
  createState() =>
      _CustomCircularProgressIndicatorState();
}

class _CustomCircularProgressIndicatorState
    extends State<CustomCircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.repeat(); 
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: InfiniteCircularProgressPainter(
        progress: _animation.value,
        fillColor: widget.fillColor,
        unfilledColor: widget.unfilledColor,
      ),
      child: SizedBox(width: 50, height: 50),
    );
  }
}


