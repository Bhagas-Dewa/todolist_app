import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_todolist/models/task_model.dart';

class TaskProvider with ChangeNotifier {
  final List<TaskModel> _tasks = []; // List untuk menyimpan semua task
  String _taskName = "";
  TimeOfDay? _selectedTime;
  DateTime? _selectedDate;
  TaskModel? _editingTask;
  int? _editingIndex;

  String _searchQuery = "";
  String get searchQuery => _searchQuery;

  DateTime? _startDate;
  DateTime? _endDate;


  // Getter
  String get taskName => _taskName;
  List<TaskModel> get tasks => _tasks;
  TimeOfDay? get selectedTime => _selectedTime;
  DateTime? get selectedDate => _selectedDate;
  TaskModel? get editingTask => _editingTask;
  int? get editingIndex => _editingIndex;
  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;

  
  // Controller untuk TextField input nama task
  TextEditingController titleController = TextEditingController();


void setStartDate(DateTime date) {
  _startDate = date;
  notifyListeners();
}

void setEndDate(DateTime date) {
  _endDate = date;
  notifyListeners();
}

void clearDateFilter() {
  _startDate = null;
  _endDate = null;
  notifyListeners();
}

// List<TaskModel> get filteredTasksByDate {
//   if (_startDate == null || _endDate == null) {
//     return _tasks; // Jika tidak ada filter tanggal, tampilkan semua task
//   }
//   return _tasks.where((task) {
//     return task.deadline.isAfter(_startDate!.subtract(Duration(days: 1))) &&
//            task.deadline.isBefore(_endDate!.add(Duration(days: 1)));
//   }).toList();
// }

List<TaskModel> get filteredTasks {
  List<TaskModel> filtered = _tasks;

  // Filter berdasarkan pencarian (jika ada)
  if (_searchQuery.isNotEmpty) {
    filtered = filtered
        .where((task) =>
            task.name.trim().toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  // Filter berdasarkan rentang tanggal (jika startDate dan endDate tidak null)
  if (_startDate != null && _endDate != null) {
    filtered = filtered.where((task) {
      return task.deadline.isAfter(_startDate!.subtract(const Duration(days: 1))) &&
             task.deadline.isBefore(_endDate!.add(const Duration(days: 1)));
    }).toList();
  }

  return filtered;
}


  // Fungsi Search Task
  void searchTask(String query) {
    _searchQuery = query;
    notifyListeners();
  }

//   List<TaskModel> get filteredTasks {
//   if (_searchQuery.isEmpty) {
//     return _tasks; // Jika tidak ada pencarian, tampilkan semua task
//   }
//   return _tasks.where((task) {
//     return task.name.trimLeft().toLowerCase().contains(_searchQuery);
//   }).toList();
// }

  // Constructor untuk load data saat aplikasi pertama kali dijalankan
  TaskProvider() {
    loadTasks();
  }

  //Memuat task dari SharedPreferences
  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? taskJsonList = prefs.getStringList('tasks');

    if (taskJsonList != null) {
      _tasks.clear();
      _tasks.addAll(taskJsonList.map((taskJson) => TaskModel.fromJson(jsonDecode(taskJson))).toList());
    }

    notifyListeners();
  }

  //Menyimpan task ke SharedPreferences
  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> taskJsonList = _tasks.map((task) => jsonEncode(task.toJson())).toList();
    await prefs.setStringList('tasks', taskJsonList);

    print("Tasks berhasil disimpan: $taskJsonList");
  }

  //Menyimpan tanggal yang dipilih oleh user
  void setSelectedDate(DateTime? date) { 
    _selectedDate = date;
    notifyListeners();
  }
  
  //Setter untuk mengubah nama task saat user mengetik di TextField
  void setTaskName(String name) {
    _taskName = name;
    notifyListeners();
  }

  //Menyimpan waktu yang dipilih oleh user
  void setSelectedTime(TimeOfDay? time) {
    _selectedTime = time ?? const TimeOfDay(hour: 0, minute: 0); // Jika null, set ke default 00:00
    notifyListeners();
  }

  //Tambahkan task baru
  void addTask(String name, int hour, int minute, DateTime selectedDate) {
    _tasks.insert(0, TaskModel(
      name: titleController.text, 
      hour: hour, 
      minute: minute, 
      deadline: selectedDate, 
      isCompleted: false,
    ));
    
    titleController.clear();
    saveTasks(); // Simpan ke local storage
    _resetFields(); // Reset input setelah menambahkan task
    notifyListeners();
  }

  //Perbarui nama task berdasarkan index
  void updateTaskName(int index, String newName) {
    if (index >= 0 && index < _tasks.length) {
      _tasks[index] = TaskModel(
        name: newName,
        hour: _tasks[index].hour,
        minute: _tasks[index].minute,
        deadline: _tasks[index].deadline,
        isCompleted: _tasks[index].isCompleted,
      );
      saveTasks(); // Simpan ke local storage
      notifyListeners();
    }
  }

  // 🔹 Perbarui waktu task berdasarkan index
  void updateTaskTime(int index, int hour, int minute) {
    if (index >= 0 && index < _tasks.length) {
      _tasks[index] = TaskModel(
        name: _tasks[index].name,
        hour: hour,
        minute: minute,
        deadline: _tasks[index].deadline, 
        isCompleted: _tasks[index].isCompleted,
      );
      saveTasks(); // Simpan ke local storage
      notifyListeners();
    }
  }

  // 🔹 Toggle (centang) task selesai atau tidak
  void toggleTaskCompletion(int index, VoidCallback onAllTasksCompleted) {
    if (index >= 0 && index < _tasks.length) {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
      notifyListeners();

      // Cek apakah semua task sudah dicentang (completed)
      bool allDone = _tasks.every((task) => task.isCompleted);

      if (allDone) {
        _tasks.clear(); // Hapus semua task jika semuanya sudah dicentang
        notifyListeners();
        onAllTasksCompleted(); // Panggil fungsi jika semua task selesai
      }

      saveTasks(); // Simpan perubahan ke local storage
    }
  }

  // 🔹 Hapus task berdasarkan index
  void removeTask(int index) {
    if (index >= 0 && index < _tasks.length) {
      _tasks.removeAt(index);
      saveTasks();
      notifyListeners();
    }
  }

  // 🔹 Setter untuk menyimpan task yang akan diedit
  void setEditingTask(int index) {
    _editingTask = _tasks[index];
    _editingIndex = index;
    _taskName = _editingTask!.name;
    _selectedTime = TimeOfDay(hour: _editingTask!.hour, minute: _editingTask!.minute);
    _selectedDate = _editingTask!.deadline;
    notifyListeners();
  }

  // 🔹 Reset mode edit
  void clearEditingTask() {
    _editingTask = null;
    _editingIndex = null;
    notifyListeners();
  }

  // 🔹 Update task yang sudah ada
  void updateTask(int index, String name, int hour, int minute, DateTime deadline) {
    if (index >= 0 && index < _tasks.length) {
      _tasks[index] = TaskModel(
        name: name,
        hour: hour,
        minute: minute,
        deadline: deadline,
        isCompleted: _tasks[index].isCompleted, // Tetap mempertahankan status checklist
      );
      saveTasks();
      notifyListeners();
    }
  }

  // 🔹 Reset input setelah menambah task baru
  void _resetFields() {
    _taskName = "";
    titleController.clear();
    _selectedTime = null;
    _selectedDate = null;
    notifyListeners();
  }
}
