import 'package:flutter/material.dart';

import '../services/stopwatch_service.dart';
import '../widgets/control_buttons.dart';
import '../widgets/time_display.dart';

/// Màn hình đồng hồ bấm giờ: StreamBuilder hiển thị thời gian biến đổi liên tục.
class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  final StopwatchService _service = StopwatchService();

  // setState chỉ để cập nhật trạng thái các nút;
  // con số thời gian do StreamBuilder tự cập nhật.
  void _start() => setState(_service.start);
  void _pause() => setState(_service.pause);
  void _reset() => setState(_service.reset);

  @override
  void dispose() {
    _service.dispose(); // hủy Timer + đóng StreamController
    debugPrint('Đã hủy Timer và đóng StreamController');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Đồng hồ bấm giờ')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // StreamBuilder tự build lại mỗi khi Stream phát thời gian mới.
              StreamBuilder<Duration>(
                stream: _service.stream,
                initialData: _service.elapsed,
                builder: (context, snapshot) =>
                    TimeDisplay(elapsed: snapshot.data ?? _service.elapsed),
              ),
              const SizedBox(height: 8),
              Text(_service.status.label, style: theme.textTheme.titleMedium),
              const SizedBox(height: 32),
              ControlButtons(
                status: _service.status,
                onStart: _start,
                onPause: _pause,
                onReset: _reset,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
