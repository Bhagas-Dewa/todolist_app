import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_todolist/home/home.dart';
import 'package:flutter_application_todolist/providers/task_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final taskProvider = TaskProvider();
  await taskProvider.loadTasks();
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskProvider(), 
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do List App',
      home: const Home(),
    );
  }
}
