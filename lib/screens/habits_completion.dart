import 'package:flutter/material.dart';
import '../widgets/footer_navigation.dart';
import '../widgets/appbar.dart';
import 'package:provider/provider.dart'; 
import '../providers/habit_provider.dart';

class HabitCompletionScreen extends StatelessWidget {
  const HabitCompletionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final habitProvider = Provider.of<HabitProvider>(context);

    int totalHabits = habitProvider.habits.length;
    int completedHabits = habitProvider.habits.where((habit) => habit.isCompleted).length;
    double completionPercentage = (totalHabits == 0) ? 0 : (completedHabits / totalHabits) * 100;


    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: <Widget>[
          // Widget superior con porcentaje de hábitos cumplidos
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 100,
              color: Colors.grey[200], 
              child: Center(
                child: Text(
                  '${completionPercentage.toStringAsFixed(0)}% de hábitos cumplidos',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          // Lista de hábitos
          Expanded(
            child: ListView.builder(
              itemCount: totalHabits,
              itemBuilder: (context, index) {
                final habit = habitProvider.habits[index];
                
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: habit.isCompleted ? Colors.green : Colors.red, // Color dependiendo de si está completado o no
                    child: Icon(
                      habit.isCompleted ? Icons.check : Icons.close, // Icono dinámico
                      color: Colors.white,
                    ),
                  ),
                  title: Text(habit.name),
                  subtitle: Text(habit.frequency),
                  trailing: Checkbox(
                    value: habit.isCompleted,
                    onChanged: (bool? value) {
                      if (value == true) {
                        _confirmCompletion(context, habitProvider, index); // Confirmar antes de
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const FooterNavigation(),
    );
  }

  // Función para mostrar un diálogo de confirmación antes de marcar como completado
  void _confirmCompletion(BuildContext context, HabitProvider habitProvider, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmación'),
          content: const Text('¿Realizaste este hábito?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo sin hacer nada
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                habitProvider.markHabitAsCompleted(index); // Marcar como completado
                Navigator.of(context).pop(); 
              },
              child: const Text('Sí'),
            ),
          ],
        );
      },
    );
  }
}
