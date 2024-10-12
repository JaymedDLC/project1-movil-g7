/*class Habit {
  String name;
  String frequency;
  bool isActive;
  bool isCompleted;

  Habit({
    required this.name,
    required this.frequency,
    this.isActive = true,
    this.isCompleted = false,
  });

  void toggleCompleted() {
    isCompleted = !isCompleted;
  }

  void toggleActive() {
    isActive = !isActive;
  }
} */


class Habit {
  String name;
  String frequency;

  Habit({required this.name, required this.frequency});
}