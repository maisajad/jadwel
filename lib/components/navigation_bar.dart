import 'package:flutter/material.dart';
import 'package:jadwel/screens/login_screen.dart';
import 'package:jadwel/fetcher.dart' as fetcher;
import 'package:shared_preferences/shared_preferences.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  Future<String> getFullName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jwtToken = prefs.getString('jwtToken');
    final String fullName = fetcher.getClaims(jwtToken!)['userName'];
    return fullName;
  }

  Future<String> getDepartmentName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jwtToken = prefs.getString('jwtToken');
    final String departmentName =
        fetcher.getClaims(jwtToken!)['departmentName'];
    return departmentName;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF3C698B),
            ),
            accountName: FutureBuilder<String>(
              future: getFullName(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Text(
                      snapshot.data!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    );
                  }
                }
              },
            ),
            accountEmail: FutureBuilder<String>(
              future: getDepartmentName(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Text(snapshot.data!);
                  }
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Information',
                  style: TextStyle(
                      color: Color(0xFF3C698B),
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.person_outline,
                    size: 30,
                  ),
                  title: const Text(
                    'Student Info',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: (() {}),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.account_balance,
                    size: 30,
                  ),
                  title: const Text(
                    'Academic Info',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: (() {}),
                ),
              ],
            ),
          ),
          const Divider(
            indent: 0,
            endIndent: 0,
            thickness: 2,
            color: Color(0xFF3C698B),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Settings',
                  style: TextStyle(
                      color: Color(0xFF3C698B),
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.language,
                    size: 30,
                  ),
                  title: const Text(
                    'Language',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: (() {}),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.color_lens,
                    size: 30,
                  ),
                  title: const Text(
                    'Theme',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: (() {}),
                ),
              ],
            ),
          ),
          const Divider(
            indent: 0,
            endIndent: 0,
            thickness: 2,
            color: Color(0xFF3C698B),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.logout,
                size: 30,
              ),
              title: const Text(
                'Logout',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
