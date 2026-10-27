import 'package:demo_stream/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Bắt đầu, tạm dừng, tiếp tục và đặt lại', (tester) async {
    await tester.pumpWidget(const DemoApp());
    await tester.tap(find.text('Mở đồng hồ bấm giờ'));
    await tester.pumpAndSettle();
    expect(find.text('00:00.0'), findsOneWidget);

    await tester.tap(find.text('Bắt đầu'));
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('00:01.0'), findsOneWidget);

    await tester.tap(find.text('Tạm dừng'));
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('00:01.0'), findsOneWidget);
    expect(find.text('Tiếp tục'), findsOneWidget);

    await tester.tap(find.text('Tiếp tục'));
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text('00:01.5'), findsOneWidget);

    await tester.tap(find.text('Tạm dừng'));
    await tester.pump();
    await tester.tap(find.text('Đặt lại'));
    await tester.pump();
    expect(find.text('00:00.0'), findsOneWidget);
  });

  // flutter_test tự báo lỗi nếu còn Timer chạy khi test kết thúc,
  // nên test này kiểm chứng dispose() đã hủy Timer và đóng Stream.
  testWidgets('Thoát màn hình khi đang chạy không để lại Timer', (tester) async {
    await tester.pumpWidget(const DemoApp());
    await tester.tap(find.text('Mở đồng hồ bấm giờ'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Bắt đầu'));
    await tester.pump(const Duration(milliseconds: 300));

    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Mở đồng hồ bấm giờ'), findsOneWidget);
  });
}
