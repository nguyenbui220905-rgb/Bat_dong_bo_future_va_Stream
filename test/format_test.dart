import 'package:demo_stream/core/format.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('formatDuration hiển thị mm:ss.d', () {
    expect(formatDuration(Duration.zero), '00:00.0');
    expect(
      formatDuration(const Duration(minutes: 1, seconds: 5, milliseconds: 300)),
      '01:05.3',
    );
  });
}
