import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jadwel/components/department.dart';
import '../components/college.dart';
import '../components/course.dart';
import '../components/info_container.dart';
import 'package:jadwel/fetcher.dart' as fetcher;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SelectCoursesScreen extends StatefulWidget {
  const SelectCoursesScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SelectCoursesScreen> createState() => _SelectCoursesScreenState();
}

class _SelectCoursesScreenState extends State<SelectCoursesScreen> {
  List<Course> _courses = [];

  Future<void> _fetchCourses(int departmentId, int userId) async {
    try {
      final response = await http.get(
          Uri.parse('http://localhost:8080/api/courses/$userId/$departmentId'));
      if (response.statusCode == 200) {
        final List<dynamic> coursesData = json.decode(response.body);
        _courses = coursesData
            .map((courseData) => Course.fromJson(courseData))
            .toList();
      } else {
        if (kDebugMode) {
          print('Failed to fetch courses. Status code: ${response.statusCode}');
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print('Failed to fetch courses: $error');
      }
    }
    for (var course in _courses) {
      if (!fetcher.selectedCourses.contains(course)) {
        fetcher.notSelectedCourses.add(course);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final Department selectedDepartment = args['department'];
    final College selectedCollege = args['college'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3C698B),
        title: const Text(
          'Select Courses',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Center(
                    child: InfoContainer(
                      borderColor: const Color(0xFF244863),
                      backgroundColor: const Color.fromARGB(255, 219, 244, 239),
                      iconData: Icons.priority_high_outlined,
                      title:
                          'Courses you can\'t select are not available for the next semester.',
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.7,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  const Text(
                    'Select Courses',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Center(
                    child: Text(
                      '--Available courses for registration--',
                      style: TextStyle(
                        color: Color(0xFF4D575F),
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  FutureBuilder<int>(
                    future: getUserId(),
                    builder:
                        (BuildContext context, AsyncSnapshot<int> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else {
                        final userId = snapshot.data!;
                        return FutureBuilder<void>(
                          future: _fetchCourses(selectedDepartment.id, userId),
                          builder: (BuildContext context,
                              AsyncSnapshot<void> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text('Error: ${snapshot.error}'),
                              );
                            } else {
                              return Column(
                                children:
                                    _courses.map(buildSingleCheckBox).toList(),
                              );
                            }
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
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
                onPressed: fetcher.selectedCourses.isNotEmpty
                    ? () {
                        Navigator.pushNamed(
                          context,
                          '/selectedcourses',
                          arguments: {
                            'college': selectedCollege,
                            'department': selectedDepartment,
                            'days': fetcher.selectedDays,
                            'courses': fetcher.selectedCourses
                          },
                        );
                      }
                    : () {
                        if (fetcher.selectedCourses.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => SimpleDialog(
                              title: const Text(
                                  'You must select at least 1 course'),
                              children: [
                                SimpleDialogOption(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Close'),
                                ),
                              ],
                            ),
                          );
                        } else {
                          Navigator.pushNamed(
                            context,
                            '/selectedcourses',
                            arguments: {
                              'college': selectedCollege,
                              'department': selectedDepartment,
                              'days': fetcher.selectedDays,
                              'courses': fetcher.selectedCourses
                            },
                          );
                        }
                      },
                child: const Text(
                  'Add',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  StatefulBuilder buildSingleCheckBox(Course course) {
    return StatefulBuilder(
      builder: (context, setState) {
        return CheckboxListTile(
          secondary: course.isActive
              ? null
              : IconButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/suggestcourse',
                      arguments: {
                        'course': course,
                      },
                    ).then((_) => setState(() {}));
                  },
                  icon: const Icon(
                    Icons.message_outlined,
                    color: Color(0xFF244863),
                  ),
                ),
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(
            course.name,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          activeColor: const Color(0xFF3C698B),
          value: course.value,
          onChanged: course.isActive
              ? (value) {
                  setState(() {
                    course.value = value!;
                    if (value == true) {
                      fetcher.selectedCourses.add(course);
                    } else {
                      fetcher.selectedCourses.remove(course);
                    }
                  });
                }
              : null,
        );
      },
    );
  }

  Future<int> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs.getString('jwtToken');
    if (jwtToken != null) {
      return fetcher.getClaims(jwtToken)['userId'] as int;
    }
    throw Exception('User ID not found.');
  }
}
