import 'package:flutter/material.dart';
import '../widgets/footer_navigation.dart';
import '../widgets/appbar.dart';
import 'package:provider/provider.dart';
import '../providers/habit_provider.dart';
import '../models/habit.dart';

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
                              _editHabit(context, habitProvider, index);
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
              _createHabit(context, habitProvider);
            },
            backgroundColor: Colors.blue,
            child: const Icon(Icons.add),
          ),
        ],
      ),
      bottomNavigationBar: const FooterNavigation(),
    );
  }

  void _createHabit(BuildContext context, HabitProvider habitProvider) {
    String habitName = '';
    int frequencyValue = 1; // Valor por defecto
    FrequencyType frequencyUnit = FrequencyType.days; // Unidad por defecto

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Crear Hábito'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    onChanged: (value) {
                      habitName = value;
                    },
                    decoration:
                        const InputDecoration(labelText: 'Nombre del hábito'),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            frequencyValue =
                                int.tryParse(value) ?? 1; // Convertir a número
                          },
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              labelText: 'Frecuencia (número)'),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      DropdownButton<FrequencyType>(
                        value: frequencyUnit,
                        onChanged: (FrequencyType? newValue) {
                          if (newValue != null) {
                            setState(() {
                              frequencyUnit = newValue;
                            });
                          }
                        },
                        items: FrequencyType.values
                            .map<DropdownMenuItem<FrequencyType>>(
                                (FrequencyType value) {
                          return DropdownMenuItem<FrequencyType>(
                            value: value,
                            child: Text(value
                                .toString()
                                .split('.')
                                .last), // Muestra solo el nombre del enum
                          );
                        }).toList(),
                      ),
                    ],
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
                    if (habitName.isNotEmpty && frequencyValue > 0) {
                      habitProvider.addHabit(habitName, frequencyValue,
                          frequencyUnit); // Agregar hábito
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Crear'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _editHabit(
      BuildContext context, HabitProvider habitProvider, int index) {
    String habitName = habitProvider.habits[index].name;
    FrequencyType frequencyUnit = habitProvider.habits[index].frequencyUnit;
    int frequencyValue = habitProvider.habits[index].frequencyValue;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
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
                    decoration:
                        const InputDecoration(labelText: 'Nombre del hábito'),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            frequencyValue =
                                int.tryParse(value) ?? 1; // Convertir a número
                          },
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              labelText: 'Frecuencia (número)'),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      DropdownButton<FrequencyType>(
                        value: frequencyUnit,
                        onChanged: (FrequencyType? newValue) {
                          if (newValue != null) {
                            setState(() {
                              frequencyUnit = newValue;
                            });
                          }
                        },
                        items: FrequencyType.values
                            .map<DropdownMenuItem<FrequencyType>>(
                                (FrequencyType value) {
                          return DropdownMenuItem<FrequencyType>(
                            value: value,
                            child: Text(value
                                .toString()
                                .split('.')
                                .last), // Muestra solo el nombre del enum
                          );
                        }).toList(),
                      ),
                    ],
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
                    habitProvider.editHabit(
                        index, habitName, frequencyValue, frequencyUnit);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Guardar'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

// Extensión para capitalizar el primer carácter
extension StringCapitalization on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
