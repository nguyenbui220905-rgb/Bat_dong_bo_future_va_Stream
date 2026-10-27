# Demo đồng hồ bấm giờ với Stream & StreamBuilder

Ứng dụng minh họa **Chủ đề 02: Lập trình bất đồng bộ với Future & Stream trong Flutter**: đồng hồ bấm giờ cập nhật liên tục bằng `StreamBuilder`, có nút Bắt đầu / Tạm dừng / Đặt lại, và giải phóng Stream an toàn khi người dùng thoát màn hình.

## Cấu trúc thư mục

```
lib/
├── main.dart                          Điểm khởi chạy
├── app.dart                           MaterialApp và theme
├── core/format.dart                   Định dạng thời gian mm:ss.d
├── models/stopwatch_status.dart       Trạng thái: Sẵn sàng, Đang chạy, Đã tạm dừng
├── services/stopwatch_service.dart    StreamController + Timer: start, pause, reset, dispose
├── screens/home_screen.dart           Màn hình chính để mở và thoát đồng hồ
├── screens/stopwatch_screen.dart      StreamBuilder, gọi dispose() khi thoát
└── widgets/                           TimeDisplay (con số) và ControlButtons (3 nút)
test/                                  Unit test service, widget test kiểm chứng giải phóng
```

## Luồng hoạt động

`Timer.periodic` (mỗi 0,1 giây) → `StreamController.add(elapsed)` → `stream` → `StreamBuilder` → con số trên màn hình.

| Nút | Xử lý |
|---|---|
| Bắt đầu / Tiếp tục | Tạo `Timer.periodic`, mỗi tick cộng 0,1 giây và phát vào Stream |
| Tạm dừng | `timer.cancel()`, giữ nguyên thời gian |
| Đặt lại | Hủy Timer, đưa thời gian về 0 và phát giá trị 0 |
| Thoát màn hình | `dispose()` gọi `timer.cancel()` và `controller.close()` |

## Chạy và kiểm thử

```bash
flutter pub get
flutter run -d chrome
flutter test
```

Widget test thứ hai sẽ thất bại nếu màn hình quên hủy Timer khi bị đóng.
