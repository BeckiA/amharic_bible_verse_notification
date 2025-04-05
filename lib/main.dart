import 'package:amharic_bible_verse_app/screens/home_page.dart';
import 'package:amharic_bible_verse_app/service/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  // Get the timezone for Addis Ababa
  final location = TZDateTime.now(local);
  print('Current time zone: ${location}');
  // Print the timezone information
  // print('Addis Ababa time zone: ${location.name}');
  // print('Current time in Addis Ababa: ${tz.now(location)}');

  await NotificationService().init(); // Initialize notifications
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Amharic Verse App',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const HomeScreen(),
    );
  }
}
