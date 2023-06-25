library globals;

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:jadwel/components/DTO/course_dto.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'components/course.dart';
import 'components/custom_notification.dart';

List<Course> selectedCourses = [];
List<CourseDTO> studentSuggestedSchedule = [];
List<Course> notSelectedCourses = [];

bool isSuggested = false;

String selectedDays = '';

DateTime deadLineDate = DateTime.now();
DateTime startDate = DateTime.now();

resetData() {
  selectedCourses = [];
  studentSuggestedSchedule = [];
  notSelectedCourses = [];

  isSuggested = false;

  selectedDays = '';

  deadLineDate = DateTime.now();
  startDate = DateTime.now();
}

Future<void> fetchDateData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? jwtToken = prefs.getString('jwtToken');
  // ignore: prefer_typing_uninitialized_variables
  var departmentId;
  if (jwtToken != null) {
    departmentId = getClaims(jwtToken)['departmentId'];
  }

  final response = await http.get(Uri.parse(
      'https://statistics-scheduling-system-api-production.up.railway.app/api/date/$departmentId'));

  if (response.statusCode == 200) {
    var dateData = jsonDecode(response.body);
    startDate = DateTime.parse(dateData['startRegister']);
    deadLineDate = DateTime.parse(dateData['endRegister']);
    if (kDebugMode) {
      print('Testtttt');
    }
  } else {
    throw Exception('Failed to load date data');
  }
}

getClaims(String token) {
  const String secret = 'DeiaaDeiaaDeiaaDeiaaDeiaaDeiaaDeiaaDeiaa';
  final decClaimSet = verifyJwtHS256Signature(token, secret);
  final claimJson = decClaimSet.toJson();
  return claimJson;
}

Future<List<CustomNotification>> fetchNotifications(int userId) async {
  final response = await http.get(Uri.parse(
      'https://statistics-scheduling-system-api-production.up.railway.app/api/notifyMessage/$userId'));

  if (response.statusCode == 200) {
    final List<dynamic> jsonResponse = jsonDecode(response.body);
    final List<CustomNotification> notifications = jsonResponse.map((item) {
      return CustomNotification(
        title: item['title'],
        message: item['message'],
        date: DateTime.parse(item['publish_date']),
      );
    }).toList();
    return notifications;
  } else {
    throw Exception('Failed to fetch notifications');
  }
}

Future<void> fetchSuggestedStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? jwtToken = prefs.getString('jwtToken');
  // ignore: prefer_typing_uninitialized_variables
  var userId;
  if (jwtToken != null) {
    userId = getClaims(jwtToken)['userId'];
  }

  final response = await http.get(Uri.parse(
      'https://statistics-scheduling-system-api-production.up.railway.app/api/suggestedStudentSchedule/$userId/exists'));

  if (response.statusCode == 200) {
    isSuggested = jsonDecode(response.body);
  } else {
    throw Exception('Failed to load suggested status');
  }
}

fetchStudentSchedule() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? jwtToken = prefs.getString('jwtToken');
  // ignore: prefer_typing_uninitialized_variables
  var userId;
  if (jwtToken != null) {
    userId = getClaims(jwtToken)['userId'];
  }
  final response = await http.get(Uri.parse(
      'https://statistics-scheduling-system-api-production.up.railway.app/api/suggestedStudentSchedule/$userId'));

  if (response.statusCode == 200) {
    List jsonResponse = jsonDecode(response.body);
    studentSuggestedSchedule =
        jsonResponse.map((item) => CourseDTO.fromJson(item)).toList();
    for (var it in jsonResponse) {
      selectedDays = it['days'];
      break;
    }
  } else {
    throw Exception('Failed to load student schedule');
  }
}
