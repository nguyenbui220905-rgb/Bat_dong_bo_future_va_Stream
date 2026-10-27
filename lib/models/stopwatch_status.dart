/// Trạng thái của đồng hồ bấm giờ, kèm nhãn hiển thị.
enum StopwatchStatus {
  idle('Sẵn sàng'),
  running('Đang chạy'),
  paused('Đã tạm dừng');

  const StopwatchStatus(this.label);

  final String label;
}
