class CourseDTO {
  final int studentScheduleId;
  final String days;
  final String userName;
  final int courseId;
  final String courseName;

  CourseDTO({
    required this.studentScheduleId,
    required this.days,
    required this.userName,
    required this.courseId,
    required this.courseName,
  });

  factory CourseDTO.fromJson(Map<String, dynamic> json) {
    return CourseDTO(
      studentScheduleId: json['student_schedule_id'],
      days: json['days'],
      userName: json['user_name'],
      courseId: json['course_id'],
      courseName: json['course_name'],
    );
  }
}
