import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class FooterNavigation extends StatelessWidget {
  const FooterNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BottomNavProvider>(context);

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
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Calendario',
        ),
      ],
      currentIndex: provider.currentIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        if (provider.currentIndex != index) {
          provider.updateIndex(index);
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/petScreen');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/habitsCompletion');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/habitManagement');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/calendar');
              break;
          }
        }
      },
    );
  }
}
