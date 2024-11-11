class Habit {
  final String id;
  final String name;
  final String description; // Nuevo campo de descripción
  final FrequencyType frequencyUnit;
  bool isCompleted;
  DateTime nextDue;

  // Propiedades para soportar diferentes tipos de frecuencia
  int frequencyValue; // Valor genérico para el intervalo (días u horas)
  List<String>?
      specificDays; // Días específicos de la semana para frecuencia semanal

  Habit({
    required this.id,
    required this.name,
    required this.description, // Inicializar la descripción
    required this.frequencyUnit,
    this.isCompleted = false,
    required this.nextDue,
    this.frequencyValue =
        2, // Valor por defecto de 2 para intervalos de días/horas
    this.specificDays, // Lista opcional para días específicos
  });

  // Actualizar la fecha de la próxima vez que se debe cumplir el hábito
  void updateNextDue() {
    switch (frequencyUnit) {
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
      case FrequencyType.weekly:
        if (specificDays != null && specificDays!.isNotEmpty) {
          // Si hay días específicos seleccionados, se ajusta al siguiente día
          nextDue = _getNextSpecificDay();
        } else {
          // En caso de que no haya días específicos, se incrementa en una semana
          nextDue = nextDue.add(const Duration(days: 7));
        }
        break;
    }
  }

  // Obtener la fecha del próximo día específico seleccionado
  DateTime _getNextSpecificDay() {
    DateTime today = DateTime.now();
    int currentWeekday = today.weekday; // Lunes = 1, Domingo = 7

    for (int i = 0; i < 7; i++) {
      DateTime checkDate = today.add(Duration(days: i));
      String dayName = _weekdayToString(checkDate.weekday);
      if (specificDays!.contains(dayName)) {
        return checkDate;
      }
    }
    // Si no se encontró un día específico, se retorna la fecha de hoy como fallback
    return today;
  }

  // Convertir el índice del día de la semana a su nombre en español
  String _weekdayToString(int weekday) {
    switch (weekday) {
      case 1:
        return "Lunes";
      case 2:
        return "Martes";
      case 3:
        return "Miércoles";
      case 4:
        return "Jueves";
      case 5:
        return "Viernes";
      case 6:
        return "Sábado";
      case 7:
        return "Domingo";
      default:
        return "";
    }
  }
}

// Enum actualizado para incluir la opción semanal
enum FrequencyType {
  hours,
  days,
  months,
  weekly, // Nueva opción para frecuencia semanal
}
