import 'package:timeago/timeago.dart' as timeago;

String getRelativeTime(String? timestamp) {
  final date = DateTime.tryParse(timestamp ?? '');
  return timeago.format(date ?? DateTime.now());
}
