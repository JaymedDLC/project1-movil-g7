import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Paquete para trabajar con fechas
import '../widgets/footer_navigation.dart';
import '../widgets/appbar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime selectedDate = DateTime.now(); // Fecha seleccionada (mes)
  DateTime today = DateTime.now(); // Fecha actual para comparar
  Map<DateTime, bool> streakDays =
      {}; // Mapa para rastrear rachas de días completados

  // Método para calcular los días en un mes
  int _daysInMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0).day;
  }

  // Navegar al mes anterior
  void _previousMonth() {
    setState(() {
      selectedDate = DateTime(selectedDate.year, selectedDate.month - 1);
    });
  }

  // Navegar al siguiente mes
  void _nextMonth() {
    setState(() {
      selectedDate = DateTime(selectedDate.year, selectedDate.month + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    int daysInMonth = _daysInMonth(selectedDate);

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          // Sección superior con el mes y los botones de navegación
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _previousMonth,
              ),
              Text(
                DateFormat.yMMMM()
                    .format(selectedDate), // Muestra el mes y año actual
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: _nextMonth,
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Vista en cuadrícula para mostrar los días del mes
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: daysInMonth,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7, // Días de la semana
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemBuilder: (context, index) {
                DateTime day =
                    DateTime(selectedDate.year, selectedDate.month, index + 1);
                bool isToday = day.year == today.year &&
                    day.month == today.month &&
                    day.day == today.day;

                bool isInStreak = streakDays[day] ??
                    false; // Verifica si el día es parte de una racha

                return GestureDetector(
                  onTap: () {
                    // Lógica para marcar un día como completado y parte de una racha
                    setState(() {
                      streakDays[day] = !(streakDays[day] ?? false);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isInStreak ? Colors.green : Colors.blueGrey[100],
                      shape: BoxShape.circle, // Hace que el borde sea circular
                      border: Border.all(
                        color: isToday ? Colors.blue : Colors.transparent,
                        width: isToday ? 2.0 : 0.0,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: isToday ? Colors.blue : Colors.black,
                        fontWeight:
                            isToday ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const FooterNavigation(), // Pie de navegación
    );
  }
}
