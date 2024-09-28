import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class FooterNavigation extends StatelessWidget {
  const FooterNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BottomNavProvider>(context); // Obtiene el proveedor

    return Column(
      mainAxisSize: MainAxisSize.min, // Ajusta el tamaño de la columna
      children: [
        BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.pets),
              label: 'Mascota',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.check_box),
              label: 'Hábitos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit),
              label: 'Modificar Hábitos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Calendario',
            ),
          ],
          currentIndex: provider.currentIndex, // Usa el índice del provider
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            provider.updateIndex(index); // Actualiza el índice en el provider

            // Lógica de navegación según el índice
            if (index == 0) {
              Navigator.of(context).pushReplacementNamed('/petScreen');
            } else if (index == 1) {
              Navigator.of(context).pushReplacementNamed('/habitsCompletion');
            } else if (index == 2) {
              Navigator.of(context).pushReplacementNamed('/habitManagement');
            } else if (index == 3) {
              Navigator.of(context).pushReplacementNamed('/calendar');
            }
          },
        ),
        // Cuadro para mostrar el índice actual
/*        Container(
          padding: const EdgeInsets.all(8.0),
          color: Colors.grey[300],
          child: Text(
            'Índice actual: ${provider.currentIndex}', // Muestra el índice actual
            style: const TextStyle(fontSize: 16),
          ),
        ),*/
      ],
    );
  }
}
