import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jadwel/fetcher.dart' as fetcher;
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

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
          maxLines: 2,
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
                maxLines: 2,
                'Days',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          //  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          RadioListTile<String>(
            contentPadding: const EdgeInsets.only(left: 10),
            title: const Text(
              maxLines: 2,
              'Sunday-Tuesday-Thursday',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            value: 'Sunday-Tuesday-Thursday',
            groupValue: fetcher.selectedDays,
            onChanged: (value) {
              setState(
                () {
                  fetcher.selectedDays = value!;
                },
              );
            },
          ),
          RadioListTile<String>(
            contentPadding: const EdgeInsets.only(left: 10),
            title: const Text(
              maxLines: 2,
              'Monday-Wednesday',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            value: 'Monday-Wednesday',
            groupValue: fetcher.selectedDays,
            onChanged: (value) {
              setState(
                () {
                  fetcher.selectedDays = value!;
                },
              );
            },
          ),
          RadioListTile<String>(
            contentPadding: const EdgeInsets.only(left: 10),
            title: const Text(
              maxLines: 2,
              'All days',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            value: 'All days',
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
                  ? () async {
                      fetcher.selectedDays = fetcher.selectedDays;
                      await updateDays();
                      if (!mounted) return;
                      Navigator.pushNamed(context, '/suggestedschedule',
                          arguments: {
                            'days': fetcher.selectedDays,
                            'courses': fetcher.selectedCourses
                          });
                    }
                  : null,
              child: const Text(
                maxLines: 2,
                'Save',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> updateDays() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs.getString('jwtToken');
    int userId;
    if (jwtToken != null) {
      userId = fetcher.getClaims(jwtToken)['userId'];
      var url = Uri.parse(
          'http://localhost:8080/api/suggestedStudentSchedule/$userId');
      var body = json.encode({"days": fetcher.selectedDays});

      var response = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Update successful');
        }
      } else {
        if (kDebugMode) {
          print('Failed to update');
        }
      }
    }
  }
}
