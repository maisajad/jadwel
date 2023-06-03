import 'package:flutter/material.dart';
import 'package:jadwel/components/custom_notification.dart';
import 'package:jadwel/globals.dart' as globals;

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3C698B),
        title: const Text(
          'Notifications',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            ...globals.notifications
                .map((notification) => buildNotification(notification))
                .toList(),
          ],
        ),
      ),
    );
  }

  Padding buildNotification(CustomNotification notification) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        clipBehavior: Clip.antiAlias,
        elevation: 5,
        child: InkWell(
          splashColor: const Color.fromARGB(255, 195, 218, 236),
          onTap: () {
            Navigator.pushNamed(context, '/notification',
                    arguments: {'notification': notification})
                .then((_) => setState(() {}));
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.12,
            width: MediaQuery.of(context).size.width * 0.75,
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                Icon(
                  notification.isOpened ? Icons.mail_outline : Icons.mail,
                  size: 35,
                  color: const Color(0xFF3C698B),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      notification.title,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    '${notification.date.year}-${notification.date.month}-${notification.date.day}',
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
