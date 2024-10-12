import 'package:flutter/material.dart';
import '../widgets/footer_navigation.dart';
import '../widgets/appbar.dart';
import 'shop_screen.dart'; 

class PetScreen extends StatefulWidget {
  const PetScreen({super.key});

  @override
  _PetScreenState createState() => _PetScreenState();
}

class _PetScreenState extends State<PetScreen> {
  int streak = 0; // Nivel de la racha

  // Función para aumentar la racha
  void increaseStreak() {
    setState(() {
      streak++;
    });
  }

  // Función para obtener el color basado en el gradiente de racha
  Color getStreakColor() {
    // De 0 a 5 va de azul a amarillo, y de 5 a 10 va de amarillo a rojo
    if (streak <= 5) {
      // Interpolar entre azul y amarillo
      return Color.lerp(Colors.blue, Colors.yellow, streak / 5)!;
    } else {
      // Interpolar entre amarillo y rojo
      return Color.lerp(Colors.yellow, Colors.red, (streak - 5) / 5)!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Stack(
        children: [
          Column(
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
              const SizedBox(height: 10),
              Container(
                height: 20,
                width: double.infinity,
                color: Colors.green,
                child: const Center(
                  child: Text(
                    'Estado: Saludable',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Ícono de racha con color dinámico basado en gradiente
              Icon(
                Icons.whatshot,
                color: getStreakColor(),
                size: 50,
              ),
              const SizedBox(height: 10),
              Text('Racha: $streak'),

              // Botón para aumentar la racha
              ElevatedButton(
                onPressed: increaseStreak,
                child: const Text('Aumentar Racha'),
              ),
            ],
          ),
          // Botón cuadrado de la tienda en la esquina inferior derecha
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ShopScreen()),
                );
              },
              backgroundColor: const Color.fromARGB(255, 38, 186, 192),
              child: const Icon(Icons.store),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const FooterNavigation(),
    );
  }
}
