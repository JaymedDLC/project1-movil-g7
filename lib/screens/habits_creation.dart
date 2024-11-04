import 'package:flutter/material.dart';
import '../models/habit.dart';
import '../providers/habit_provider.dart';
import 'package:provider/provider.dart';
import 'habits_frecuency.dart'; // Importa la pantalla de selección de frecuencia

class HabitCreationScreen extends StatefulWidget {
  final Habit? habit;

  const HabitCreationScreen({Key? key, this.habit}) : super(key: key);

  @override
  _HabitCreationScreenState createState() => _HabitCreationScreenState();
}

class _HabitCreationScreenState extends State<HabitCreationScreen> {
  String habitName = '';
  int frequencyValue = 1;
  FrequencyType frequencyUnit = FrequencyType.days;

  @override
  void initState() {
    super.initState();
    if (widget.habit != null) {
      habitName = widget.habit!.name;
      frequencyValue = widget.habit!.frequencyValue;
      frequencyUnit = widget.habit!.frequencyUnit;
    }
  }

  void saveHabit() {
    final habitProvider = Provider.of<HabitProvider>(context, listen: false);
    if (widget.habit == null) {
      // Crea un nuevo hábito
      habitProvider.addHabit(habitName, frequencyValue, frequencyUnit);
    } else {
      // Actualiza el hábito existente
      habitProvider.updateHabit(
          widget.habit!.id, habitName, frequencyValue, frequencyUnit);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.habit == null ? 'Crear Hábito' : 'Editar Hábito'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
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
                        builder: (context) => FrequencySelectorScreen(
                          initialFrequencyValue: frequencyValue,
                          initialFrequencyUnit: frequencyUnit,
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
