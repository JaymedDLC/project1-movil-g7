import 'package:flutter/material.dart';
import 'package:project1_movil_g7/widgets/footer_navigation.dart';

class PetScreen extends StatelessWidget {
  const PetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  automaticallyImplyLeading: false, // Evita que aparezca la flecha
  title: const Text('Mascota'),
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
          const SizedBox(height: 20),
          Image.asset(
            'assets/pet.png',
            height: 200,
            width: 200,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20),
          const Text(
            'Estado de la mascota',
            style: TextStyle(fontSize: 24),
          ),
          // Barra de estado de la mascota
          const SizedBox(height: 10),
          Container(
            height: 20,
            width: double.infinity,
            color: Colors.green, // Cambia de color según el estado
            child: const Center(
              child: Text(
                'Estado: Saludable',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Grid de artículos para la mascota
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Dos columnas
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1, // Cuadrados
              ),
              itemCount: 4, // Cambia según la cantidad de artículos
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Aquí implementas la lógica para comprar el artículo
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.shopping_bag, size: 50), // Ícono del artículo
                        const SizedBox(height: 10),
                        Text('Artículo $index'),
                      ],
                    ),
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
