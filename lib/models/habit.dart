class Habit {
  final String id;
  final String name;
  final int frequencyValue;
  final FrequencyType frequencyUnit;
  bool isCompleted; // Cambiar 'final' a 'bool'
  DateTime nextDue;

  Habit({
    required this.id,
    required this.name,
    required this.frequencyValue,
    required this.frequencyUnit,
    this.isCompleted = false, // Valor por defecto
    required this.nextDue,
  });

  // Actualizar la fecha de la próxima vez que se debe cumplir el hábito
  void updateNextDue() {
    switch (frequencyUnit) {
      case FrequencyType.seconds:
        nextDue = nextDue.add(const Duration(seconds: 1)); // Solo para debug
        break;
      case FrequencyType.minutes:
        nextDue = nextDue.add(Duration(minutes: frequencyValue));
        break;
      case FrequencyType.hours:
        nextDue = nextDue.add(Duration(hours: frequencyValue));
        break;
      case FrequencyType.days:
        nextDue = nextDue.add(Duration(days: frequencyValue));
        break;
      case FrequencyType.months:
        nextDue = DateTime(
          nextDue.year,
          nextDue.month + frequencyValue,
          nextDue.day,
        ); // Para meses, se incrementa el mes
        break;
    }
  }
}

enum FrequencyType {
  seconds,
  minutes,
  hours,
  days,
  months,
}
