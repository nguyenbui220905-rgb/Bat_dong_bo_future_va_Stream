import 'package:demo_stream/models/stopwatch_status.dart';
import 'package:demo_stream/services/stopwatch_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tick = Duration(milliseconds: 5);
  late StopwatchService service;

  setUp(() => service = StopwatchService(interval: tick));
  tearDown(() => service.dispose());

  test('start thì phát thời gian tăng dần', () async {
    final firstTwo = service.stream.take(2).toList();
    service.start();
    expect(service.status, StopwatchStatus.running);
    expect(await firstTwo, [tick, tick * 2]);
  });

  test('pause thì ngừng phát và giữ nguyên thời gian', () async {
    service.start();
    await Future<void>.delayed(const Duration(milliseconds: 30));
    service.pause();
    final kept = service.elapsed;
    await Future<void>.delayed(const Duration(milliseconds: 30));
    expect(service.status, StopwatchStatus.paused);
    expect(service.elapsed, kept);
  });

  test('reset đưa thời gian về 0', () async {
    service.start();
    await Future<void>.delayed(const Duration(milliseconds: 30));
    final next = service.stream.first;
    service.reset();
    expect(await next, Duration.zero);
    expect(service.status, StopwatchStatus.idle);
  });

  test('dispose đóng Stream, gọi tiếp vẫn an toàn', () async {
    final done = expectLater(service.stream, emitsDone);
    service.dispose();
    await done;
    expect(service.isClosed, isTrue);
    service
      ..start()
      ..reset();
    expect(service.status, isNot(StopwatchStatus.running));
  });
}
