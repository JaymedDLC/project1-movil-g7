import 'package:flutter/material.dart';
import 'calendar.dart';
import 'login.dart'; // Asegúrate de tener esta importación

class WelcomeScreen extends StatelessWidget {
  final String username;

  const WelcomeScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Regresar a la pantalla de login y eliminar todas las anteriores
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body: Center(
        child: Text(
          '¡Hola, $username!',
          style: const TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pending),
            label: 'Pendiente',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pending),
            label: 'Pendiente',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            // Redirigir a la pantalla de Welcome (mismo comportamiento)
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => WelcomeScreen(username: username),
              ),
            );
          } else if (index == 1) {
            // Redirigir a la pantalla de Calendar y reemplazar Welcome en la pila
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const CalendarScreen(),
              ),
            );
          }
        },
      ),
    );
  }
}
