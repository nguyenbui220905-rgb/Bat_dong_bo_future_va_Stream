import 'dart:async';

import '../models/stopwatch_status.dart';

/// Nguồn phát thời gian liên tục bằng StreamController + Timer.
///
/// Giao diện chỉ gọi [start], [pause], [reset], [dispose]
/// và lắng nghe [stream] để hiển thị.
class StopwatchService {
  StopwatchService({this.interval = const Duration(milliseconds: 100)});

  /// Khoảng thời gian giữa hai lần phát (mặc định 0,1 giây).
  final Duration interval;

  final StreamController<Duration> _controller =
      StreamController<Duration>.broadcast();

  Timer? _timer;
  Duration _elapsed = Duration.zero;
  StopwatchStatus _status = StopwatchStatus.idle;

  Stream<Duration> get stream => _controller.stream;
  Duration get elapsed => _elapsed;
  StopwatchStatus get status => _status;
  bool get isClosed => _controller.isClosed;

  /// Bắt đầu hoặc tiếp tục: tạo Timer, mỗi tick cộng thời gian và phát ra Stream.
  void start() {
    if (_status == StopwatchStatus.running || isClosed) return;
    _timer = Timer.periodic(interval, (_) {
      _elapsed += interval;
      _emit();
    });
    _status = StopwatchStatus.running;
  }

  /// Tạm dừng: hủy Timer, giữ nguyên thời gian đã chạy.
  void pause() {
    if (_status != StopwatchStatus.running) return;
    _cancelTimer();
    _status = StopwatchStatus.paused;
  }

  /// Đặt lại: dừng và đưa thời gian về 0.
  void reset() {
    _cancelTimer();
    _elapsed = Duration.zero;
    _status = StopwatchStatus.idle;
    _emit();
  }

  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _emit() {
    if (!isClosed) _controller.add(_elapsed); // không add vào Stream đã đóng
  }

  /// Giải phóng: hủy Timer và đóng Stream. Gọi nhiều lần vẫn an toàn.
  void dispose() {
    _cancelTimer();
    _controller.close();
  }
}
