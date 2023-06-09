// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jadwel/components/college.dart';
import 'package:jadwel/components/department.dart';
import 'package:jadwel/fetcher.dart' as fetcher;

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../components/course.dart';

class SelectedCoursesScreen extends StatefulWidget {
  const SelectedCoursesScreen({Key? key}) : super(key: key);

  @override
  State<SelectedCoursesScreen> createState() => _SelectedCoursesScreenState();
}

Future<void> sendCourseData(Course course) async {
  final url = Uri.parse(
      'https://statistics-scheduling-system-api-production.up.railway.app/api/suggestedStudentSchedule');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      'days': fetcher.selectedDays,
      'user_id': await getUserIdFromSession(),
      'course_id': course.courseId.toString(),
    }),
  );
  if (kDebugMode) {
    print('sendCourseData ${course.courseId}');
  }
  if (response.statusCode == 200) {
    log('200');
  } else {
    log(response.statusCode.toString());
  }
}

Future<int?> getUserIdFromSession() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? jwtToken = prefs.getString('jwtToken');
  // ignore: prefer_typing_uninitialized_variables
  var userId;
  if (jwtToken != null) {
    userId = fetcher.getClaims(jwtToken)['userId'];
    if (kDebugMode) {
      print('JWT NOT NULL $userId ');
    }
  }

  return userId;
}

class _SelectedCoursesScreenState extends State<SelectedCoursesScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final Department selectedDepartment = args['department'];
    final College selectedCollege = args['college'];
    fetcher.selectedDays = args['days'];
    fetcher.selectedCourses = args['courses'];

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF3C698B),
          title: const Text(
            'Suggest New Schedule',
            style: TextStyle(fontSize: 25),
          ),
          centerTitle: true,
          leading: const Icon(null),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 15, left: 20),
                child: Text(
                  'Added Courses',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      border: const TableBorder(
                        horizontalInside: BorderSide(
                            width: 1.5,
                            color: Color(0xFF3C698B),
                            style: BorderStyle.solid),
                      ),
                      columnWidths: const {
                        0: FractionColumnWidth(0.2),
                        1: FractionColumnWidth(0.7),
                        2: FractionColumnWidth(0.1),
                      },
                      children: [
                        const TableRow(
                          children: [
                            Text(
                              'Course ID',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Course Name',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text('')
                          ],
                        ),
                        ...fetcher.selectedCourses
                            .map((course) => buildRow(course))
                            .toList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width * 0.30,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3C698B),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  if (fetcher.selectedCourses.isNotEmpty) {
                    for (final course in fetcher.selectedCourses) {
                      await sendCourseData(course);
                    }
                    if (!mounted) return;
                    Navigator.pushNamed(context, '/mainscreen');
                    fetcher.isSuggested = true;
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text(
                          'Success',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.green,
                          ),
                        ),
                        content: const Text('Schedule submitted successfully!'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.green,
                            ),
                            child: const Text('Great'),
                          ),
                        ],
                        backgroundColor: Colors.white,
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => SimpleDialog(
                        title: const Text('You must select at least 1 course'),
                        children: [
                          SimpleDialogOption(
                            onPressed: () {
                              Navigator.pushNamed(context, '/selectdepartment',
                                  arguments: {
                                    'days': fetcher.selectedDays,
                                    'courses': fetcher.selectedCourses
                                  });
                            },
                            child: const Text('Select Courses'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          ],
        ),
      ),
    );
  }

  TableRow buildRow(Course course) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            course.courseId.toString(),
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            course.name,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => SimpleDialog(
                title:
                    const Text('Are you sure you want to remove this course?'),
                children: [
                  SimpleDialogOption(
                    onPressed: () {
                      fetcher.selectedCourses.remove(course);
                      course.value = false;
                      fetcher.notSelectedCourses.add(course);

                      setState(() {});

                      Navigator.pop(context);
                    },
                    child: const Text('Yes, I\'m sure!'),
                  ),
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('No'),
                  ),
                ],
              ),
            );
          },
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
