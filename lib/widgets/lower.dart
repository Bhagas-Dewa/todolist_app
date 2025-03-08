import 'package:flutter/material.dart';
import 'package:flutter_application_todolist/home/allDone.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_application_todolist/providers/task_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_todolist/widgets/upper_task.dart';
import 'package:flutter_application_todolist/widgets/filter_bottomsheet.dart';
class Lower extends StatefulWidget {
  const Lower({super.key});

  @override
  State<Lower> createState() => _LowerState();
}

class _LowerState extends State<Lower> {
  final Set<int> _checkedTasks = {};

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Expanded(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
        ),
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),

              // Header (Today & Filter)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Today",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 2),
                        SvgPicture.asset(
                          'assets/indicator_today.svg',
                        ),
                      ],
                    ),
                    IconButton(
                      icon: SvgPicture.asset('assets/filter_today.svg', width: 30, height: 30),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => const ShowFilterBottomSheet(),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // List Task
              Expanded(
                child: Consumer<TaskProvider>(
                  builder: (context, taskProvider, child) {
                    final tasks = taskProvider.filteredTasks; 

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: tasks.length, // Pastikan itemCount sesuai dengan filteredTasks
                      itemBuilder: (context, index) {
                        final task = tasks[index]; // Gunakan task dari filteredTasks

                        return GestureDetector(
                          onTap: () {
                            final taskProvider = Provider.of<TaskProvider>(context, listen: false);
                            taskProvider.setEditingTask(index);

                            // Pastikan data terisi di inputan
                            taskProvider.titleController.text = task.name;
                            taskProvider.setSelectedTime(TimeOfDay(hour: task.hour, minute: task.minute));
                            taskProvider.setSelectedDate(task.deadline);

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const UpperTask()), //update task
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/task1.svg',
                                    width: 50,
                                    height: 50,
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          task.name,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        Row(
                                          children: [
                                            Text(
                                              "Deadline: ${task.deadline.day}/${task.deadline.month}/${task.deadline.year},",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              "${task.hour}:${task.minute.toString().padLeft(2, '0')} WIB",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Checkbox(
                                    shape: const CircleBorder(),
                                    value: task.isCompleted,
                                    activeColor: Colors.green,
                                    onChanged: (value) {
                                      if (value != null) {
                                        taskProvider.toggleTaskCompletion(index, () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(builder: (context) => AllDone()),
                                          );
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
