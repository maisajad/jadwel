import 'package:flutter/material.dart';

class SelectDaysScreen extends StatefulWidget {
  const SelectDaysScreen({Key? key}) : super(key: key);

  @override
  State<SelectDaysScreen> createState() => _SelectDaysScreenState();
}

class _SelectDaysScreenState extends State<SelectDaysScreen> {
  String selectedValue = '';

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
//              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          RadioListTile<String>(
            contentPadding: const EdgeInsets.only(left: 10),
            title: const Text(
              'Sunday-Tuesday-Thursday',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            value: 'Sunday-Tuesday-Thursday',
            groupValue: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value!;
              });
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
            groupValue: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value!;
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
            value: 'All days',
            groupValue: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value!;
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
              onPressed: selectedValue.isNotEmpty
                  ? () {
                      Navigator.pushNamed(
                        context,
                        '/selectdepartment',
                        arguments: selectedValue,
                      );
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
    );
  }
}
