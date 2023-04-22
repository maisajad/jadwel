import 'dart:developer';
import 'package:flutter/material.dart';
import '../components/course.dart';
import '../components/info_container.dart';

class SelectCoursesScreen extends StatefulWidget {
  const SelectCoursesScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SelectCoursesScreen> createState() => _SelectCoursesScreenState();
}

class _SelectCoursesScreenState extends State<SelectCoursesScreen> {
  List<Course> _courses = [];
  List<Course> _selectedCourses = [];

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final String selectedDepartment = args['department'];
    final String selectedCollege = args['college'];
    final String selectedDays = args['days'];

    void _setCourses() {
      if (selectedDepartment == 'Computer Engineering') {
        _courses = [];
      } else if (selectedDepartment == 'Computer Science') {
        _courses = [];
      } else if (selectedDepartment == 'Computer Information Systems') {
        _courses = [];
      } else if (selectedDepartment == 'Network Engineering And Security') {
        _courses = [];
      } else if (selectedDepartment == 'Software Engineering') {
        _courses = [
          Course(
              name: 'INTRODUCTION TO INFORMATION TECHNOLOGY'.toLowerCase(),
              courseID: 'SE103'),
          Course(
              name:
                  'INTRODUCTION TO OBJECT- ORIENTED PROGRAMMING'.toLowerCase(),
              courseID: 'SE112'),
          Course(name: 'JAVA PROGRAMMING'.toLowerCase(), courseID: 'SE210'),
          Course(name: 'SOFTWARE MODELLING'.toLowerCase(), courseID: 'SE220'),
          Course(
              name: 'FUNDAMENTALS OF SOFTWARE ENGINEERING'.toLowerCase(),
              courseID: 'SE230'),
          Course(name: 'VISUAL PROGRAMMING'.toLowerCase(), courseID: 'SE310'),
          Course(
              name: 'SYSTEM ANALYSIS AND DESIGN'.toLowerCase(),
              courseID: 'SE320'),
          Course(
              name: 'SOFTWARE REQUIREMENTS ENGINEERING'.toLowerCase(),
              courseID: 'SE321'),
          Course(
            name: 'SOFTWARE DOCUMENTATION'.toLowerCase(),
            courseID: 'SE323',
            isAvailable: false,
          ),
          Course(
              name: 'Software Architecture & Design'.toLowerCase(),
              courseID: 'SE324'),
          Course(
              name: 'SOFTWARE ENGINEERING LAB (2)'.toLowerCase(),
              courseID: 'SE325'),
          Course(
              name: 'Client/Server Programming'.toLowerCase(),
              courseID: 'SE371'),
          Course(
              name: 'SELECTED PROGRAMMING LANGUAGES'.toLowerCase(),
              courseID: 'SE412'),
          Course(
              name: 'Formal Methods in Software Engineering'.toLowerCase(),
              courseID: 'SE420'),
          Course(name: 'SOFTWARE TESTING'.toLowerCase(), courseID: 'SE430'),
          Course(name: 'SOFTWARE SECURITY'.toLowerCase(), courseID: 'SE431'),
          Course(
              name: 'SOFTWARE ENGINEERING FOR WEB APPLICATIONS'.toLowerCase(),
              courseID: 'SE432'),
          Course(name: 'PROJECT MANAGEMENT'.toLowerCase(), courseID: 'SE440'),
        ];
      } else if (selectedDepartment == 'Cybersecurity') {
        _courses = [];
      } else if (selectedDepartment == 'Data Science') {
        _courses = [];
      } else if (selectedDepartment == 'Artifcial Intelligence') {
        _courses = [];
      } else {}
    }

    _setCourses();

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
                  ..._courses.map(buildSingleCheckBox).toList(),
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
                onPressed: _selectedCourses.isNotEmpty
                    ? () {
                        Navigator.pushNamed(
                          context,
                          '/suggestedschedule',
                          arguments: {
                            'college': selectedCollege,
                            'department': selectedDepartment,
                            'days': selectedDays,
                            'courses': _selectedCourses
                          },
                        );
                      }
                    : () {
                        if (_selectedCourses.isEmpty) {
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
                            '/suggestedschedule',
                            arguments: {
                              'college': selectedCollege,
                              'department': selectedDepartment,
                              'days': selectedDays,
                              'courses': _selectedCourses
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
          secondary: (course.isAvailable)
              ? null
              : IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/suggestcourse');
                  },
                  icon: const Icon(
                    Icons.message_outlined,
                    color: Color(0xFF244863),
                  ),
                ),
          subtitle: Text(course.courseID),
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(
            course.name,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          activeColor: const Color(0xFF3C698B),
          value: course.value,
          onChanged: (course.isAvailable)
              ? (value) {
                  setState(() {
                    course.value = value!;
                    if (value == true) {
                      _selectedCourses.add(course);
                    } else {
                      _selectedCourses.remove(course);
                    }
                  });
                  for (var element in _selectedCourses) {
                    log(element.name);
                  }
                }
              : null,
        );
      },
    );
  }
}
