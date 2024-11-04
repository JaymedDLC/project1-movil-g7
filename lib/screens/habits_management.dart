import 'package:flutter/material.dart';
import '../widgets/footer_navigation.dart';
import '../widgets/appbar.dart';
import 'package:provider/provider.dart';
import '../providers/habit_provider.dart';
import '../models/habit.dart';
import 'habits_creation.dart'; // Importa la nueva pantalla de creación/edición

class HabitManagementScreen extends StatelessWidget {
  const HabitManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final habitProvider = Provider.of<HabitProvider>(context);

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: habitProvider.habits.length,
              itemBuilder: (context, index) {
                final habit = habitProvider.habits[index];
                return ExpansionTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.cabin, color: Colors.white),
                  ),
                  title: Text(habit.name),
                  subtitle: Text(
                      '${habit.frequencyValue} ${habit.frequencyUnit.toString().split('.').last}'),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Redirige a la pantalla de edición de hábito
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HabitCreationScreen(
                                    habit: habit, // Pasa el hábito para editar
                                  ),
                                ),
                              );
                            },
                            child: const Text('Editar'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              habitProvider.deleteHabit(habit.id);
                            },
                            child: const Text('Eliminar'),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              // Redirige a la pantalla de creación de hábito
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HabitCreationScreen(),
                ),
              );
            },
            backgroundColor: Colors.blue,
            child: const Icon(Icons.add),
          ),
        ],
      ),
      bottomNavigationBar: const FooterNavigation(),
    );
  }
}
