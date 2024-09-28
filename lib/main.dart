import 'package:flutter/material.dart';
import 'package:project1_movil_g7/screens/calendar.dart';
import 'package:project1_movil_g7/screens/login.dart';
import 'package:project1_movil_g7/screens/habits_completion.dart';
import 'package:project1_movil_g7/screens/habits_management.dart';
import 'package:project1_movil_g7/screens/pet_screen.dart';
import 'package:provider/provider.dart'; // Importa el paquete provider

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => BottomNavProvider(), // Proporciona el BottomNavProvider
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trackeo de Hábitos Saludables',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login', // Inicia en el login
      routes: {
        '/login': (context) => const LoginScreen(),
        '/habitsCompletion': (context) => const HabitCompletionScreen(),
        '/habitManagement': (context) => const HabitManagementScreen(),
        '/petScreen': (context) => const PetScreen(),
        '/calendar': (context) => const CalendarScreen(),
      },
    );
  }
}

// Clase para manejar el estado del índice del BottomNavigationBar
class BottomNavProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
