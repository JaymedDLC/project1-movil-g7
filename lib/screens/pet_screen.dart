import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/footer_navigation.dart';
import '../widgets/appbar.dart';
import 'shop_screen.dart';
import '../providers/habit_provider.dart';
import 'habits_completion.dart'; // Importar la pantalla de confirmación de hábitos

class PetScreen extends StatefulWidget {
  const PetScreen({super.key});

  @override
  _PetScreenState createState() => _PetScreenState();
}

class _PetScreenState extends State<PetScreen> {
  int streak = 0; // Nivel de la racha
  int coins = 200; // Monedas iniciales del usuario

  // Función para aumentar la racha
  void increaseStreak() {
    setState(() {
      streak++;
    });
  }

  // Función para obtener el color basado en el gradiente de racha
  Color getStreakColor() {
    if (streak <= 5) {
      return Color.lerp(Colors.blue, Colors.yellow, streak / 5)!;
    } else {
      return Color.lerp(Colors.yellow, Colors.red, (streak - 5) / 5)!;
    }
  }

  // Filtrar los próximos hábitos no completados
  List<dynamic> getNextHabits(HabitProvider habitProvider) {
    return habitProvider.habits
        .where((habit) => !habit.isCompleted)
        .take(2)
        .toList();
  }

  // Función para capitalizar un string
  String capitalize(String text) {
    if (text.isEmpty) return text;
    return '${text[0].toUpperCase()}${text.substring(1)}';
  }

  @override
  Widget build(BuildContext context) {
    final habitProvider = Provider.of<HabitProvider>(context);
    int totalHabits = habitProvider.habits.length;
    int completedHabits =
        habitProvider.habits.where((h) => h.isCompleted).length;
    double completionPercentage =
        totalHabits == 0 ? 0 : (completedHabits / totalHabits) * 100;
    final nextHabits = getNextHabits(habitProvider);

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
              const SizedBox(height: 10),

              // Monedas del usuario
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.monetization_on, color: Colors.amber),
                  const SizedBox(width: 5),
                  Text('$coins monedas', style: const TextStyle(fontSize: 18)),
                ],
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

              // Ícono de racha
              Icon(
                Icons.whatshot,
                color: getStreakColor(),
                size: 50,
              ),
              const SizedBox(height: 10),
              Text('¡Llevas una racha de $streak días!'),

              // Barra de progreso del día
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      value: completionPercentage / 100,
                      backgroundColor: Colors.grey[300],
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Progreso del día: ${completionPercentage.toStringAsFixed(0)}%',
                      style: const TextStyle(fontSize: 16),
                    ),
                    if (completionPercentage == 100) // Felicitaciones al 100%
                      const Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          '🎉 ¡Felicidades! Has completado todos tus hábitos de hoy.',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                      ),
                  ],
                ),
              ),

              // Próximos hábitos/actividades
              const SizedBox(height: 10),
              const Text('Próximos hábitos:', style: TextStyle(fontSize: 20)),
              ...nextHabits.isEmpty
                  ? [
                      const ListTile(
                        leading: Icon(Icons.check_circle, color: Colors.green),
                        title: Text(
                          'No tienes más hábitos por completar hoy.',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ]
                  : nextHabits
                      .map(
                        (habit) => ListTile(
                          leading: const Icon(Icons.check_circle_outline),
                          title: Text(habit.name),
                          subtitle: Text(
                            '${habit.frequencyValue} ${capitalize(habit.frequencyUnit.toString().split('.').last)}',
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const HabitCompletionScreen(),
                              ),
                            );
                          },
                        ),
                      )
                      .toList(),

              // Botón para aumentar la racha
              ElevatedButton(
                onPressed: increaseStreak,
                child: const Text('Aumentar Racha'),
              ),
            ],
          ),

          // Botón de la tienda en la esquina inferior derecha
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
