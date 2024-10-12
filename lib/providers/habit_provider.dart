import 'package:flutter/material.dart';

class Habit {
  String name;
  String frequency;
  bool isCompleted;

  Habit({
    required this.name,
    required this.frequency,
    this.isCompleted = false, // Inicialmente no está completado
  });
}

class HabitProvider with ChangeNotifier {
  List<Habit> _habits = [
    Habit(name: 'Ejercicio', frequency: 'Diario'),
    Habit(name: 'Leer', frequency: 'Cada 2 días'),
    // Agrega más hábitos según sea necesario
  ];

  List<Habit> get habits => _habits;

  // Función para marcar un hábito como completado
  void markHabitAsCompleted(int index) {
    _habits[index].isCompleted = true;
    notifyListeners(); // Notificar cambios
  }

  // Función para agregar un hábito
  void addHabit(String name, String frequency) {
    _habits.add(Habit(name: name, frequency: frequency));
    notifyListeners();
  }

  // Función para editar un hábito
  void editHabit(int index, String name, String frequency) {
    _habits[index].name = name;
    _habits[index].frequency = frequency;
    notifyListeners();
  }

  // Función para eliminar un hábito
  void deleteHabit(int index) {
    _habits.removeAt(index);
    notifyListeners();
  }
}
