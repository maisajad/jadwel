import 'package:flutter/material.dart';
import 'package:jadwel/globals.dart' as globals;

class EditDaysScreen extends StatefulWidget {
  const EditDaysScreen({Key? key}) : super(key: key);

  @override
  State<EditDaysScreen> createState() => _EditDaysScreenState();
}

class _EditDaysScreenState extends State<EditDaysScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3C698B),
        title: const Text(
          'Edit days',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 15, left: 20),
              child: Text(
                'Days',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          //  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          RadioListTile<String>(
            contentPadding: const EdgeInsets.only(left: 10),
            title: const Text(
              'Sunday-Tuesday-Thursday',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            value: 'Sunday-Tuesday-Thursday',
            groupValue: globals.selectedDays,
            onChanged: (value) {
              setState(
                () {
                  globals.selectedDays = value!;
                },
              );
            },
          ),
          RadioListTile<String>(
            contentPadding: const EdgeInsets.only(left: 10),
            title: const Text(
              'Monday-Wednesday',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            value: 'Monday-Wednesday',
            groupValue: globals.selectedDays,
            onChanged: (value) {
              setState(
                () {
                  globals.selectedDays = value!;
                },
              );
            },
          ),
          RadioListTile<String>(
            contentPadding: const EdgeInsets.only(left: 10),
            title: const Text(
              'All days',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            value: 'All days',
            groupValue: globals.selectedDays,
            onChanged: (value) {
              setState(() {
                globals.selectedDays = value!;
              });
            },
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.20),
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
              onPressed: globals.selectedDays.isNotEmpty
                  ? () {
                      globals.selectedDays = globals.selectedDays;
                      Navigator.pushNamed(context, '/suggestedschedule',
                          arguments: {
                            'days': globals.selectedDays,
                            'courses': globals.selectedCourses
                          });
                    }
                  : null,
              child: const Text(
                'Save',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
