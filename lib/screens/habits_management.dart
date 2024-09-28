import 'package:flutter/material.dart';
import 'package:project1_movil_g7/widgets/footer_navigation.dart';

class HabitManagementScreen extends StatelessWidget {
  const HabitManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Elimina la flecha de retroceso
        title: const Text('Gestión de Hábitos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // Lógica para cerrar sesión
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Cerrar sesión'),
                    content: const Text('¿Seguro que quieres cerrar sesión?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Cierra el diálogo
                        },
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/login');
                        },
                        child: const Text('Cerrar sesión'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
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
