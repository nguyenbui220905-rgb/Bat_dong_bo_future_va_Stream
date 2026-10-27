/// Định dạng thời gian dạng mm:ss.d (phút:giây.phần mười giây).
/// Ví dụ: 65,3 giây -> "01:05.3".
String formatDuration(Duration d) {
  final minutes = d.inMinutes.toString().padLeft(2, '0');
  final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
  final tenths = d.inMilliseconds.remainder(1000) ~/ 100;
  return '$minutes:$seconds.$tenths';
}
