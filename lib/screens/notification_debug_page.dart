import 'package:amharic_bible_verse_app/service/notification_service.dart';
import 'package:flutter/material.dart';

class NotificationDebugScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => NotificationService().showTestNotification(),
            child: const Text('Show Immediate Notification'),
          ),
          ElevatedButton(
            onPressed: () =>
                NotificationService().scheduleDailyNotification("Test verse"),
            child: const Text('Schedule Daily Notification'),
          ),
          FutureBuilder(
            future: NotificationService().checkNotificationScheduled(),
            builder: (_, snapshot) => Text(
              'Scheduled: ${snapshot.data ?? false}',
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
