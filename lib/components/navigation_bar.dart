import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jadwel/screens/login_screen.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundColor: const Color(0xFF3C698B),
              child: ClipOval(
                child: Image.asset('assets/images/avatar_2.png'),
              ),
            ),
            accountName: const Text(
              'Maysa Jadalla',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            accountEmail: const Text('mijadalla19@cit.just.edu.jo'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Information',
                  style: TextStyle(
                      color: const Color(0xFF3C698B),
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
                      color: const Color(0xFF3C698B),
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
                    'Laguage',
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
                    style: const TextStyle(fontSize: 16),
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
              leading: Icon(
                Icons.logout,
                size: 30,
              ),
              title: Text(
                'Logout',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
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
