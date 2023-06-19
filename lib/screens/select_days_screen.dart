import 'package:flutter/material.dart';
import 'package:jadwel/fetcher.dart' as fetcher;

class SelectDaysScreen extends StatefulWidget {
  const SelectDaysScreen({Key? key}) : super(key: key);

  @override
  State<SelectDaysScreen> createState() => _SelectDaysScreenState();
}

class _SelectDaysScreenState extends State<SelectDaysScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3C698B),
        title: const Text(
          'Suggest New Schedule',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
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
            //              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            RadioListTile<String>(
              contentPadding: const EdgeInsets.only(left: 10),
              title: const Text(
                'Sunday - Tuesday - Thursday',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              value: 'Sunday - Tuesday - Thursday',
              groupValue: fetcher.selectedDays,
              onChanged: (value) {
                setState(() {
                  fetcher.selectedDays = value!;
                });
              },
            ),
            RadioListTile<String>(
              contentPadding: const EdgeInsets.only(left: 10),
              title: const Text(
                'Monday - Wednesday',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              value: 'Monday - Wednesday',
              groupValue: fetcher.selectedDays,
              onChanged: (value) {
                setState(() {
                  fetcher.selectedDays = value!;
                });
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
              value: 'Sunday - Tuesday - Thursday, Monday - Wednesday',
              groupValue: fetcher.selectedDays,
              onChanged: (value) {
                setState(() {
                  fetcher.selectedDays = value!;
                });
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.20),
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
                onPressed: fetcher.selectedDays.isNotEmpty
                    ? () {
                        Navigator.pushNamed(context, '/selectdepartment',
                            arguments: {
                              'days': fetcher.selectedDays,
                              'courses': fetcher.selectedCourses
                            });
                      }
                    : null,
                child: const Text(
                  'Next',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
