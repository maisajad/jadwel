// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:jadwel/components/info_container.dart';
import 'package:jadwel/globals.dart' as globals;
import '../components/course.dart';

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
    globals.selectedDays = args['days'];
    globals.selectedCourses = args['courses'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3C698B),
        title: const Text(
          'Suggested Schedule',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: (!globals.isSuggested)
          ? const NoDataFound()
          : (DateTime.now().compareTo(globals.deadLineDate) < 0)
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
                                'Prior to submitting, please verify your\nschedule to ensure accuracy. It is important\nto note that once the modification deadline\nhas passed,the schedule cannot be modified.',
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 1,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          const Text(
                            'Selected Days',
                            // textAlign: TextAlign.start,
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
                                ...globals.selectedCourses
                                    .map((course) => buildRow(course))
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
                                  primary: const Color(0xFF3C698B),
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, '/selectdepartment', arguments: {
                                    'days': globals.selectedDays,
                                    'courses': globals.selectedCourses
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
                                'Modification of the schedule is no\nlonger possible, as the deadline for\nmodification has passed.',
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 1,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          const Text(
                            'Selected Days',
                            // textAlign: TextAlign.start,
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
                                ...globals.selectedCourses
                                    .map((course) =>
                                        buildRowWithoutRemove(course))
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
                      globals.selectedCourses.remove(course);
                      course.value = false;

                      globals.notSelectedCourses.add(course);

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

  TableRow buildRowWithoutRemove(Course course) {
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
          Center(
            child: Text(
              globals.selectedDays,
              style: const TextStyle(
                fontSize: 20,
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
          Center(
            child: Text(
              globals.selectedDays,
              style: const TextStyle(
                fontSize: 20,
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
                    'days': globals.selectedDays,
                    'courses': globals.selectedCourses
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
