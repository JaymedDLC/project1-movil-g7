import 'package:flutter/material.dart';
import '../widgets/footer_navigation.dart';
import '../widgets/appbar.dart';

class HabitManagementScreen extends StatelessWidget {
  const HabitManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: 5, // Aquí reemplazar por la lista de hábitos reales
              itemBuilder: (context, index) {
                return ExpansionTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.cabin, color: Colors.white), // Icono de hábito
                  ),
                  title: Text('Hábito ${index + 1}'), // Remover const
                  subtitle: const Text('Cada 2 horas'),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Diagrama de completado: 50%'),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Lógica para activar o desactivar el hábito
                                },
                                child: const Text('Activar/Desactivar'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Lógica para editar o eliminar el hábito
                                },
                                child: const Text('Editar/Eliminar'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              // Lógica para crear un nuevo hábito
            },
            backgroundColor: Colors.blue,
            child: const Icon(Icons.add),
          ),
        ],
      ),
      bottomNavigationBar: const FooterNavigation(), // Footer persistente
    );
  }
}
