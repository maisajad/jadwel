import 'package:flutter/material.dart';
import '../components/custom_card.dart';

class ScheduleOptionsScreen extends StatelessWidget {
  const ScheduleOptionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3C698B),
        title: const Text(
          'Suggest Schedule',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/notifications');
            },
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.count(
          childAspectRatio: (MediaQuery.of(context).size.width * 0.45) /
              (MediaQuery.of(context).size.height * 0.20),
          crossAxisCount: 2,
          mainAxisSpacing: MediaQuery.of(context).size.width * 0.05,
          crossAxisSpacing: MediaQuery.of(context).size.height * 0.01,
          children: [
            CustomCard(
              width: MediaQuery.of(context).size.width * 0.45,
              height: MediaQuery.of(context).size.height * 0.20,
              title: const Text(
                'Create Schedule',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              icon: const Icon(
                Icons.playlist_add,
                size: 50,
              ),
              onTap: () {
                Navigator.pushNamed(context, '/selectdays');
              },
            ),
            CustomCard(
              width: MediaQuery.of(context).size.width * 0.45,
              height: MediaQuery.of(context).size.height * 0.20,
              title: const Text(
                'View Suggested Schedule',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              icon: const Icon(
                Icons.grid_on,
                size: 50,
              ),
              onTap: () {}, //TODO
            ),
          ],
        ),
      ),
    );
  }
}
