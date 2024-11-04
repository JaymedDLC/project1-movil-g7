import 'package:flutter/material.dart';
import '../models/habit.dart';

class FrequencySelectorScreen extends StatefulWidget {
  final int initialFrequencyValue;
  final FrequencyType initialFrequencyUnit;

  const FrequencySelectorScreen({
    Key? key,
    required this.initialFrequencyValue,
    required this.initialFrequencyUnit,
  }) : super(key: key);

  @override
  _FrequencySelectorScreenState createState() =>
      _FrequencySelectorScreenState();
}

class _FrequencySelectorScreenState extends State<FrequencySelectorScreen> {
  int frequencyValue = 1;
  FrequencyType frequencyUnit = FrequencyType.days;

  @override
  void initState() {
    super.initState();
    frequencyValue = widget.initialFrequencyValue;
    frequencyUnit = widget.initialFrequencyUnit;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Seleccionar Frecuencia")),
      body: Column(
        children: [
          RadioListTile(
            title: const Text("Cada X días"),
            value: FrequencyType.days,
            groupValue: frequencyUnit,
            onChanged: (value) {
              setState(() {
                frequencyUnit = value!;
              });
            },
          ),
          if (frequencyUnit == FrequencyType.days)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (frequencyValue > 2) frequencyValue--;
                    });
                  },
                ),
                Text('$frequencyValue días'),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      if (frequencyValue < 99) frequencyValue++;
                    });
                  },
                ),
              ],
            ),
          RadioListTile(
            title: const Text("Cada X horas"),
            value: FrequencyType.hours,
            groupValue: frequencyUnit,
            onChanged: (value) {
              setState(() {
                frequencyUnit = value!;
              });
            },
          ),
          if (frequencyUnit == FrequencyType.hours)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (frequencyValue > 2) frequencyValue--;
                    });
                  },
                ),
                Text('$frequencyValue horas'),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      if (frequencyValue < 99) frequencyValue++;
                    });
                  },
                ),
              ],
            ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, {
                'value': frequencyValue,
                'unit': frequencyUnit,
              });
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }
}
