import 'package:flutter/material.dart';
import 'package:project1_movil_g7/screens/login.dart';
import 'package:project1_movil_g7/screens/habits_completion.dart';
import 'package:project1_movil_g7/screens/habits_management.dart';
import 'package:project1_movil_g7/screens/pet_screen.dart';

void main() {
  runApp(const MyApp());
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
      },
    );
  }
}
