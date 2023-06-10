import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../components/course.dart';
import 'package:jadwel/fetcher.dart' as fetcher;

class SuggestCourseScreen extends StatefulWidget {
  const SuggestCourseScreen({Key? key}) : super(key: key);

  @override
  State<SuggestCourseScreen> createState() => _SuggestCourseScreenState();
}

class _SuggestCourseScreenState extends State<SuggestCourseScreen> {
  String _description = '';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    Course course = args['course'];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color(0xFF3C698B),
        title: const Text(
          'Suggest Course',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Course Name',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              CourseInfoContainer(course: course),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              const Text(
                'Descreption',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF3C698B),
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF3C698B),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width / 50,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Why you need this course?',
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        onChanged: (value) {
                          setState(() {
                            _description = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Center(
                child: SizedBox(
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
                    onPressed: _description.isNotEmpty
                        ? () async {
                            await createSuggestedCourse(
                                course.courseId, _description);
                            if (!mounted) return;
                            Navigator.pop(context);
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
                                content: const Text('Submitted successfuly!'),
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
                          }
                        : null,
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createSuggestedCourse(int courseId, String description) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs.getString('jwtToken');
    int userId;
    if (jwtToken != null) {
      userId = fetcher.getClaims(jwtToken)['userId'];
      var url = Uri.parse('http://localhost:8080/api/suggestedCourse');

      var body = json.encode({
        "userId": userId,
        "course_id": courseId,
        "description": description
      });
      if (kDebugMode) {
        print(body);
      }

      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Creation successful');
        }
      } else {
        if (kDebugMode) {
          print('Failed to create');
        }
      }
    }
  }
}

class CourseInfoContainer extends StatelessWidget {
  const CourseInfoContainer({
    Key? key,
    required this.course,
  }) : super(key: key);

  final Course course;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF3C698B),
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF3C698B),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width / 50,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.05,
          ),
          Expanded(
            child: Center(
              child: Text(
                course.name,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.03,
          ),
          Expanded(
            child: Center(
              child: Text(
                '(${course.courseId.toString()})',
                style: const TextStyle(
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
