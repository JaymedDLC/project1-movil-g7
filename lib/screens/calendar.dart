import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Paquete para trabajar con fechas
import 'package:project1_movil_g7/widgets/footer_navigation.dart';
import 'welcome.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    int daysInMonth = DateTime(now.year, now.month + 1, 0).day;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendario'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Regresar directamente a Welcome
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const WelcomeScreen(username: "Usuario"),
              ),
            );
          },
        ),
      ),
      body: Column(
        children: [
          // Texto de "Progreso completado!" en una sección separada
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.blue[900], // Fondo para denotar separación
            child: const Text(
              'Progreso completado!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20), // Espacio entre el texto y el calendario
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: daysInMonth,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7, // Días de la semana
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                ),
                itemBuilder: (context, index) {
                  DateTime day = DateTime(now.year, now.month, index + 1);
                  bool isPast = day.isBefore(now);

                  return Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isPast ? Colors.blueGrey : Colors.blue[300], // Diferencia de colores
                      borderRadius: BorderRadius.circular(10), // Redondeo de los días
                    ),
                    child: Text(
                      DateFormat.d().format(day),
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const FooterNavigation(),
    );
  }
}
