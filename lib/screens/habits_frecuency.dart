import 'package:flutter/material.dart';
import '../models/habit.dart';

class HabitFrequencySelector extends StatefulWidget {
  final Function(FrequencyType, int, List<String>?) onSave;

  HabitFrequencySelector({required this.onSave});

  @override
  _HabitFrequencySelectorState createState() => _HabitFrequencySelectorState();
}

class _HabitFrequencySelectorState extends State<HabitFrequencySelector> {
  FrequencyType? selectedFrequencyType; // Tipo de frecuencia seleccionada
  int intervalValue = 2; // Valor por defecto del intervalo (en días/horas)
  Map<String, bool> weekDays = {
    "Lunes": false,
    "Martes": false,
    "Miércoles": false,
    "Jueves": false,
    "Viernes": false,
    "Sábado": false,
    "Domingo": false,
  };

  void saveData() {
    List<String>? selectedDays;
    if (selectedFrequencyType == FrequencyType.weekly) {
      selectedDays = weekDays.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key)
          .toList();
    }
    widget.onSave(selectedFrequencyType ?? FrequencyType.days, intervalValue,
        selectedDays);
    print("Frecuencia seleccionada: $selectedFrequencyType");
    print("Intervalo: $intervalValue");
    print("Días específicos seleccionados: $selectedDays");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seleccionar Frecuencia"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            saveData();
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          RadioListTile(
            title: Text("Diariamente, cada X horas"),
            value: FrequencyType.hours,
            groupValue: selectedFrequencyType,
            onChanged: (value) {
              setState(() {
                selectedFrequencyType = value as FrequencyType;
              });
            },
          ),
          if (selectedFrequencyType == FrequencyType.hours)
            buildIntervalSelector("Cada", "horas", 2, 12),
          RadioListTile(
            title: Text("Cada X días"),
            value: FrequencyType.days,
            groupValue: selectedFrequencyType,
            onChanged: (value) {
              setState(() {
                selectedFrequencyType = value as FrequencyType;
              });
            },
          ),
          if (selectedFrequencyType == FrequencyType.days)
            buildIntervalSelector("Cada", "días", 2, 99),
          RadioListTile(
            title: Text("Días específicos de la semana"),
            value: FrequencyType.weekly,
            groupValue: selectedFrequencyType,
            onChanged: (value) {
              setState(() {
                selectedFrequencyType = value as FrequencyType;
              });
            },
          ),
          if (selectedFrequencyType == FrequencyType.weekly)
            ...weekDays.keys.map((day) {
              return CheckboxListTile(
                title: Text(day),
                value: weekDays[day],
                onChanged: (value) {
                  setState(() {
                    weekDays[day] = value!;
                  });
                },
              );
            }).toList(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                saveData();
                Navigator.pop(context);
              },
              child: Text("Guardar"),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIntervalSelector(String prefix, String unit, int min, int max) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Text("$prefix"),
          SizedBox(width: 10),
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              setState(() {
                if (intervalValue > min) intervalValue--;
              });
            },
          ),
          Text("$intervalValue $unit"),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                if (intervalValue < max) intervalValue++;
              });
            },
          ),
        ],
      ),
    );
  }
}
