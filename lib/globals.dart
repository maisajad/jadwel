library globals;

import 'components/course.dart';
import 'components/custom_notification.dart';

List<Course> selectedCourses = [];
List<Course> notSelectedCourses = [];

//TODO: Edit
bool isSuggested = false;

String selectedDays = '';

//TODO: Edit
DateTime deadLineDate = DateTime(2023, 5, 29);

//TODO: Edit
List<CustomNotification> notifications = [
  CustomNotification(
    title: 'Instrutor Changed',
    message: 'Instructor for \'Operating systems\' have been chaged.',
    date: DateTime.now(),
  ),
  CustomNotification(
    title: 'Instrutor Changed',
    message: 'Instructor for \'Java Programming\' have been chaged.',
    date: DateTime.now(),
  ),
];
