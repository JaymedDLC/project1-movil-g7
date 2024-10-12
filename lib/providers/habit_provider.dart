import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/habit.dart';
import 'dart:convert';
import 'dart:async'; // Importar para usar

class HabitProvider with ChangeNotifier {
  List<Habit> _habits = [];

  List<Habit> get habits => _habits;

  HabitProvider() {
    loadHabits(); // Cargar hábitos almacenados
  }

  void addHabit(String name, int frequencyValue, FrequencyType frequencyUnit) {
    final newHabit = Habit(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      frequencyValue: frequencyValue,
      frequencyUnit: frequencyUnit,
      isCompleted: false,
      nextDue: DateTime.now().add(_getDuration(frequencyValue, frequencyUnit)), // Calcular próxima fecha de vencimiento
    );
    _habits.add(newHabit);
    saveHabits();
    notifyListeners();

    // Desmarcar el hábito después de la frecuencia especificada
    Timer(_getDuration(frequencyValue, frequencyUnit), () {
      newHabit.isCompleted = false; // Desmarcar el hábito
      saveHabits(); // Guardar los cambios
      notifyListeners(); // Notificar a los listeners
    });
  }

  void editHabit(int index, String name, int frequencyValue, FrequencyType frequencyUnit) {
    _habits[index] = Habit(
      id: _habits[index].id,
      name: name,
      frequencyValue: frequencyValue,
      frequencyUnit: frequencyUnit,
      isCompleted: false,
      nextDue: DateTime.now().add(_getDuration(frequencyValue, frequencyUnit)), // Actualizar la próxima fecha de vencimiento
    );
    saveHabits();
    notifyListeners();

    // Desmarcar el hábito después de la frecuencia especificada
    Timer(_getDuration(frequencyValue, frequencyUnit), () {
      _habits[index].isCompleted = false; // Desmarcar el hábito
      saveHabits(); // Guardar los cambios
      notifyListeners(); // Notificar a los listeners
    });
  }

  void markHabitAsCompleted(int index) {
    _habits[index] = Habit(
      id: _habits[index].id,
      name: _habits[index].name,
      frequencyValue: _habits[index].frequencyValue,
      frequencyUnit: _habits[index].frequencyUnit,
      isCompleted: true,
      nextDue: _habits[index].nextDue,
    );
    saveHabits();
    notifyListeners();

    // Desmarcar el hábito después de la frecuencia especificada
    Timer(_getDuration(_habits[index].frequencyValue, _habits[index].frequencyUnit), () {
      _habits[index].isCompleted = false; // Desmarcar el hábito
      saveHabits(); // Guardar los cambios
      notifyListeners(); // Notificar a los listeners
    });
  }

  Duration _getDuration(int frequencyValue, FrequencyType frequencyUnit) {
    switch (frequencyUnit) {
      case FrequencyType.seconds:
        return Duration(seconds: frequencyValue);
      case FrequencyType.minutes:
        return Duration(minutes: frequencyValue);
      case FrequencyType.hours:
        return Duration(hours: frequencyValue);
      case FrequencyType.days:
        return Duration(days: frequencyValue);
      case FrequencyType.months:
        return Duration(days: frequencyValue * 30); // Aproximación
      default:
        return Duration.zero;
    }
  }

  // Métodos para guardar y cargar los hábitos (con shared_preferences)

  Future<void> saveHabits() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> habitStrings = _habits.map((habit) => habitToJson(habit)).toList();
    await prefs.setStringList('habits', habitStrings);
  }

  Future<void> loadHabits() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? habitStrings = prefs.getStringList('habits');
    if (habitStrings != null) {
      _habits = habitStrings.map((habitString) => habitFromJson(habitString)).toList();
      notifyListeners();
    }
  }

  String habitToJson(Habit habit) {
    final Map<String, dynamic> habitData = {
      'id': habit.id,
      'name': habit.name,
      'frequencyValue': habit.frequencyValue,
      'frequencyUnit': habit.frequencyUnit.index, // Guardar el índice del enum
      'isCompleted': habit.isCompleted,
      'nextDue': habit.nextDue.toIso8601String(), // Convertir DateTime a String
    };
    return jsonEncode(habitData);
  }

  Habit habitFromJson(String jsonString) {
    final Map<String, dynamic> habitData = jsonDecode(jsonString);
    return Habit(
      id: habitData['id'],
      name: habitData['name'],
      frequencyValue: habitData['frequencyValue'],
      frequencyUnit: FrequencyType.values[habitData['frequencyUnit']], // Convertir índice a enum
      isCompleted: habitData['isCompleted'],
      nextDue: DateTime.parse(habitData['nextDue']), // Convertir String a DateTime
    );
  }

  void deleteHabit(String id) {
    _habits.removeWhere((habit) => habit.id == id);
    saveHabits();
    notifyListeners();
  }
}
