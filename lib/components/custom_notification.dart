class CustomNotification {
  final String title;
  final String message;
  final DateTime date;
  bool isOpened;

  CustomNotification({
    required this.title,
    required this.message,
    required this.date,
    this.isOpened = false,
  });
}
