import 'package:flutter/material.dart';
import 'package:jadwel/components/navigation_bar.dart';
import '../components/custom_card.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3C698B),
        title: const Text(
          'Main Menu',
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
                'Finance',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              icon: const Icon(
                Icons.attach_money,
                size: 50,
              ),
              onTap: () {},
            ),
            CustomCard(
              width: MediaQuery.of(context).size.width * 0.45,
              height: MediaQuery.of(context).size.height * 0.20,
              title: const Text(
                'Registration',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              icon: const Icon(
                Icons.dvr_sharp,
                size: 50,
              ),
              onTap: () {},
            ),
            CustomCard(
              width: MediaQuery.of(context).size.width * 0.45,
              height: MediaQuery.of(context).size.height * 0.20,
              title: const Text(
                'Request Documents',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              icon: const Icon(
                Icons.insert_drive_file_outlined,
                size: 50,
              ),
              onTap: () {},
            ),
            CustomCard(
              width: MediaQuery.of(context).size.width * 0.45,
              height: MediaQuery.of(context).size.height * 0.20,
              title: const Text(
                'Library',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              icon: const Icon(
                Icons.local_library_outlined,
                size: 50,
              ),
              onTap: () {},
            ),
            CustomCard(
              width: MediaQuery.of(context).size.width * 0.45,
              height: MediaQuery.of(context).size.height * 0.20,
              title: const Text(
                'Suggest Schedule',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              icon: const Icon(
                Icons.grid_on_sharp,
                size: 50,
              ),
              onTap: () {
                Navigator.pushNamed(context, '/scheduleoptions');
              },
            ),
          ],
        ),
      ),
    );
  }
}
