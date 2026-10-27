import 'package:flutter/material.dart';

import '../models/stopwatch_status.dart';

/// Ba nút điều khiển: Bắt đầu (Tiếp tục) / Tạm dừng / Đặt lại.
class ControlButtons extends StatelessWidget {
  const ControlButtons({
    super.key,
    required this.status,
    required this.onStart,
    required this.onPause,
    required this.onReset,
  });

  final StopwatchStatus status;
  final VoidCallback onStart;
  final VoidCallback onPause;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final running = status == StopwatchStatus.running;
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: [
        FilledButton.icon(
          onPressed: running ? null : onStart,
          icon: const Icon(Icons.play_arrow),
          label: Text(status == StopwatchStatus.paused ? 'Tiếp tục' : 'Bắt đầu'),
        ),
        FilledButton.tonalIcon(
          onPressed: running ? onPause : null,
          icon: const Icon(Icons.pause),
          label: const Text('Tạm dừng'),
        ),
        OutlinedButton.icon(
          onPressed: status == StopwatchStatus.idle ? null : onReset,
          icon: const Icon(Icons.restart_alt),
          label: const Text('Đặt lại'),
        ),
      ],
    );
  }
}
