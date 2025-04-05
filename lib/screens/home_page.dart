import 'dart:convert';
import 'dart:math';
import 'package:amharic_bible_verse_app/service/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String? verseOfTheDay;

  final notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  Future<void> _initializeServices() async {
    await notificationService.init(); // Initialize notification service
    await loadVerse();
  }

  Future<void> loadVerse() async {
    final data = await rootBundle.loadString('assets/amharic_bible.json');
    final jsonResult = json.decode(data) as Map<String, dynamic>;
    final books = jsonResult['books'] as List<dynamic>;

    final randomBook = books[Random().nextInt(books.length)];
    final bookTitle = randomBook['title'];
    final chapters = randomBook['chapters'] as List<dynamic>;

    final randomChapter = chapters[Random().nextInt(chapters.length)];
    final chapterNumber = randomChapter['chapter'];
    final verses = randomChapter['verses'] as List<dynamic>;

    final randomVerse = verses[Random().nextInt(verses.length)];

    setState(() {
      verseOfTheDay = "$bookTitle $chapterNumber:$randomVerse";
    });

    // Schedule the notification with the verse
    await notificationService.scheduleDailyNotification(verseOfTheDay!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Amharic Verse of the Day")),
      body: Center(
        child: verseOfTheDay == null
            ? const CircularProgressIndicator()
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      verseOfTheDay!,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // In your app's main widget or a test button:
                  ElevatedButton(
                    onPressed: () async {
                      await NotificationService()
                          .scheduleDailyNotification(verseOfTheDay!);
                      print("Notification scheduled!");
                    },
                    child: const Text("Test Notification"),
                  )
                ],
              ),
      ),
    );
  }
}
