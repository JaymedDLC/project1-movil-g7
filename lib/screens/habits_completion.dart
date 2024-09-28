import 'package:flutter/material.dart';
import '../widgets/footer_navigation.dart';
import '../widgets/appbar.dart';

class HabitCompletionScreen extends StatelessWidget {
  const HabitCompletionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: <Widget>[
          // Widget superior con porcentaje de hábitos cumplidos
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 100,
              color: Colors.grey[200], // Aquí puedes usar un gráfico o barra de progreso
              child: const Center(
                child: Text(
                  '75% de hábitos cumplidos',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          // Lista de metas y hábitos
          Expanded(
            child: ListView.builder(
              itemCount: 5, // Aquí reemplazar por la lista de hábitos reales
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.check, color: Colors.white),
                  ),
                  title: Text('Meta de Hábito ${index + 1}'), // Remover const
                  subtitle: const Text('Cada 2 horas'),
                  trailing: Checkbox(
                    value: false, // Aquí puedes conectar la lógica para marcar el hábito como cumplido
                    onChanged: (bool? value) {
                      // Manejar la lógica cuando se chequea o deschequea el hábito
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const FooterNavigation(), // Footer persistente
    );
  }
}
