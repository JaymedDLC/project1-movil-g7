import 'package:flutter/material.dart';
import '../models/habit.dart';
import '../providers/habit_provider.dart';
import 'package:provider/provider.dart';
import 'habits_frecuency.dart';

class HabitCreationScreen extends StatefulWidget {
  final Habit? habit;

  const HabitCreationScreen({super.key, this.habit});

  @override
  _HabitCreationScreenState createState() => _HabitCreationScreenState();
}

class _HabitCreationScreenState extends State<HabitCreationScreen> {
  String habitName = '';
  String habitDescription = '';
  int frequencyValue = 1;
  FrequencyType frequencyUnit = FrequencyType.days;

  @override
  void initState() {
    super.initState();
    if (widget.habit != null) {
      habitName = widget.habit!.name;
      habitDescription = widget.habit!.description;
      frequencyValue = widget.habit!.frequencyValue;
      frequencyUnit = widget.habit!.frequencyUnit;
    }
  }

  void saveHabit() {
    final habitProvider = Provider.of<HabitProvider>(context, listen: false);
    if (habitName.isEmpty || frequencyValue <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, complete todos los campos.')),
      );
      return;
    }

    if (widget.habit == null) {
      habitProvider.addHabit(
          habitName, habitDescription, frequencyValue, frequencyUnit);
    } else {
      habitProvider.editHabit(
        _getIndex(widget.habit!.id),
        habitName,
        habitDescription,
        frequencyValue,
        frequencyUnit,
      );
    }
  }

  int _getIndex(String id) {
    return Provider.of<HabitProvider>(context, listen: false)
        .habits
        .indexWhere((habit) => habit.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.habit == null ? 'Crear Hábito' : 'Editar Hábito'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            saveHabit();
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (value) {
                habitName = value;
              },
              controller: TextEditingController(text: habitName),
              decoration: const InputDecoration(labelText: 'Nombre del hábito'),
            ),
            const SizedBox(height: 16),
            TextField(
              onChanged: (value) {
                habitDescription = value;
              },
              controller: TextEditingController(text: habitDescription),
              decoration:
                  const InputDecoration(labelText: 'Descripción del hábito'),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "Frecuencia: $frequencyValue ${frequencyUnit.toString().split('.').last}"),
                ElevatedButton(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HabitFrequencySelector(
                          onSave: (FrequencyType selectedUnit,
                              int selectedValue, List<String>? otherData) {
                            setState(() {
                              frequencyUnit = selectedUnit;
                              frequencyValue = selectedValue;
                            });
                          },
                        ),
                      ),
                    );

                    if (result != null) {
                      setState(() {
                        frequencyValue = result['value'];
                        frequencyUnit = result['unit'];
                      });
                    }
                  },
                  child: const Text('Seleccionar Frecuencia'),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                saveHabit();
                Navigator.pop(context);
              },
              child: const Text('Confirmar'),
            ),
          ],
        ),
      ),
    );
  }
}
