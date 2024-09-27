import 'package:flutter/material.dart';

class FooterNavigation extends StatelessWidget {
  const FooterNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
        
      ],
      onTap: (index) {
        // Lógica de navegación según el índice
        if (index == 0) {
          Navigator.of(context).pushReplacementNamed('/petScreen');
        } else if (index == 1) {
          Navigator.of(context).pushReplacementNamed('/habitsCompletion');
        } else if (index == 2) {
          Navigator.of(context).pushReplacementNamed('/habitManagement');
        }
      },
    );
  }
}
