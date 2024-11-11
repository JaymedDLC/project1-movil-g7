import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/habit.dart';
import 'dart:convert';
import 'dart:async';

class HabitProvider with ChangeNotifier {
  List<Habit> _habits = [];

  List<Habit> get habits => _habits;

  HabitProvider() {
    loadHabits();
  }

  void addHabit(String name, String description, int frequencyValue,
      FrequencyType frequencyUnit) {
    final newHabit = Habit(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      description: description,
      frequencyValue: frequencyValue,
      frequencyUnit: frequencyUnit,
      isCompleted: false,
      nextDue: DateTime.now().add(_getDuration(frequencyValue, frequencyUnit)),
    );
    _habits.add(newHabit);
    saveHabits();
    notifyListeners();

    Timer(_getDuration(frequencyValue, frequencyUnit), () {
      newHabit.isCompleted = false;
      saveHabits();
      notifyListeners();
    });
  }

  void editHabit(int index, String name, String description, int frequencyValue,
      FrequencyType frequencyUnit) {
    _habits[index] = Habit(
      id: _habits[index].id,
      name: name,
      description: description,
      frequencyValue: frequencyValue,
      frequencyUnit: frequencyUnit,
      isCompleted: false,
      nextDue: DateTime.now().add(_getDuration(frequencyValue, frequencyUnit)),
    );
    saveHabits();
    notifyListeners();

    Timer(_getDuration(frequencyValue, frequencyUnit), () {
      _habits[index].isCompleted = false;
      saveHabits();
      notifyListeners();
    });
  }

  void deleteHabit(String id) {
    _habits.removeWhere((habit) => habit.id == id);
    saveHabits();
    notifyListeners();
  }

  void markHabitAsCompleted(int index) {
    _habits[index] = Habit(
      id: _habits[index].id,
      name: _habits[index].name,
      description: _habits[index].description,
      frequencyValue: _habits[index].frequencyValue,
      frequencyUnit: _habits[index].frequencyUnit,
      isCompleted: true,
      nextDue: _habits[index].nextDue,
    );
    saveHabits();
    notifyListeners();

    Timer(
        _getDuration(
            _habits[index].frequencyValue, _habits[index].frequencyUnit), () {
      _habits[index].isCompleted = false;
      saveHabits();
      notifyListeners();
    });
  }

  Duration _getDuration(int frequencyValue, FrequencyType frequencyUnit) {
    switch (frequencyUnit) {
      case FrequencyType.hours:
        return Duration(hours: frequencyValue);
      case FrequencyType.days:
        return Duration(days: frequencyValue);
      case FrequencyType.months:
        return Duration(days: frequencyValue * 30);
      default:
        return Duration.zero;
    }
  }

  Future<void> saveHabits() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> habitStrings =
        _habits.map((habit) => habitToJson(habit)).toList();
    await prefs.setStringList('habits', habitStrings);
  }

  Future<void> loadHabits() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? habitStrings = prefs.getStringList('habits');
    if (habitStrings != null) {
      _habits = habitStrings
          .map((habitString) => habitFromJson(habitString))
          .toList();
      notifyListeners();
    }
  }

  String habitToJson(Habit habit) {
    final Map<String, dynamic> habitData = {
      'id': habit.id,
      'name': habit.name,
      'description': habit.description,
      'frequencyValue': habit.frequencyValue,
      'frequencyUnit': habit.frequencyUnit.index,
      'isCompleted': habit.isCompleted,
      'nextDue': habit.nextDue.toIso8601String(),
    };
    return jsonEncode(habitData);
  }

  Habit habitFromJson(String jsonString) {
    final Map<String, dynamic> habitData = jsonDecode(jsonString);
    return Habit(
      id: habitData['id'],
      name: habitData['name'],
      description: habitData['description'],
      frequencyValue: habitData['frequencyValue'],
      frequencyUnit: FrequencyType.values[habitData['frequencyUnit']],
      isCompleted: habitData['isCompleted'],
      nextDue: DateTime.parse(habitData['nextDue']),
    );
  }
}
