import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService() {
    _initializeNotifications();
    tz.initializeTimeZones(); // Inicializa las zonas horarias
  }

  void _initializeNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleNotification(
    String id,
    String title,
    String body,
    DateTime scheduledTime,
  ) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'habit_channel_id', // id del canal
      'Hábito Recordatorio', // nombre del canal
      channelDescription: 'Notificaciones de recordatorio de hábitos', // descripción del canal
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    // Convertir DateTime a TZDateTime
    final tz.TZDateTime tzScheduledTime = tz.TZDateTime.from(scheduledTime, tz.local);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      int.parse(id), // Convierte id a int si es necesario
      title,
      body,
      tzScheduledTime,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> cancelNotification(String id) async {
    await flutterLocalNotificationsPlugin.cancel(int.parse(id));
  }
}
