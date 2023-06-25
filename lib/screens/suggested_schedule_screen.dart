// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:jadwel/components/info_container.dart';
import 'package:jadwel/fetcher.dart' as fetcher;
import '../components/DTO/course_dto.dart';
import 'package:http/http.dart' as http;

class SuggestedScheduleScreen extends StatefulWidget {
  const SuggestedScheduleScreen({Key? key}) : super(key: key);

  @override
  State<SuggestedScheduleScreen> createState() =>
      _SuggestedScheduleScreenState();
}

class _SuggestedScheduleScreenState extends State<SuggestedScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3C698B),
        title: const Text(
          'Suggested Schedule',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: (!fetcher.isSuggested)
          ? const NoDataFound()
          : (DateTime.now().compareTo(fetcher.deadLineDate) < 0)
              ? Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: ListView(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InfoContainer(
                            backgroundColor:
                                const Color.fromARGB(255, 239, 224, 223),
                            borderColor: const Color.fromARGB(255, 171, 52, 43),
                            iconData: Icons.warning_outlined,
                            title:
                                'Prior to submitting, please verify your schedule to ensure accuracy. It is important to note that once the modification deadline has passed,the schedule cannot be modified.',
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 1,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          const Text(
                            'Selected Days',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const DaysContainer(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          const Text(
                            'Selected Courses',
                            // textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text('')
                                  ],
                                ),
                                ...fetcher.studentSuggestedSchedule
                                    .map((courseDto) => buildRow(courseDto))
                                    .toList(),
                              ],
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
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
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, '/selectdepartment', arguments: {
                                    'days': fetcher.selectedDays,
                                    'courses': fetcher.selectedCourses
                                  });
                                },
                                child: const Text(
                                  'Add courses',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: ListView(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InfoContainer(
                            backgroundColor:
                                const Color.fromARGB(255, 239, 224, 223),
                            borderColor: const Color.fromARGB(255, 171, 52, 43),
                            iconData: Icons.warning_outlined,
                            title:
                                'Modification of the schedule is no longer possible, as the deadline for modification has passed.',
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 1,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          const Text(
                            'Selected Days',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const DaysContainerWithoutEdit(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          const Text(
                            'Selected Courses',
                            // textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                                1: FractionColumnWidth(0.8),
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
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                //buildRowWithoutRemove
                                ...fetcher.studentSuggestedSchedule
                                    .map((courseDto) =>
                                        buildRowWithoutRemove(courseDto))
                                    .toList(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
    );
  }

  TableRow buildRow(CourseDTO courseDto) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            courseDto.courseId.toString(),
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            courseDto.courseName,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        IconButton(
          onPressed: () async {
            showDialog(
              context: context,
              builder: (BuildContext context) => SimpleDialog(
                title:
                    const Text('Are you sure you want to remove this course?'),
                children: [
                  SimpleDialogOption(
                    onPressed: () async {
                      var url = Uri.parse(
                          'https://statistics-scheduling-system-api-production.up.railway.app/api/suggestedStudentSchedule/${courseDto.studentScheduleId}');
                      final response = await http.delete(url);

                      if (response.statusCode == 204) {
                        // If the server returns a 200 OK response, then remove the item from the list.
                        setState(() {
                          fetcher.studentSuggestedSchedule.remove(courseDto);
                        });
                      } else {
                        // If the server did not return a 200 OK response, then throw an exception.
                        throw Exception(
                            'Failed to delete course with id ${courseDto.studentScheduleId}');
                      }
                      if (!mounted) return;
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

  TableRow buildRowWithoutRemove(CourseDTO courseDto) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            courseDto.courseId.toString(),
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            courseDto.courseName,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}

class DaysContainerWithoutEdit extends StatelessWidget {
  const DaysContainerWithoutEdit({
    Key? key,
  }) : super(key: key);

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
      width: MediaQuery.of(context).size.width * 1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF3C698B),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width / 60,
          ),
          Expanded(
            child: Center(
              child: Text(
                fetcher.selectedDays,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.05,
          ),
        ],
      ),
    );
  }
}

class NoDataFound extends StatelessWidget {
  const NoDataFound({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50.0, left: 50, right: 50),
          child: Image.asset(
            'assets/images/nodata.png',
          ),
        ),
        const Text(
          'No data found.',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class DaysContainer extends StatelessWidget {
  const DaysContainer({
    Key? key,
  }) : super(key: key);

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
      width: MediaQuery.of(context).size.width * 1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF3C698B),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width / 60,
          ),
          Expanded(
            child: Center(
              child: Text(
                fetcher.selectedDays,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.05,
          ),
          Center(
            child: IconButton(
              icon: const Icon(
                Icons.edit_outlined,
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/editdays',
                  arguments: {
                    'days': fetcher.selectedDays,
                    'courses': fetcher.selectedCourses
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
