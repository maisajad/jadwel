class Course {
  final int courseId;
  final String name;
  final int creditHours;
  final bool isActive;
  final String departmentName;
  bool value;

  Course({
    required this.courseId,
    required this.name,
    required this.creditHours,
    required this.isActive,
    required this.departmentName,
    this.value = false,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      courseId: json['course_id'],
      name: json['name'],
      creditHours: json['credit_hours'],
      isActive: json['is_active'] == 1,
      departmentName: json['department_name'],
    );
  }
}
