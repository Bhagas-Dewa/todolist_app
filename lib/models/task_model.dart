class TaskModel {
  final String name;
  final int hour;
  final int minute;
  bool isCompleted;
  DateTime deadline;

  TaskModel(
    {
      required this.name, 
      required this.hour, 
      required this.minute,
      this.isCompleted = false,
      required this.deadline,
      }
  );

  // Convert TaskModel ke JSON (untuk disimpan di SharedPreferences)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'hour': hour,
      'minute': minute,
      'deadline': deadline.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }

  // Buat TaskModel dari JSON (untuk diambil dari SharedPreferences)
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      name: json['name'],
      hour: json['hour'],
      minute: json['minute'],
      deadline: DateTime.parse(json['deadline']),
      isCompleted: json['isCompleted'] ?? false,
    );
  }
}
