import 'package:flutter/material.dart';

import 'stopwatch_screen.dart';

/// Màn hình chính: mở rồi thoát màn hình bấm giờ để kiểm tra việc giải phóng.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chủ đề 02: Future & Stream')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton.icon(
              icon: const Icon(Icons.timer),
              label: const Text('Mở đồng hồ bấm giờ'),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const StopwatchScreen(),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Khi thoát màn hình bấm giờ, xem log giải phóng ở console.',
            ),
          ],
        ),
      ),
    );
  }
}
