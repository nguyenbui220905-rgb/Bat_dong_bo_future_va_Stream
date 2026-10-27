import 'dart:ui' show FontFeature;

import 'package:flutter/material.dart';

import '../core/format.dart';

/// Hiển thị thời gian dạng mm:ss.d với chữ số đều nhau (không bị nhảy).
class TimeDisplay extends StatelessWidget {
  const TimeDisplay({super.key, required this.elapsed});

  final Duration elapsed;

  @override
  Widget build(BuildContext context) {
    return Text(
      formatDuration(elapsed),
      style: Theme.of(context).textTheme.displayLarge?.copyWith(
            fontWeight: FontWeight.w500,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
    );
  }
}
