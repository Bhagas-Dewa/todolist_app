import 'package:flutter/material.dart';
import 'package:flutter_application_todolist/home/task/addTask.dart';
import 'package:flutter_application_todolist/home/appBar.dart';
import 'package:flutter_application_todolist/home/navBar.dart';
import 'package:flutter_application_todolist/home/content.dart';
import 'package:flutter_application_todolist/home/task/addTask.dart';
import 'package:flutter_application_todolist/providers/task_provider.dart';
import 'package:provider/provider.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4864EC),
      appBar: CustomAppBar(),
      bottomNavigationBar: CustomNavBar(),
      body: const Content(),

      // Floating Action Button 
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 8), 
        child: FloatingActionButton(
          onPressed: () {
            final taskProvider = Provider.of<TaskProvider>(context, listen: false);
            // final tasks = Provider.of<TaskProvider>(context).filteredTasks;

            
            taskProvider.clearEditingTask();
            taskProvider.setTaskName("");
            taskProvider.setSelectedTime(null);
            taskProvider.setSelectedDate(null);
            taskProvider.titleController.clear();

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BuildTask()),
            );
          },
          backgroundColor: const Color(0xFFFF7C54),
          child: const Icon(Icons.add, size: 28, color: Colors.white),
        ),
      ),

    );
  }
}
