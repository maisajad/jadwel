import 'package:flutter/material.dart';
import 'package:jadwel/components/department.dart';
import '../components/college.dart';
import '../components/course.dart';
import '../components/info_container.dart';
import 'package:jadwel/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';

class SelectCoursesScreen extends StatefulWidget {
  const SelectCoursesScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SelectCoursesScreen> createState() => _SelectCoursesScreenState();
}

class _SelectCoursesScreenState extends State<SelectCoursesScreen> {
  List<Course> _courses = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> _setCourses() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:8080/api/courses'));
      if (response.statusCode == 200) {
        final List<dynamic> coursesData = json.decode(response.body);
        _courses = coursesData
            .map((courseData) => Course.fromJson(courseData))
            .toList();
      } else {
        print('Failed to fetch courses. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Failed to fetch courses: $error');
    }
    for (var course in _courses) {
      if (!globals.selectedCourses.contains(course)) {
        globals.notSelectedCourses.add(course);
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
                          'Courses you can\'t select are not\navailable for the next semester.',
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
                      '--Available courses for regestiraion--',
                      style: TextStyle(
                        color: Color(0xFF4D575F),
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  FutureBuilder<void>(
                    future: _setCourses(),
                    builder:
                        (BuildContext context, AsyncSnapshot<void> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else {
                        return Column(
                          children: globals.notSelectedCourses
                              .map(buildSingleCheckBox)
                              .toList(),
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
                  primary: const Color(0xFF3C698B),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: globals.selectedCourses.isNotEmpty
                    ? () {
                        Navigator.pushNamed(
                          context,
                          '/selectedcourses',
                          arguments: {
                            'college': selectedCollege,
                            'department': selectedDepartment,
                            'days': globals.selectedDays,
                            'courses': globals.selectedCourses
                          },
                        );
                      }
                    : () {
                        if (globals.selectedCourses.isEmpty) {
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
                              'days': globals.selectedDays,
                              'courses': globals.selectedCourses
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
          secondary: (course.isActive)
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
                  icon: Icon(
                    Icons.message_outlined,
                    color: (!course.isSuggested)
                        ? const Color(0xFF244863)
                        : Colors.grey,
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
          onChanged: (course.isActive)
              ? (value) {
                  setState(() {
                    course.value = value!;
                    if (value == true) {
                      globals.selectedCourses.add(course);
                    } else {
                      globals.selectedCourses.remove(course);
                    }
                  });
                }
              : null,
        );
      },
    );
  }
}
