import 'package:flutter/material.dart';

class SuggestedScheduleScreen extends StatelessWidget {
  const SuggestedScheduleScreen({Key? key}) : super(key: key);

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
    );
  }
}
