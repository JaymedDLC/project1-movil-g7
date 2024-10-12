import 'package:flutter/material.dart';
import '../models/habit.dart';
import '../services/notification_service.dart';

class NotificationProvider with ChangeNotifier {
  final NotificationService _notificationService = NotificationService();

  void scheduleHabitNotification(Habit habit) {
    DateTime now = DateTime.now();
    if (habit.nextDue.isAfter(now)) {
      _notificationService.scheduleNotification(
        habit.id,
        'Recordatorio de Hábito',
        'Es hora de completar el hábito ${habit.name}',
        habit.nextDue,
      );
    }
  }

  void cancelHabitNotification(String habitId) {
    _notificationService.cancelNotification(habitId);
  }
}
