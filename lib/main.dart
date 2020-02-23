import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/instructor_list.dart';
import 'screens/coures_list.dart';
import 'screens/club_list.dart';
import 'screens/major_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/instructor': (BuildContext context) => new InstructorList(),
        '/course': (BuildContext context) => new CourseList(),
        '/clubs': (BuildContext context) => new ClubList(),
        '/major': (BuildContext context) => new MajorList(),
      },
    );
  }
}
