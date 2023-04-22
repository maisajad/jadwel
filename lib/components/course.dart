class Course {
  final String name;
  final String courseID;
  bool isAvailable;
  bool value;

  Course({
    required this.name,
    required this.courseID,
    this.isAvailable = true,
    this.value = false,
  });
}
