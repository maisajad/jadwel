import 'package:flutter/material.dart';
import 'package:jadwel/components/navigation_bar.dart';
import 'package:jadwel/components/custom_card.dart';
import 'package:jadwel/fetcher.dart' as fetcher;

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    fetcher.resetData();
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
          childAspectRatio: getCardAspectRatio(context),
          crossAxisCount: 2,
          mainAxisSpacing: getMainAxisSpacing(context),
          crossAxisSpacing: getCrossAxisSpacing(context),
          children: [
            buildCustomCard(
              context,
              title: 'Finance',
              icon: Icons.attach_money,
              onTap: () {},
            ),
            buildCustomCard(
              context,
              title: 'Registration',
              icon: Icons.dvr_sharp,
              onTap: () {},
            ),
            buildCustomCard(
              context,
              title: 'Request Documents',
              icon: Icons.insert_drive_file_outlined,
              onTap: () {},
            ),
            buildCustomCard(
              context,
              title: 'Library',
              icon: Icons.local_library_outlined,
              onTap: () {},
            ),
            buildCustomCard(
              context,
              title: 'Suggest Schedule',
              icon: Icons.grid_on_sharp,
              isLoading: isLoading,
              onTap: () async {
                setState(() {
                  isLoading = true;
                });

                await fetcher.fetchSuggestedStatus();
                await fetcher.fetchDateData();

                if (DateTime.now().compareTo(fetcher.startDate) < 0) {
                  showSuggestionErrorDialog(context);
                } else {
                  Navigator.pushNamed(context, '/scheduleoptions');
                }

                setState(() {
                  isLoading = false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  double getCardAspectRatio(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return (screenWidth * 0.45) / (screenHeight * 0.20);
  }

  double getMainAxisSpacing(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * 0.05;
  }

  double getCrossAxisSpacing(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return screenHeight * 0.01;
  }

  Widget buildCustomCard(BuildContext context,
      {required String title,
      required IconData icon,
      required onTap,
      bool isLoading = false}) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Stack(
        children: [
          CustomCard(
            width: MediaQuery.of(context).size.width * 0.45,
            height: MediaQuery.of(context).size.height * 0.20,
            title: Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            icon: Icon(
              icon,
              size: 50,
            ),
            onTap: onTap,
          ),
          if (isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void showSuggestionErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => SimpleDialog(
        title: const Text('You can\'t suggest a schedule right now.'),
        children: [
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
