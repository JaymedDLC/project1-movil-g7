import 'package:flutter/material.dart';
import '../widgets/footer_navigation.dart';
import '../widgets/appbar.dart';
import 'package:provider/provider.dart'; 
import '../providers/habit_provider.dart'; 


class HabitManagementScreen extends StatelessWidget {
  const HabitManagementScreen({super.key});

    @override
  Widget build(BuildContext context) {
    final habitProvider = Provider.of<HabitProvider>(context); // Acceder al HabitProvider

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: habitProvider.habits.length, // Mostrar la lista de hábitos reales
              itemBuilder: (context, index) {
                final habit = habitProvider.habits[index];
                return ExpansionTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.cabin, color: Colors.white), // Icono de hábito
                  ),
                  title: Text(habit.name), // Mostrar el nombre del hábito
                  subtitle: Text(habit.frequency), // Mostrar la frecuencia del hábito
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _editHabit(context, habitProvider, index); // Editar hábito
                            },
                            child: const Text('Editar'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              habitProvider.deleteHabit(index); // Eliminar hábito
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
              _createHabit(context, habitProvider); // Crear nuevo hábito
            },
            backgroundColor: Colors.blue,
            child: const Icon(Icons.add),
          ),
        ],
      ),
      bottomNavigationBar: const FooterNavigation(), // Footer persistente
    );
  }

  void _createHabit(BuildContext context, HabitProvider habitProvider) {
    String habitName = '';
    String habitFrequency = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Crear Hábito'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  habitName = value;
                },
                decoration: const InputDecoration(labelText: 'Nombre del hábito'),
              ),
              TextField(
                onChanged: (value) {
                  habitFrequency = value;
                },
                decoration: const InputDecoration(labelText: 'Frecuencia (ej. Diariamente)'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (habitName.isNotEmpty && habitFrequency.isNotEmpty) {
                  habitProvider.addHabit(habitName, habitFrequency); // Agregar hábito
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Crear'),
            ),
          ],
        );
      },
    );
  }

  void _editHabit(BuildContext context, HabitProvider habitProvider, int index) {
    String habitName = habitProvider.habits[index].name;
    String habitFrequency = habitProvider.habits[index].frequency;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Hábito'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: TextEditingController(text: habitName),
                onChanged: (value) {
                  habitName = value;
                },
                decoration: const InputDecoration(labelText: 'Nombre del hábito'),
              ),
              TextField(
                controller: TextEditingController(text: habitFrequency),
                onChanged: (value) {
                  habitFrequency = value;
                },
                decoration: const InputDecoration(labelText: 'Frecuencia (ej. Diariamente)'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                habitProvider.editHabit(index, habitName, habitFrequency); // Editar hábito
                Navigator.of(context).pop();
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }
}
