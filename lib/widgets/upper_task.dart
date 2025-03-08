import 'package:flutter/material.dart';
import 'package:flutter_application_todolist/home/task/appBarTask.dart';
import 'package:flutter_application_todolist/widgets/lower_task.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_todolist/providers/task_provider.dart';

class UpperTask extends StatelessWidget {
  const UpperTask({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: CustomTaskAppBar(),
      body: SingleChildScrollView(
        child: Container(
        height: 725,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: taskProvider.titleController, // Gunakan controller dari Provider
                style: const TextStyle(
                  fontSize: 38,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: null,
                minLines: 1,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                onChanged: (value) {
                  taskProvider.setTaskName(value); // Pastikan task name diperbarui
                },
              ),
              const SizedBox(height: 4),
              const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer at turpis eu enim rhoncus sagittis.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 15),
              SvgPicture.asset(
                'assets/indicator_today.svg',
              ),
              const SizedBox(height: 20),
      
              // Detail Task
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
      
                          if (pickedDate != null) {
                            final taskProvider = Provider.of<TaskProvider>(context, listen: false);
                            taskProvider.setSelectedDate(pickedDate);
                          }
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/task_date.svg',
                              width: 32,
                              height: 32,
                            ),
                            const SizedBox(width: 12),
                            Consumer<TaskProvider>(
                              builder: (context, taskProvider, child) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      taskProvider.selectedDate != null
                                          ? "${taskProvider.selectedDate!.day}/${taskProvider.selectedDate!.month}/${taskProvider.selectedDate!.year}"
                                          : "Pilih Tanggal", 
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      'Date',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color.fromARGB(255, 195, 195, 195),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
      
                      
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/task_category.svg',
                            width: 32,
                            height: 32,
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Travel',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Category',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 195, 195, 195),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            // isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                            ),
                            builder: (context) => LowerTask(),
                          );
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/task_time.svg',
                              width: 32,
                              height: 32,
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  taskProvider.selectedTime != null
                                      ? '${taskProvider.selectedTime!.hour}:${taskProvider.selectedTime!.minute.toString().padLeft(2, '0')} WIB'
                                      : 'Pilih Waktu',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                              ),
                                Text(
                                  'Time',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 195, 195, 195),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
      
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/task_location.svg',
                            width: 32,
                            height: 32,
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Sukabumi',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Location',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 195, 195, 195),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ), SizedBox(height: 50),
             Consumer<TaskProvider>(
              builder: (context, taskProvider, child) {
            return GestureDetector(
              onTap: () {
                if (taskProvider.taskName.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Judul task tidak boleh kosong!"),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
            
                if (taskProvider.selectedTime == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Silakan pilih waktu!"),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
            
                if (taskProvider.selectedDate == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Silakan pilih tanggal deadline!"),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
            
                if (taskProvider.editingTask != null) {
                  // Jika sedang dalam mode edit, update task
                  taskProvider.updateTask(
                    taskProvider.editingIndex!,
                    taskProvider.taskName,
                    taskProvider.selectedTime!.hour,
                    taskProvider.selectedTime!.minute,
                    taskProvider.selectedDate!,
                  );
                  // taskProvider.clearEditingTask(); // Reset mode edit
                } else {
                  // Jika tidak dalam mode edit, tambahkan task baru
                  taskProvider.addTask(
                    taskProvider.taskName,
                    taskProvider.selectedTime!.hour,
                    taskProvider.selectedTime!.minute,
                    taskProvider.selectedDate!,
                  ); taskProvider.clearEditingTask();
                }
            
                // Reset form setelah menyimpan
                
                taskProvider.setTaskName("");
                taskProvider.setSelectedTime(null);
                taskProvider.setSelectedDate(null);
            
                Navigator.pop(context);
            
              },
              child: Center(
                child: Container(
                  width: 150,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xffFF7C54),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    taskProvider.editingTask == null ? "Tambah Task" : "Update Task",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
              },
            ),
      
        
      
            ],
          ),
        ),
      ),
      ),
      
    );
  }
}
