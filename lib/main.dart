import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:jadwel/screens/login_screen.dart';
import 'package:jadwel/screens/main_screen.dart';
import 'package:jadwel/screens/notifications_screen.dart';
import 'package:jadwel/screens/schedule_options_screen.dart';
import 'package:jadwel/screens/select_courses_screen.dart';
import 'package:jadwel/screens/select_department_screen.dart';
import 'package:jadwel/screens/select_days_screen.dart';
import 'package:jadwel/screens/suggest_course_screen.dart';
import 'package:jadwel/screens/suggested_schedule_screen.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jadwel Student App',
      theme: ThemeData(
        unselectedWidgetColor: const Color(0xFF3C698B),
        primaryColor: const Color(0xFF3C698B),
        hoverColor: const Color(0xFF244863),
        focusColor: const Color(0xFF244863),
        scaffoldBackgroundColor: const Color(0xFFFCFCFC),
        textTheme: const TextTheme(
            bodyText2: TextStyle(
          color: Color(0xFF323232),
          fontFamily: 'NotoSansLao',
        )),
        radioTheme: RadioThemeData(
          fillColor: MaterialStateColor.resolveWith(
            (states) => const Color(0xFF244863),
          ),
        ),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: const Color(0xFF3C698B)),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/mainscreen': (context) => const MainScreen(),
        '/notifications': (context) => const NotificationsScreen(),
        '/scheduleoptions': (context) => const ScheduleOptionsScreen(),
        '/selectdays': (context) => const SelectDaysScreen(),
        '/selectdepartment': (context) => const SelectDepartmentScreen(),
        '/selectcourses': (context) => const SelectCoursesScreen(),
        '/suggestcourse': (context) => const SuggestCourseScreen(),
        '/suggestedschedule': (context) => const SuggestedScheduleScreen(),
      },
    );
  }
}
